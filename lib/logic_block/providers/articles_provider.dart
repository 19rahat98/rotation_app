import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rotation_app/logic_block/models/articles_model.dart';

import 'package:rotation_app/logic_block/models/result_api_model.dart';
import 'package:rotation_app/logic_block/repository/artilces_repository.dart';

class ArticlesProvider with ChangeNotifier {

  List<Articles> _articlesList = [];
  List<Articles> get articlesList => _articlesList;
  set articlesList(newVal) => _articlesList = newVal;

  MoreAboutArticle _article;
  MoreAboutArticle get article => _article;
  set article(newValue) => _article = newValue;

  List _filteredData = [];
  List get filteredData => _filteredData;
  set filteredData(newData) {
    _filteredData = newData;
  }

  final ArticlesListRepository articlesRepository = ArticlesListRepository();

  Future<Articles> getFirstArticle()async{
    if(_articlesList.isNotEmpty){
      for(int i = 0; i < _articlesList.length; i++){
        try{
          if(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inDays <= 1){
            if(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours <= 1){
              _articlesList[i].publishedOn = "только что";
              return _articlesList[i];
            }
            else if(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours > 1 && DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours < 24){
              _articlesList[i].publishedOn = "сегодня, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
              return _articlesList[i];
            }
            else{
              _articlesList[i].publishedOn = "вчера, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
              return _articlesList[i];
            }
          }
          else{
            _articlesList[i].publishedOn = "${DateFormat.MMMd('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
            return _articlesList[i];
          }
          //print(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedAt)).inDays);
        }catch(e){
          print(e);
          return _articlesList[i];
        }
      }
    }else{
      final ResponseApi result = await articlesRepository.articlesFromDB();
      final List decodeData = result.data['data'];
      if (result.code == 200) {
        Iterable _convertList = decodeData;
        _articlesList = _convertList.map((item) {
          return Articles.fromJson(item);
        }).toList();
        for(int i = 0; i < _articlesList.length; i++){
          if(_articlesList[i] != null){
            if(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inDays <= 1){
              if(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours <= 1){
                _articlesList[i].publishedOn = "только что";
                return _articlesList[i];
              }
              else if(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours > 1 && DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours < 24){
                _articlesList[i].publishedOn = "сегодня, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
                return _articlesList[i];
              }
              else{
                _articlesList[i].publishedOn = "вчера, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
                return _articlesList[i];
              }
            }
            else{
              _articlesList[i].publishedOn = "${DateFormat.MMMd('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
              return _articlesList[i];
            }
            //print(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedAt)).inDays);
          }
        }
      }
    }
  }

  Future<int> pageCount({int pageNumber, int perPage}) async{
    final ResponseApi result = await articlesRepository.articlesFromDB(pageNumber: pageNumber, perPage: perPage);
    final List decodeData = result.data['data'];
    if(decodeData != null){
      print(result.data);
      return result.data['last_page'];
    }
    else {
      return 1;
    }
  }


  Future<List<Articles>> getArticles({int pageNumber, int perPage}) async {
    final ResponseApi result = await articlesRepository.articlesFromDB(pageNumber: pageNumber, perPage: perPage);
    final List decodeData = result.data['data'];
    if (result.code == 200) {
      Iterable _convertList = decodeData;
      _articlesList = _convertList.map((item) {
        return Articles.fromJson(item);
      }).toList();
      for(int i = 0; i < _articlesList.length; i++){
        if(_articlesList[i] != null){
          if(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inDays <= 1){
            if(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours <= 1){
              _articlesList[i].publishedOn = "только что";
            }
            else if(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours > 1 && DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours < 24){
              _articlesList[i].publishedOn = "сегодня, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
            }
            else{
              _articlesList[i].publishedOn = "вчера, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
            }
          }
          else{
            _articlesList[i].publishedOn = "${DateFormat.MMMd('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString().replaceAll('.', ',')} в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
          }
          //print(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedAt)).inDays);
        }
      }
      notifyListeners();
      return _articlesList;
    }

    notifyListeners();
    return null;
  }

  Future<MoreAboutArticle> aboutMoreArticle({String articleId}) async {
    final result = await articlesRepository.aboutMore(id: articleId);
    if (result['code'] == 200 && result.isNotEmpty) {
      _article = MoreAboutArticle.fromJson(result['data']);
      notifyListeners();
      if(_article != null && _article.updatedAt != null){
        if(DateTime.now().difference(DateTime.parse(_article.updatedAt)).inDays <= 1){
          if(DateTime.now().difference(DateTime.parse(_article.updatedAt)).inHours <= 1){
            _article.updatedAt = "только что";
          }
          else if(DateTime.now().difference(DateTime.parse(_article.updatedAt)).inHours > 1 && DateTime.now().difference(DateTime.parse(_article.updatedAt)).inHours < 24){
            _article.updatedAt = "сегодня, в ${DateFormat.Hm('ru').format(DateTime.parse(_article.updatedAt)).toString()}";
          }
          else{
            _article.updatedAt = "вчера, в ${DateFormat.Hm('ru').format(DateTime.parse(_article.updatedAt)).toString()}";
          }
        }
        else{
          _article.updatedAt = "${DateFormat.MMMd('ru').format(DateTime.parse(_article.updatedAt)).toString().replaceAll('.', ',')} в ${DateFormat.Hm('ru').format(DateTime.parse(_article.updatedAt)).toString()}";
        }
        //print(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedAt)).inDays);
      }
      return _article;
    }
    notifyListeners();
    return null;
  }

  Future<bool> makeAsReadArticle({String articleId}) async{
    final ResponseApi result = await articlesRepository.markAsReadNews(id: articleId);
    if(result.code == 200){
      return true;
    }else{
      return false;
    }
  }

  afterSearch(value) {
    _filteredData = _articlesList
        .where((u) => (u.title.toLowerCase().contains(value.toLowerCase())))
        .toList();
    notifyListeners();
  }
}

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

  Future<List<Articles>> getArticles() async {
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
            }
            else if(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours > 1 && DateTime.now().difference(DateTime.parse(_articlesList[i].publishedOn)).inHours < 24){
              _articlesList[i].publishedOn = "сегодня, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
            }
            else{
              _articlesList[i].publishedOn = "вчера, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
            }
          }
          else{
            _articlesList[i].publishedOn = "${DateFormat.MMMd('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}, в ${DateFormat.Hm('ru').format(DateTime.parse(_articlesList[i].publishedOn)).toString()}";
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

  Future<MoreAboutArticle> aboutMoreArticle({int articleId}) async {
    final result =
        await articlesRepository.aboutMore(id: articleId);

    if (result['code'] == 200 && result.isNotEmpty) {
      _article = MoreAboutArticle.fromJson(result['data']);
      notifyListeners();
      if(_article != null){
        if(DateTime.now().difference(DateTime.parse(_article.publishedOn)).inDays <= 1){
          if(DateTime.now().difference(DateTime.parse(_article.publishedOn)).inHours <= 1){
            _article.publishedOn = "только что";
          }
          else if(DateTime.now().difference(DateTime.parse(_article.publishedOn)).inHours > 1 && DateTime.now().difference(DateTime.parse(_article.publishedOn)).inHours < 24){
            _article.publishedOn = "сегодня, в ${DateFormat.Hm('ru').format(DateTime.parse(_article.publishedOn)).toString()}";
          }
          else{
            _article.publishedOn = "вчера, в ${DateFormat.Hm('ru').format(DateTime.parse(_article.publishedOn)).toString()}";
          }
        }
        else{
          _article.publishedOn = "${DateFormat.MMMd('ru').format(DateTime.parse(_article.publishedOn)).toString()}, в ${DateFormat.Hm('ru').format(DateTime.parse(_article.publishedOn)).toString()}";
        }
        //print(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedAt)).inDays);
      }
      return _article;
    }
    notifyListeners();
    return null;
  }

  afterSearch(value) {
    _filteredData = _articlesList
        .where((u) => (u.title.toLowerCase().contains(value.toLowerCase())))
        .toList();
    notifyListeners();
  }
}

import 'dart:convert';
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
      notifyListeners();
      return _articlesList;
    }
    notifyListeners();
    return null;
  }

  Future<MoreAboutArticle> aboutMoreArticle({int articleId}) async {
    final ResponseApi result =
        await articlesRepository.aboutMore(id: articleId);
    if (result.code == 200) {
      _article = MoreAboutArticle.fromJson(result.data);
      notifyListeners();
      return _article;
    }
    notifyListeners();
    return null;
  }

  afterSearch(value) {
    _filteredData = _articlesList
        .where((u) => (u.title.toLowerCase().contains(value.toLowerCase()) ||
        u.shortContent.contains(value.toLowerCase())))
        .toList();
    notifyListeners();
  }
}

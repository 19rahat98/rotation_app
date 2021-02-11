import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:rotation_app/logic_block/models/questions_model.dart';
import 'package:rotation_app/logic_block/models/result_api_model.dart';
import 'package:rotation_app/logic_block/repository/question_repository.dart';

class QuestionProvider with ChangeNotifier {

  List<Questions> _data = [];
  List<Questions> get data => _data;
  set data(newVal) => _data = newVal;

  List<Questions> _filteredData = [];
  List<Questions> get filteredData => _filteredData;
  set filteredData(newData) {
    _filteredData = newData;
    notifyListeners();
  }

  final QuestionRepository questionRepository = QuestionRepository();

  Future<List<Questions>> getQuestions() async{
    final ResponseApi result = await questionRepository.questionsFromDB();
    final List decodeData = result.data;
    if(result.code == 200){
      Iterable _convertList = decodeData;
      _data = _convertList.map((item) {
        return Questions.fromJson(item);
      }).toList();
      notifyListeners();
      return _data;
    }
    notifyListeners();
    return null;
  }

  afterSearch(value) {
    _filteredData = _data
        .where((u) => (u.question.toLowerCase().contains(value.toLowerCase())))
        .toList();
    /*
     _filteredData = _data
        .where((u) => (u.question.toLowerCase().contains(value.toLowerCase()) ||
        u.answer.toLowerCase().contains(value.toLowerCase())))
        .toList();
    */
    notifyListeners();
  }

}

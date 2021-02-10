import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:rotation_app/logic_block/models/questions_model.dart';
import 'package:rotation_app/logic_block/models/rate_model.dart';
import 'package:rotation_app/logic_block/models/result_api_model.dart';
import 'package:rotation_app/logic_block/repository/conversation_rates_repository.dart';
import 'package:rotation_app/logic_block/repository/question_repository.dart';

class ConversationRatesProvider with ChangeNotifier {

  double _eur = 0.0;
  double get eur => _eur;
  set eur(newVal) => _eur = newVal;

  double _usd = 0.0;
  double get usd => _usd;
  set usd(newVal) => _usd = newVal;

  final ConversationRatesRepository questionRepository = ConversationRatesRepository();

  Future<double> getEUR() async{
    final ResponseApi result = await questionRepository.getEUR();
    final ResponseApi usdResult = await questionRepository.getUSD();
    final decodeData = result.data['conversion_rates'];
    final usdData = usdResult.data['conversion_rates'];
    if(result.code == 200){
      _eur = ConversionRates.fromJson(decodeData).kzt;
      _usd = ConversionRates.fromJson(usdData).kzt;
      notifyListeners();
      return _eur;
    }
    notifyListeners();
    return null;
  }

}

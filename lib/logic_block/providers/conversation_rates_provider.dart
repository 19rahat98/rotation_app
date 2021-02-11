import 'package:flutter/material.dart';

import 'package:rotation_app/logic_block/models/rate_model.dart';
import 'package:rotation_app/logic_block/models/result_api_model.dart';
import 'package:rotation_app/logic_block/repository/conversation_rates_repository.dart';

class ConversationRatesProvider with ChangeNotifier {

  double _eur = 0.0;
  double get eur => _eur;
  set eur(newVal) => _eur = newVal;

  double _usd = 0.0;
  double get usd => _usd;
  set usd(newVal) => _usd = newVal;

  final ConversationRatesRepository _questionRepository = ConversationRatesRepository();

  Future<bool> getExchangeRate() async{
    final _eurResult = await _questionRepository.getEUR();
    final _usdResult = await _questionRepository.getUSD();
    final euroData = _eurResult['conversion_rates'];
    final usdData = _usdResult['conversion_rates'];
    if(euroData != null && usdData != null){
      _eur = ConversionRates.fromJson(euroData).kzt;
      _usd = ConversionRates.fromJson(usdData).kzt;
      print(_eur);
      print(_usd);
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

}

import 'dart:async';

import 'package:rotation_app/logic_block/api/http_request.dart';
import 'package:rotation_app/logic_block/models/result_api_model.dart';


class Api {
  ///URL API
  static const String SEND_CODE_LOGIN = "/employees/send-code-login";
  //static const String LOGIN_BY_PHONE_NUMBER = "/employees/login";
  static const String LOGIN = "/employees/login";
  static const String FIND_EMPLOYEE_BY_IIN = "/employees/get-employee-by-iin";
  static const String UPDATE_PHONE_NUMBER = "/employees/send-code-update";
  static const String CONFIRMATION_PHONE_NUMBER = "/employees/confirm-phone-update";
  static const String RETRY_SEND_SMS_CODE = "/employees/retry-send-code";
  static const String GET_APPLICATION = "/employees/get-applications";


  static Future<dynamic> getApplication(params) async {
    final result = await httpManager.get(url: GET_APPLICATION, params: params);
    return ResponseApi.fromJson(result);
  }

  ///Login with phone number
  static Future<dynamic> loginByPhoneNumber(params) async {
    final result = await httpManager.post(url: SEND_CODE_LOGIN, data: params);
    print(result);
    return ResponseApi.fromJson(result);
  }


  ///Login api
  static Future<dynamic> sendCodeForLogin(params) async {
    final result = await httpManager.post(url: LOGIN, data: params);
    return ResponseApi.fromJson(result);
  }


  /*static Future<dynamic> loginByPhoneNumber(params) async {
    final result = await httpManager.post(url: LOGIN_BY_PHONE_NUMBER, data: params);
    return ResultApiModel.fromJson(result);
  }*/

  static Future<dynamic> searchEmployeeByIIN(params) async {
    final result = await httpManager.get(url: FIND_EMPLOYEE_BY_IIN, params: params);
    return ResponseApi.fromJson(result);
  }

  static Future<dynamic> updateEmployeePhoneNumber(params) async {
    final result = await httpManager.post(url: UPDATE_PHONE_NUMBER, data: params);
    return ResponseApi.fromJson(result);
  }

  static Future<dynamic> confirmPhoneNumber(params) async {
    final result = await httpManager.post(url: CONFIRMATION_PHONE_NUMBER, data: params);
    return ResponseApi.fromJson(result);
  }

  static Future<dynamic> retrySendSmsCode(params) async {
    final result = await httpManager.post(url: RETRY_SEND_SMS_CODE, data: params);
    return ResponseApi.fromJson(result);
  }


  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}

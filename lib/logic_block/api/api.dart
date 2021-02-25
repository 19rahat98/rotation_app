import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotation_app/logic_block/api/http_request.dart';
import 'package:rotation_app/logic_block/models/result_api_model.dart';


class Api {
  ///URL API
  static const String SEND_CODE_LOGIN = "/employees/send-code-login";
  static const String LOGIN = "/employees/login";
  static const String FIND_EMPLOYEE_BY_IIN = "/employees/get-employee-by-iin";
  static const String UPDATE_PHONE_NUMBER = "/employees/send-code-update";
  static const String CONFIRMATION_PHONE_NUMBER = "/employees/confirm-phone-update";
  static const String RETRY_SEND_SMS_CODE = "/employees/retry-send-code";
  static const String GET_APPLICATION = "/employees/get-applications";
  static const String GET_QUESTIONS = "/faqs";
  static const String GET_ARTICLES = "/articles";
  static const String GET_MORE_ABOUT_ARTICLE = "/articles/";
  static const String GET_CONVERSATION_EUR = "https://v6.exchangerate-api.com/v6/da783f775edf8a75a7afc001/latest/EUR";
  static const String GET_CONVERSATION_USD = "https://v6.exchangerate-api.com/v6/da783f775edf8a75a7afc001/latest/USD";
  static const String UPDATE_USER_DATA = "/employees/update-data";
  static const String GET_USER_INFO = "/employees/info";
  static const String UPDATE_USER_DOCUMENT = "/employees/update-document";
  static const String SEND_FMC_TOKEN = "/employees/fix";

  static Future<dynamic> sendFmcTokenToServer(params) async{
    final result = await httpManager.post(url: SEND_FMC_TOKEN, data: params);
    return ResponseApi.fromJson(result);
  }

  static Future<dynamic> updateUserDocument(params) async{
    final result = await httpManager.post(url: UPDATE_USER_DOCUMENT, data: params);
    return ResponseApi.fromJson(result);
  }

  static Future<dynamic> userInfo() async {
    final result = await httpManager.get(url: GET_USER_INFO);
    return ResponseApi.fromJson(result);
  }

  static Future<dynamic> updateUserData(params) async {
    final result = await httpManager.post(url: UPDATE_USER_DATA, data: params);
    return ResponseApi.fromJson(result);
  }

  static Future<dynamic> getConversationEUR() async{
    final result = await http.get(
      GET_CONVERSATION_EUR,
    );
    return Map<String, dynamic>.from(jsonDecode(result.body));
  }

  static Future<dynamic> getConversationUSD() async{
    final result = await http.get(
      GET_CONVERSATION_USD,
    );
    return Map<String, dynamic>.from(jsonDecode(result.body));
  }

  static Future<dynamic> aboutMoreArticle({int id}) async{
    final result = await httpManager.get(
        url: GET_MORE_ABOUT_ARTICLE + id.toString(),
    );
    return result;
  }

  static Future<dynamic> getArticlesList() async{
    final result = await httpManager.get(url: GET_ARTICLES);
    return ResponseApi.fromJson(result);
  }

  ///GET questions list
  static Future<dynamic> getQuestions() async{
    final result = await httpManager.get(url: GET_QUESTIONS);
    return ResponseApi.fromJson(result);
  }

  /// GET all data about trips and user
  static Future<dynamic> getApplication(params) async {
    final result = await httpManager.get(url: GET_APPLICATION, params: params);
    return ResponseApi.fromJson(result);
  }

  ///Login with phone number
  static Future<dynamic> loginByPhoneNumber(params) async {
    final result = await httpManager.post(url: SEND_CODE_LOGIN, data: params);
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

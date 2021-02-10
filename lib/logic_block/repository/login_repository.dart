import 'dart:convert';

import 'package:rotation_app/logic_block/api/api.dart';
import 'package:rotation_app/logic_block/models/user_model.dart';

class UserRepository {

  Future<dynamic> getUserInfo() async{
    return await Api.userInfo();
  }
  ///update usr data
  Future<dynamic> updateUserData(
      {String firstName,
      String lastName,
      String patronymic,
      DateTime birthDate,
      String iin,
      String gender,
      String countryCode}) async {
    Map<String, dynamic> params = {
      "first_name": firstName,
      "last_name": lastName,
      "patronymic": patronymic,
      "birth_date": birthDate,
      "gender": gender,
      "iin": iin,
      "country_code": countryCode,
    };
    return await Api.updateUserData(params);
  }

  ///Get all employee data
  Future<dynamic> getApplication() async {
    final params = {
      "page": 1,
      "per_page": 100,
    };
    return await Api.getApplication(params);
  }

  ///Fetch api login
  Future<dynamic> loginByPhoneNumber({String phoneNumber, String type}) async {
    final params = {"phone": phoneNumber, "type": type};
    return await Api.loginByPhoneNumber(params);
  }

  Future<dynamic> sendCodeForLogin({String phoneNumber, String type, String code, int authLogId}) async {
    final params = {
      "phone": phoneNumber,
      "code": code,
      "auth_log_id": authLogId,
      "type": type,
    };
    return await Api.sendCodeForLogin(params);
  }

  Future<dynamic> searchEmployeeByIIN({String iinNumber}) async {
    final params = {"iin": iinNumber,};
    return await Api.searchEmployeeByIIN(params);
  }


  Future<dynamic> updateEmployeePhoneNumber({String iinNumber, String phoneNumber, String type,}) async {
    final params = {
      "iin": iinNumber,
      "phone": phoneNumber,
      "type": type,
    };
    return await Api.updateEmployeePhoneNumber(params);
  }

  Future<dynamic> confirmPhoneNumber({String code, String phoneNumber, String type, int authLogId}) async {
    final params = {
      "code": code,
      "phone": phoneNumber,
      "auth_log_id": authLogId,
      "type": type,
    };
    return await Api.confirmPhoneNumber(params);
  }

  Future<dynamic> retrySendSmsCode({int authLogId}) async {
    final params = {
      "auth_log_id": authLogId,
    };
    return await Api.retrySendSmsCode(params);
  }

}

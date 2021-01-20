import 'dart:convert';

import 'package:rotation_app/config/Preferences_list.dart';
import 'package:rotation_app/config/util_preferences.dart';
import 'package:rotation_app/logic_block/api/api.dart';
import 'package:rotation_app/logic_block/models/user_model.dart';

class UserRepository {
  ///Fetch api login
  Future<dynamic> sendCodeLogin({String phoneNumber, String type}) async {
    final params = {"phone": phoneNumber, "type": type};
    return await Api.sendCodeLogin(params);
  }

  Future<dynamic> loginByPhoneNumber({String phoneNumber, String type, String code, int authLogId}) async {
    final params = {
      "phone": phoneNumber,
      "code": code,
      "auth_log_id": authLogId,
      "type": type,
    };
    return await Api.login(params);
  }

  Future<dynamic> findEmployeeByIIN({String iinNumber}) async {
    final params = {"iin": iinNumber,};
    return await Api.findEmployeeByIIN(params);
  }


  Future<dynamic> updateEmployeePhoneNumber({String iinNumber, String phoneNumber, String type,}) async {
    final params = {
      "iin": iinNumber,
      "phone": phoneNumber,
      "type": type,
    };
    return await Api.findEmployeeByIIN(params);
  }

  Future<dynamic> confirmPhoneNumber({String code, String phoneNumber, String type, int authLogId}) async {
    final params = {
      "code": code,
      "phone": phoneNumber,
      "auth_log_id": authLogId,
      "type": type,
    };
    return await Api.findEmployeeByIIN(params);
  }

  Future<dynamic> retrySendSmsCode({int authLogId}) async {
    final params = {
      "auth_log_id": authLogId,
    };
    return await Api.retrySendSmsCode(params);
  }


  ///Save Storage
  Future<dynamic> saveUser({String userToken}) async {
    return await UtilPreferences.setString(
      Preferences.userToken,
      userToken,
    );
  }

  ///Get from Storage
  dynamic getUserToken() {
    return UtilPreferences.getString(Preferences.userToken);
  }

  ///Delete Storage
  Future<dynamic> deleteUser() async {
    return await UtilPreferences.remove(Preferences.userToken);
  }
}

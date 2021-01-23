import 'dart:convert';

import 'package:rotation_app/logic_block/api/api.dart';
import 'package:rotation_app/logic_block/models/user_model.dart';

class UserRepository {


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


/*  ///Save Storage
  Future<dynamic> saveEmployeeData({String employee}) async{
    print('saveEmployeeDatas');
    return await UtilPreferences.setString(Preferences.employee, employee);
  }

  Future<dynamic> saveEmployeeToken({String userToken}) async{
    print('saveEmployeeData');
    return await UtilPreferences.setString(
      Preferences.userToken,
      userToken,
    );
  }

  ///Get from Storage
  dynamic getEmployeeToken() {
    print('getEmployeeToken');
    return UtilPreferences.getString(Preferences.userToken);
  }

  ///Get from Storage
  dynamic getEmployeeData() {
    print('getEmployeeData');
    return UtilPreferences.getString(Preferences.employee);
  }

  ///Delete Storage
  Future<dynamic> deleteEmployeeData() async {
    print('deleteEmployeeData');
    await UtilPreferences.remove(Preferences.employee);
    return await UtilPreferences.remove(Preferences.userToken);
  }*/
}

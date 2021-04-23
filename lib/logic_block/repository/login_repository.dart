import 'dart:convert';

import 'package:rotation_app/logic_block/api/api.dart';
import 'package:rotation_app/logic_block/models/user_model.dart';

class UserRepository {

  Future<dynamic> updateUserDocument(
      {String type,
        String number,
        DateTime issueDate,
        DateTime expireDate,
        String issueBy,
      }) async {
    Map<String, dynamic> params = {
      "type": type,
      "number": number,
      "issue_date": issueDate,
      "expire_date": expireDate,
      "issue_by": issueBy,
    };
    return await Api.updateUserDocument(params);
  }

  Future<dynamic> getUserInfo() async{
    return await Api.userInfo();
  }

  Future<dynamic> getEmployeeDocuments() async{
    return await Api.getEmployeeDocuments();
  }

  Future<dynamic> logoutEmployee() async{
    return await Api.logoutEmployee();
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
  Future<dynamic> getApplication({String applicationId, int pageNumber, int perPage}) async {
    if(applicationId != null ){
      final params = {
        "page": pageNumber != null ? pageNumber : 1,
        "per_page": perPage != null ? perPage : 10,
        "application_id": applicationId,
      };
      return await Api.getApplication(params);
    }else{
      final params = {
        "page": pageNumber != null ? pageNumber : 1,
        "per_page": perPage != null ? perPage : 10,
        "order_dir": "desc",
        "order_by": "id",
      };
      return await Api.getApplication(params);
    }
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

  Future<dynamic> updatePhoneNumber({String iinNumber, String phoneNumber, String firstName, String lastName, String employeeId, String employeeNumber}) async {
    final params = {
      "iin": iinNumber,
      "phone_number": phoneNumber,
      "first_name": firstName,
      "last_name": lastName,
      "employee_id": employeeId,
      "employee_number": employeeNumber,
    };
    return await Api.updatePhoneNumber(params);
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

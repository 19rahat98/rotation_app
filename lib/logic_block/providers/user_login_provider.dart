import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:rotation_app/logic_block/api/http_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rotation_app/logic_block/models/result_api_model.dart';
import 'package:rotation_app/logic_block/models/user_model.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/repository/login_repository.dart';

enum Status {
  EmployeeFind,
  SuccessLogin,
  FirstStepSuccessful,
  SecondStepSuccessful,
  EmployeeFound,
  NotRegistered,
  Authenticating,
  EmployeeNotFound,
  EmployeeDismissed,
  TooManyRequest,
  LoginFail
}

class UserLoginProvider with ChangeNotifier {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final UserRepository userRepository = UserRepository();

  String _token;
  String get token => _token;
  set token(String tokenCode) => _token = token;

  String _userPhoneNumber;
  String get userPhoneNumber => _userPhoneNumber;
  set userPhoneNumber(String number) {
    _userPhoneNumber = number;
    notifyListeners();
  }

  Employee _employee;
  Employee get employee => _employee;
  set employee(Employee employeeData) => _employee = employee;

  String _errorMessage;
  String get errorMessage => _errorMessage;
  set errorMessage(String error) => _errorMessage = errorMessage;

  Status _status = Status.NotRegistered;
  Status get status => _status;
  set status(statusType) => _status = statusType;

  int _authLogId;
  int get authLogId => _authLogId;
  set authLogId(int lodId) => _authLogId = authLogId;

  String _userIIN;
  String get userIIN => _userIIN;
  set userIIN(String iin) => _userIIN = userIIN;

  UserLoginProvider(){
    _sendDeviceId();
  }

  _sendDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      httpManager.baseOptions.headers["deviceID"] =  iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      httpManager.baseOptions.headers["deviceID"] =  androidDeviceInfo.androidId;
    }
  }

  Future saveDataToSP() async{
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("userToken", _token);
    httpManager.baseOptions.headers["Authorization"] =
        "Bearer " + _token;
    await prefs.setString("employee", jsonEncode(_employee));
    await prefs.setString("phoneNumber", _userPhoneNumber);
    return await prefs.setString("phoneNumber", _userPhoneNumber);
  }

  Future<Status> sendSmsCodeForIIN({String smsCode}) async {
    final ResponseApi result = await userRepository.confirmPhoneNumber(
        phoneNumber: _userPhoneNumber,
        type: "test",
        authLogId: _authLogId,
        code: smsCode);
    final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);

    try {
      if (result.code == 200) {
        _token = decodeData.data["token"];
        _employee = Employee.fromJson(decodeData.data["employee"]);
        httpManager.baseOptions.headers["Authorization"] =
            "Bearer " + _token;
        _status = Status.SuccessLogin;
        notifyListeners();
      } else if (result.code == 400) {
        if (decodeData.slug == "incorrect_data") {
          _status = Status.LoginFail;
          _errorMessage = decodeData.message;
          notifyListeners();
        } else if (decodeData.slug == "code_is_expired") {
          _errorMessage = decodeData.message;
          _status = Status.LoginFail;
          notifyListeners();
        }
      } else if (result.code == 429) {
        _status = Status.TooManyRequest;
        _errorMessage = decodeData.message;
        notifyListeners();
      } else {
        _errorMessage = decodeData.message;
        _status = Status.LoginFail;
        notifyListeners();
      }
    } catch (e) {
      _status = Status.LoginFail;
      _errorMessage = decodeData.message;
      notifyListeners();
    }
    return _status;
  }

  Future<Status> updatePhoneNumber({String phone}) async {
    final ResponseApi result = await userRepository.updateEmployeePhoneNumber(
        iinNumber: _userIIN, phoneNumber: phone, type: "test");
    final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);
    _userPhoneNumber = phone;
    notifyListeners();

    try {
      if (result.code == 200) {
        _status = Status.SecondStepSuccessful;
        _authLogId = decodeData.data["auth_log_id"];
        notifyListeners();
      } else if (result.code == 400) {
        if (decodeData.slug == "employee_not_found") {
          _status = Status.EmployeeNotFound;
          _errorMessage = decodeData.message;
          notifyListeners();
        } else if (decodeData.slug == "code_is_expired") {
          _errorMessage = decodeData.message;
          _status = Status.LoginFail;
          notifyListeners();
        } else if (decodeData.slug == "employee_dismissed") {
          _errorMessage = decodeData.message;
          _status = Status.EmployeeDismissed;
          notifyListeners();
        }
      } else if (result.code == 429) {
        _status = Status.TooManyRequest;
        _errorMessage = decodeData.message;
        notifyListeners();
      } else {
        _errorMessage = decodeData.message;
        _status = Status.LoginFail;
        notifyListeners();
      }
    } catch (e) {
      _status = Status.LoginFail;
      _errorMessage = decodeData.message;
      notifyListeners();
    }
    return _status;
  }

  Future<Status> searchEmployeeByIin({String iin}) async {
    final ResponseApi result =
        await userRepository.searchEmployeeByIIN(iinNumber: iin);
    final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);
    _userIIN = iin;
    notifyListeners();

    try {
      if (result.code == 200) {
        _status = Status.EmployeeFind;
        _employee = Employee.fromJson(decodeData.data["employee"]);
        notifyListeners();
      } else if (result.code == 400) {
        if (decodeData.slug == "employee_not_found") {
          _status = Status.EmployeeNotFound;
          _errorMessage = decodeData.message;
          notifyListeners();
        } else if (decodeData.slug == "code_is_expired") {
          _errorMessage = decodeData.message;
          _status = Status.LoginFail;
          notifyListeners();
        } else if (decodeData.slug == "employee_dismissed") {
          _errorMessage = decodeData.message;
          _status = Status.EmployeeDismissed;
          notifyListeners();
        }
      } else if (result.code == 429) {
        _status = Status.TooManyRequest;
        _errorMessage = decodeData.message;
        notifyListeners();
      } else {
        _errorMessage = decodeData.message;
        _status = Status.LoginFail;
        notifyListeners();
      }
    } catch (e) {
      _status = Status.LoginFail;
      _errorMessage = decodeData.message;
      notifyListeners();
    }
    return _status;
  }

  Future<void> retrySendSmsCode() async {
    final ResponseApi result =
        await userRepository.retrySendSmsCode(authLogId: _authLogId);
  }

  Future<Status> sendSmsCode({String smsCode}) async {
    final ResponseApi result = await userRepository.sendCodeForLogin(
        phoneNumber: _userPhoneNumber,
        type: "test",
        authLogId: _authLogId,
        code: smsCode);
    final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);
    try {
      if (result.code == 200) {
        _token = decodeData.data["token"];
        _employee = Employee.fromJson(decodeData.data["employee"]);
        httpManager.baseOptions.headers["Authorization"] =
            "Bearer " + _token;
        _status = Status.SuccessLogin;
        notifyListeners();
      } else if (result.code == 400) {
        if (decodeData.slug == "incorrect_data") {
          _status = Status.LoginFail;
          _errorMessage = decodeData.message;
          notifyListeners();
        } else if (decodeData.slug == "code_is_expired") {
          _errorMessage = decodeData.message;
          _status = Status.LoginFail;
          notifyListeners();
        }
      } else if (result.code == 429) {
        _status = Status.TooManyRequest;
        _errorMessage = decodeData.message;
        notifyListeners();
      } else {
        _errorMessage = decodeData.message;
        _status = Status.LoginFail;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _status = Status.LoginFail;
      _errorMessage = decodeData.message;
      notifyListeners();
    }
    return _status;
  }

  Future<Status> signInByPhoneNumber(String phoneNumber) async {
    final ResponseApi result = await userRepository.loginByPhoneNumber(
        phoneNumber: phoneNumber, type: "test");
    final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);
    _userPhoneNumber = phoneNumber;
    try {
      if (result.code == 200) {
        _status = Status.FirstStepSuccessful;
        _authLogId = decodeData.data["auth_log_id"];
        notifyListeners();
      } else if (result.code == 400) {
        if (decodeData.slug == "employee_dismissed") {
          _status = Status.EmployeeDismissed;
          notifyListeners();
        } else if (decodeData.slug == "employee_not_found") {
          _status = Status.EmployeeNotFound;
          notifyListeners();
        }
      } else if (result.code == 429) {
        _status = Status.TooManyRequest;
        _errorMessage = decodeData.message;
        notifyListeners();
      } else {
        _errorMessage = decodeData.message;
        _status = Status.LoginFail;
        notifyListeners();
      }
    } catch (e) {
      _status = Status.LoginFail;
      _errorMessage = decodeData.message;
      notifyListeners();
    }
    return _status;
  }

}

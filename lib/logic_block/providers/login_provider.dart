import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rotation_app/logic_block/models/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rotation_app/logic_block/api/http_request.dart';
import 'package:rotation_app/logic_block/models/user_model.dart';
import 'package:rotation_app/logic_block/models/result_api_model.dart';
import 'package:rotation_app/logic_block/repository/login_repository.dart';

class LoginProvider with ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final UserRepository userRepository = UserRepository();

  List<Application> _data = [];
  List<Application> get data => _data;
  set data(newVal) => _data = newVal;

  Employee _employee;
  Employee get employee => _employee;
  set employee(Employee employeeData) => _employee = employee;

  String _token;
  String get token => _token;
  set token(String tokenCode) => _token = token;

  String _userPhoneNumber;
  String get userPhoneNumber => _userPhoneNumber;
  set userPhoneNumber(String tokenCode) => _userPhoneNumber = userPhoneNumber;

/*  bool _isSignedIn;
  bool get isSignedIn => _isSignedIn;
  set isSignedIn(bool isSigned) => _isSignedIn = isSignedIn;*/

  LoginProvider() {
    checkSignIn();
  }

  Future<bool> checkSignIn() async {
    final SharedPreferences prefs = await _prefs;
    final hasUser = prefs.getString("userToken");

    if (hasUser != null) {
      httpManager.baseOptions.headers["Authorization"] = "Bearer " + hasUser;
      getEmployeeData();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

   Future<List<Application>> getEmployeeApplication() async{
    final ResponseApi result = await userRepository.getApplication();
    final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);
    if(result.code == 200){
      Iterable _convertList = decodeData.data["data"];
      _data = _convertList.map((item) {
        return Application.fromJson(item);
      }).toList();
      notifyListeners();
      return _data;
    }
    notifyListeners();
    return null;
  }

  Future<Employee> getEmployeeData() async {
    final SharedPreferences prefs = await _prefs;
    final hasUser = prefs.getString("employee");
    if (hasUser != null) {
      _employee = Employee.fromJson(jsonDecode(hasUser));
      notifyListeners();
      return _employee;
    } else
      return null;
  }

  Future<String> getEmployeeToken() async {
    final SharedPreferences prefs = await _prefs;
    final hasUser = prefs.getString("userToken");
    if (hasUser != null) {
      _token = hasUser;
      notifyListeners();
      return _token;
    } else
      return null;
  }

  Future<String> getEmployeePhoneNumber() async {
    final SharedPreferences prefs = await _prefs;
    final hasUser = prefs.getString("phoneNumber");
    if (hasUser != null) {
      _userPhoneNumber = hasUser;
      notifyListeners();
      return _userPhoneNumber;
    } else
      return null;
  }

  Future<bool> deleteEmployeeData() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove("phoneNumber");
    await prefs.remove("userToken");
    return await prefs.remove("employee");
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
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

/*bool _isSignedIn;
  bool get isSignedIn => _isSignedIn;
  set isSignedIn(bool isSigned) => _isSignedIn = isSignedIn;*/

  LoginProvider() {
    checkSignIn();
  }

  Future<bool> getUserInfo() async{
    final SharedPreferences prefs = await _prefs;
    final ResponseApi result = await userRepository.getUserInfo();
    if(result.code == 200){
      _employee = Employee.fromJson(Map<String, dynamic>.from(result.data));
      final spResult = await prefs.setString("employee", jsonEncode(_employee));
      if(spResult) return true;
      else return false;
    }else return false;
  }

  Future<bool> checkSignIn() async {
    final SharedPreferences prefs = await _prefs;
    final hasUser = prefs.getString("userToken");
    if (hasUser != null) {
      httpManager.baseOptions.headers["Authorization"] = "Bearer " + hasUser;
      notifyListeners();
      final ResponseApi result = await userRepository.getApplication();
      if (result.code != 200)
        return false;
      else
        return true;
    } else {
      return false;
    }
  }

  Future<List<Application>> getEmployeeApplication() async {
    print('asdasdadsaqd');
    final ResponseApi result = await userRepository.getApplication();
    final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);
    if (result.code == 200) {
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

  Future<bool> updateUserData(
      {String firstName,
      String lastName,
      String patronymic,
      DateTime birthDate,
      String iin,
      String gender,
      String countryCode}) async {
    final ResponseApi result = await userRepository.updateUserData(
        firstName: firstName,
        lastName: lastName,
        patronymic: patronymic,
        birthDate: birthDate,
        countryCode: countryCode,
        iin: iin,
        gender: gender,
    );
    if (result.code == 200) {
      return true;
    } else
      return false;
  }

  Future<bool> updateUserDocument(
        {String type,
        String number,
        DateTime issueDate,
        DateTime expireDate,
        String issueBy,
      }) async {
    final ResponseApi result = await userRepository.updateUserDocument(
      type: type,
      number: number,
      issueBy: issueBy,
      expireDate: expireDate,
      issueDate: issueDate,
    );
    if (result.code == 200) {
      return true;
    } else
      return false;
  }

}

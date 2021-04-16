import 'dart:math';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:rotation_app/logic_block/models/user_documents.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rotation_app/logic_block/api/http_request.dart';
import 'package:rotation_app/logic_block/models/user_model.dart';
import 'package:rotation_app/logic_block/models/result_api_model.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
import 'package:rotation_app/logic_block/repository/login_repository.dart';

class LoginProvider with ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final UserRepository userRepository = UserRepository();

  List<Application> _data = [];
  List<Application> get data => _data;
  set data(newVal) => _data = newVal;

  List<Documents> _employeeDocuments = [];
  List<Documents> get employeeDocuments => _employeeDocuments;
  set employeeDocuments(newVal) => _employeeDocuments = newVal;

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

  /*LoginProvider() {
    checkSignIn();
  }*/

  _sendDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      httpManager.baseOptions.headers["deviceid"] =  iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      httpManager.baseOptions.headers["deviceid"] =  androidDeviceInfo.androidId;
    }
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

  Future<List<Documents>> getEmployeeDocuments() async{
    final ResponseApi result = await userRepository.getEmployeeDocuments();
    if(result.code == 200){
      Iterable _convertList = result.data["documents"];
      _employeeDocuments = _convertList.map((item) {
        return Documents.fromJson(item);
      }).toList();
      notifyListeners();
      return _employeeDocuments;
    }
    else {
      return null;
    }
  }

  Future<bool> checkSignIn() async {
    final SharedPreferences prefs = await _prefs;
    final hasUser = prefs.getString("userToken");
    if (hasUser != null) {
      await _sendDeviceId();
      httpManager.baseOptions.headers["Authorization"] = "Bearer " + hasUser;
      notifyListeners();
      final ResponseApi result = await userRepository.getApplication();
      if (result.code == 200)
        return true;
      else
        return false;
    } else {
      return false;
    }
  }

  Future<Application> findApplicationById(String applicationId) async{
    print(applicationId);
    if (_data != null && _data.isNotEmpty) {
      for(Application item in _data){
        if(item.id == int.parse(applicationId)){
          return item;
        }
      }
      final ResponseApi result = await userRepository.getApplication(applicationId: applicationId);
      final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);
      if (result.code == 200) {
        return Application.fromJson( decodeData.data["data"][0]);
      }
      return null;
    }
    return null;
  }

  Future<bool> logoutUser() async{
    final ResponseApi result = await userRepository.logoutEmployee();
    if(result.code == 200) return true;
    else return false;
  }

  Map<dynamic, dynamic> getStatusApplication(Application item){
    Map statusCode = Map();
    if(item.segments != null && item.segments.isNotEmpty){
      for(int i = 0; i < item.segments.length; i++){
        if(item.status == "opened" ){
          if(item.segments[i].status == "opened" && (item.segments[i].activeProcess == null || item.segments[i].activeProcess == "booking")){
            if (statusCode.containsKey('grey')) {
              statusCode.update('grey', (int) => statusCode['grey'] + 1);
            }else{
              statusCode["grey"] = 1;
            }
          }
          else if(item.segments[i].activeProcess == 'watching'){
            if (statusCode.containsKey('yellow')) {
              statusCode.update('yellow', (int) => statusCode['yellow']+1);
            }else{
              statusCode["yellow"] = 1;
            }
          }
          else if(item.segments[i].status == 'issued'){
            if (statusCode.containsKey('green')) {
              statusCode.update('red', (int) => statusCode['green']+1);
            }else{
              statusCode["green"] = 1;
            }
          }
          else if(item.segments[i].status == 'returned'){
            if (statusCode.containsKey('red')) {
              statusCode.update('red', (int) => statusCode['red']+1);
            }else{
              statusCode["red"] = 1;
            }
          }else if(item.segments[i].status == 'canceled'){
            if (statusCode.containsKey('canceled')) {
              statusCode.update('canceled', (int) => statusCode['canceled']+1);
            }else{
              statusCode.addAll({"canceled": 1});
            }
          }
        }
        else if(item.status == 'returned'){
          if((item.segments[i].status == "opened" ) && item.segments[i].activeProcess == null){
            if (statusCode.containsKey('grey')) {
              statusCode.update('grey', (int) => statusCode['grey']+1);
            }else{
              statusCode.addAll({"grey": 1});
            }
          }
          else if(item.segments[i].activeProcess == 'watching'){
            if (statusCode.containsKey('yellow')) {
              statusCode.update('yellow', (int) => statusCode['yellow']+1);
            }else{
              statusCode.addAll({"yellow": 1});
            }
          }
          else if(item.segments[i].status == 'issued'){
            if (statusCode.containsKey('green')) {
              statusCode.update('red', (int) => statusCode['green']+1);
            }else{
              statusCode.addAll({"green": 1});
            }
          }
          else if(item.segments[i].status == 'returned'){
            if (statusCode.containsKey('red')) {
              statusCode.update('red', (int) => statusCode['red']+1);
            }else{
              statusCode.addAll({"red": 1});
            }
          }
          else if(item.segments[i].status == 'canceled'){
            if (statusCode.containsKey('canceled')) {
              statusCode.update('canceled', (int) => statusCode['canceled']+1);
            }else{
              statusCode.addAll({"canceled": 1});
            }
          }
        }
        else if(item.status == 'partly'){
          if(item.segments[i].status == "opened" && item.segments[i].activeProcess == null){
            if (statusCode.containsKey('grey')) {
              statusCode.update('grey', (int) => statusCode['grey']+1);
            }else{
              statusCode.addAll({"grey": 1});
            }
          }
          else if(item.segments[i].activeProcess == 'watching'){
            if (statusCode.containsKey('yellow')) {
              statusCode.update('yellow', (int) => statusCode['yellow']+1);
            }else{
              statusCode.addAll({"yellow": 1});
            }
          }
          else if(item.segments[i].status == 'issued'){
            if (statusCode.containsKey('green')) {
              statusCode.update('red', (int) => statusCode['green']+1);
            }else{
              statusCode.addAll({"green": 1});
            }
          }
          else if(item.segments[i].status == 'returned'){
            if (statusCode.containsKey('red')) {
              statusCode.update('red', (int) => statusCode['red']+1);
            }else{
              statusCode.addAll({"red": 1});
            }
          }
          else if(item.segments[i].status == 'canceled'){
            if (statusCode.containsKey('canceled')) {
              statusCode.update('canceled', (int) => statusCode['canceled']+1);
            }else{
              statusCode.addAll({"canceled": 1});
            }
          }
        }
        else if(item.status == 'issued'){
          if(item.segments[i].status == "opened" && item.segments[i].activeProcess == null){
            if (statusCode.containsKey('grey')) {
              statusCode.update('grey', (int) => statusCode['grey']+1);
            }else{
              statusCode["grey"] = 1;
            }
          }
          else if(item.segments[i].activeProcess == 'watching'){
            if (statusCode.containsKey('yellow')) {
              statusCode.update('yellow', (int) => statusCode['yellow']+1);
            }else{
              statusCode["yellow"] = 1;
            }
          }
          else if(item.segments[i].status == 'issued'){
            if (statusCode.containsKey('green')) {
              statusCode.update('green', (int) => statusCode['green']+1);
            }else{
              statusCode["green"] = 1;
            }
          }
          else if(item.segments[i].status == 'returned' ){
            if (statusCode.containsKey('red')) {
              statusCode.update('red', (int) => statusCode['red']+1);
            }else{
              statusCode["red"] = 1;
            }
          }
          else if(item.segments[i].status == 'canceled'){
            if (statusCode.containsKey('canceled')) {
              statusCode.update('canceled', (int) => statusCode['canceled']+1);
            }else{
              statusCode.addAll({"canceled": 1});
            }
          }
        }
        else if(item.status == 'canceled'){
          if(item.segments[i].status == "opened" && item.segments[i].activeProcess == null){
            if (statusCode.containsKey('grey')) {
              statusCode.update('grey', (int) => statusCode['grey']+1);
            }else{
              statusCode["grey"] = 1;
            }
          }
          else if(item.segments[i].activeProcess == 'watching'){
            if (statusCode.containsKey('yellow')) {
              statusCode.update('yellow', (int) => statusCode['yellow']+1);
            }else{
              statusCode["yellow"] = 1;
            }
          }
          else if(item.segments[i].status == 'issued'){
            if (statusCode.containsKey('green')) {
              statusCode.update('red', (int) => statusCode['green']+1);
            }else{
              statusCode["green"] = 1;
            }
          }
          else if(item.segments[i].status == 'returned' ){
            if (statusCode.containsKey('red')) {
              statusCode.update('red', (int) => statusCode['red']+1);
            }else{
              statusCode["red"] = 1;
            }
          }
          else if(item.segments[i].status == 'canceled'){
            if (statusCode.containsKey('canceled')) {
              statusCode.update('canceled', (int) => statusCode['canceled']+1);
            }else{
              statusCode.addAll({"canceled": 1});
            }
          }
        }
      }
      return statusCode;
    }
    else if(item.status == 'opened' && item.segments.isEmpty){
      statusCode = {'all' : 0};
      return statusCode;
    }
    else{
      return null;
    }
  }

  Future<List<Application>> getNewEmployeeApplicationData() async {
    await _sendDeviceId();
    final ResponseApi result = await userRepository.getApplication();
    final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);
    if (result.code == 200) {
      Iterable _convertList = decodeData.data["data"];
      _data = _convertList.map((item) {
        return Application.fromJson(item);
      }).toList();
      notifyListeners();
      for(int i = 0; i < _data.length; i ++){
        _data[i].applicationStatus = getStatusApplication(_data[i]);
      }
      return _data;
    }
    return null;
  }

  Future<List<Application>> getEmployeeApplication() async {
    if(_data.isEmpty){
      await _sendDeviceId();
      final ResponseApi result = await userRepository.getApplication();
      final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);
      if (result.code == 200) {
        Iterable _convertList = decodeData.data["data"];
        _data = _convertList.map((item) {
          return Application.fromJson(item);
        }).toList();
        notifyListeners();
        for(int i = 0; i < _data.length; i ++){
          _data[i].applicationStatus = getStatusApplication(_data[i]);
        }
        return _data;
      }
      else return null;
    }
    else return _data;
    //return null;
  }

  Future<Employee> getEmployeeData() async {
    await _sendDeviceId();
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
    httpManager.baseOptions.headers['Authorization'] = null;
    print('Authorization');
    print(httpManager.baseOptions.headers['Authorization']);
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

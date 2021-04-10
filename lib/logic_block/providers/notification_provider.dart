import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:rotation_app/logic_block/api/http_request.dart';
import 'package:rotation_app/logic_block/models/result_api_model.dart';
import 'package:rotation_app/logic_block/models/notification_model.dart';
import 'package:rotation_app/logic_block/repository/firebase_messaging_push_notification_repository.dart';

class NotificationProvider with ChangeNotifier{
  final FmcNotificationProvider fmcNotificationProvider = FmcNotificationProvider();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  FirebaseMessaging fcm = FirebaseMessaging();
  SharedPreferences prefs;

  List<NotificationData> _data = [];
  List<NotificationData> get data => _data;
  set data(newVal) => _data = newVal;

  NotificationProvider(){
    _saveDeviceToken();
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


  Future<NotificationData> getFirstNotificationFromDB() async{
    if(_data.isNotEmpty){
      for(int i = 0; i < _data.length; i++){
        if(_data[i].data.body.type == 'application' || _data[i].data.body.type == 'ticket'){
          try{
            if(DateTime.now().difference(DateTime.parse(_data[i].createdAt)).inDays <= 1){
              if(DateTime.now().difference(DateTime.parse(_data[i].createdAt)).inHours <= 1){
                _data[i].createdAt = "только что";
                return _data[i];
              }
              else if(DateTime.now().difference(DateTime.parse(_data[i].createdAt)).inHours > 1 && DateTime.now().difference(DateTime.parse(_data[i].createdAt)).inHours < 24){
                _data[i].createdAt = "сегодня, в ${DateFormat.Hm('ru').format(DateTime.parse(_data[i].createdAt)).toString()}";
                return _data[i];
              }
              else{
                _data[i].createdAt = "вчера, в ${DateFormat.Hm('ru').format(DateTime.parse(_data[i].createdAt)).toString()}";
                return _data[i];
              }
            }
            else{
              _data[i].createdAt = "${DateFormat.MMMd('ru').format(DateTime.parse(_data[i].createdAt)).toString()}, в ${DateFormat.Hm('ru').format(DateTime.parse(_data[i].createdAt)).toString()}";
              return _data[i];
            }
            //print(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedAt)).inDays);
          }
          catch(e){
            print(e);
            return _data[i];
          }
        }
      }
    }
    else{
      final ResponseApi result = await fmcNotificationProvider.getNotificationList();
      final List decodeData = result.data['data'];
      if(result.code == 200){
        try{
          Iterable _convertList = decodeData;
          final listData = _convertList.map((item){
            return NotificationData.fromJson(item);
          }).toList();
          for(int i = 0; i < listData.length; i++){
            if(listData[i].data.body.type == 'application' || listData[i].data.body.type == 'ticket'){
              if(listData[i] != null && listData[i].createdAt != null){
                if(DateTime.now().difference(DateTime.parse(listData[i].createdAt)).inDays <= 1){
                  if(DateTime.now().difference(DateTime.parse(listData[i].createdAt)).inHours <= 1){
                    listData[i].createdAt = "только что";
                    return listData[i];
                  }
                  else if(DateTime.now().difference(DateTime.parse(listData[i].createdAt)).inHours > 1 && DateTime.now().difference(DateTime.parse(listData[i].createdAt)).inHours < 24){
                    listData[i].createdAt = "сегодня, в ${DateFormat.Hm('ru').format(DateTime.parse(listData[i].createdAt)).toString()}";
                    return listData[i];
                  }
                  else{
                    listData[i].createdAt = "вчера, в ${DateFormat.Hm('ru').format(DateTime.parse(listData[i].createdAt)).toString()}";
                    return listData[i];
                  }
                }
                else{
                  listData[i].createdAt = "${DateFormat.MMMd('ru').format(DateTime.parse(listData[i].createdAt)).toString()}, в ${DateFormat.Hm('ru').format(DateTime.parse(listData[i].createdAt)).toString()}";
                  return listData[i];
                }
                //print(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedAt)).inDays);
              }
            }
          }
          return null;
        }catch(e){
          print(e);
          return null;
        }
      }
      return null;
    }
  }

  Future<List<NotificationData>> getNotificationsFromDB() async {
    final ResponseApi result = await fmcNotificationProvider.getNotificationList();
    final List decodeData = result.data['data'];
    if(result.code == 200){
      try{
        Iterable _convertList = decodeData;
        _data = _convertList.map((item){
          return NotificationData.fromJson(item);
        }).toList();
        notifyListeners();
        for(int i = 0; i < _data.length; i++){
          if(_data[i] != null && _data[i].createdAt != null){
            if(DateTime.now().difference(DateTime.parse(_data[i].createdAt)).inDays <= 1){
              if(DateTime.now().difference(DateTime.parse(_data[i].createdAt)).inHours <= 1){
                _data[i].createdAt = "только что";
              }
              else if(DateTime.now().difference(DateTime.parse(_data[i].createdAt)).inHours > 1 && DateTime.now().difference(DateTime.parse(_data[i].createdAt)).inHours < 24){
                _data[i].createdAt = "сегодня, в ${DateFormat.Hm('ru').format(DateTime.parse(_data[i].createdAt)).toString()}";
              }
              else{
                _data[i].createdAt = "вчера, в ${DateFormat.Hm('ru').format(DateTime.parse(_data[i].createdAt)).toString()}";
              }
            }
            else{
              _data[i].createdAt = "${DateFormat.MMMd('ru').format(DateTime.parse(_data[i].createdAt)).toString()}, в ${DateFormat.Hm('ru').format(DateTime.parse(_data[i].createdAt)).toString()}";
            }
            //print(DateTime.now().difference(DateTime.parse(_articlesList[i].publishedAt)).inDays);
          }
        }
        return _data;
      }catch(e){
        print(e);
        return [];
      }
    }
    notifyListeners();
    return null;
  }


  Future<bool> sendFmcTokenToServer() async {
    final _token = await fcm.getToken();
    Map<String, dynamic> _params ={
      "token": _token
    };
    print(_token);
    final SharedPreferences prefs = await _prefs;
    final _userToken = prefs.getString("userToken");
    await _sendDeviceId();
    httpManager.baseOptions.headers["Authorization"] = "Bearer " + _userToken;
    final ResponseApi result = await fmcNotificationProvider.sendToken(_params);
    print(_token);
    if(result.code == 200){
      return true;
    }
    return false;
  }

  _saveDeviceToken() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('fmcToken') == null) {
      String deviceToken = await fcm.getToken();
      await prefs.setString('fmcToken', deviceToken);
    }
  }


}

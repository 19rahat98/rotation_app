import 'package:flutter/material.dart';
import 'package:rotation_app/logic_block/models/result_api_model.dart';
import 'package:rotation_app/logic_block/repository/firebase_messaging_push_notification_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationProvider with ChangeNotifier{
  final FmcNotificationProvider fmcNotificationProvider = FmcNotificationProvider();
  FirebaseMessaging fcm = FirebaseMessaging();
  SharedPreferences prefs;

  NotificationProvider(){
    _saveDeviceToken();
    fcm.configure(
//      this callback is used when the app runs on the foreground
        onMessage: handleOnMessage,
//        used when the app is closed completely and is launched using the notification
        onLaunch: handleOnLaunch,
//        when its on the background and opened using the notification drawer
        onResume: handleOnResume);
  }

  Future<bool> sendFmcTokenToServer() async {
    final _token = await fcm.getToken();
    Map<String, dynamic> _params ={
      "token": _token
    };
    final ResponseApi result = await fmcNotificationProvider.sendToken(_params);
    if(result.code == 200){
      print('sendFmcTokenToServer');
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
  // ANCHOR PUSH NOTIFICATION METHODS
  Future handleOnMessage(Map<String, dynamic> data) async {
    _handleNotificationData(data);
  }

  Future handleOnLaunch(Map<String, dynamic> data) async {
    _handleNotificationData(data);
  }

  Future handleOnResume(Map<String, dynamic> data) async {
    _handleNotificationData(data);
  }

  _handleNotificationData(Map<String, dynamic> data) async {
    notifyListeners();
  }

}

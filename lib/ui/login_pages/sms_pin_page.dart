import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/providers/notification_provider.dart';
import 'package:rotation_app/logic_block/providers/user_login_provider.dart';
import 'package:rotation_app/ui/nav_bar/app.dart';

import 'package:rotation_app/ui/start_page.dart';
import 'package:rotation_app/ui/widgets/custom_bottom_sheet.dart';

import '../splash_page.dart';

class SmsPinPage extends StatefulWidget {
  final String phoneNumber;
  final bool hasIIN;

  const SmsPinPage({Key key, this.phoneNumber, this.hasIIN}) : super(key: key);

  @override
  _SmsPinPageState createState() => _SmsPinPageState();
}

class _SmsPinPageState extends State<SmsPinPage> with TickerProviderStateMixin {
  Stream _stream;
  var textFieldCtrl = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  int secondValue = 60;
  Future<Status> _status;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(5.0),
        color: Color(0xff76B0FD).withOpacity(0.19));
  }

  void timer() {
    new Stream.periodic(const Duration(milliseconds: 1000), (v) => v)
        .take(60)
        .listen((count) {
      setState(() {
        secondValue -= 1;
      });
    });
  }

  checkLoginState() {
    UserLoginProvider auth = Provider.of<UserLoginProvider>(context, listen: false);
    NotificationProvider np = Provider.of<NotificationProvider>(context, listen: false);
    _status.then((value) {
      print(value);
      switch (value) {
        case Status.TooManyRequest:
          return showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return ShowTooManyRequestAlert();
              });
        case Status.EmployeeDismissed:
          return showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) =>
                  DeactivateAccountBottomSheet());
        case Status.LoginFail:
          return showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return ShowErrorCodeAlert();
              });
        case Status.SuccessLogin:
          auth.saveDataToSP().then((value){
            np.sendFmcTokenToServer();
            Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => App()));
          });
      }
    });
  }

  @override
  void initState() {
    timer();
    textFieldCtrl.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    UserLoginProvider auth =
        Provider.of<UserLoginProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: w,
            height: h,
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  radius: 0.6, colors: [Color(0xff3A64B4), Color(0xff174887)]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                Container(
                  height: h * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Введите код',
                            style: TextStyle(fontFamily: "Root",
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.phoneNumber != null
                                ? 'На номер ${widget.phoneNumber} отправлено SMS с кодом авторизации'
                                : 'На ваш номер отправлено SMS с кодом авторизации',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: "Root",
                                fontSize: 14, color: Color(0xffCFD5DC)),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Изменить номер',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: "Root",
                                  fontSize: 14,
                                  color: Color(0xff40BDFF),
                                  height: 1.2),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: w * 0.7,
                            child: PinPut(
                              fieldsCount: 4,
                              eachFieldWidth: 56.0,
                              eachFieldHeight: 72.0,
                              onSubmit: (String pin) {
                                if (widget.hasIIN) {
                                  _status =
                                      auth.sendSmsCodeForIIN(smsCode: pin);
                                  checkLoginState();
                                } else {
                                  _status = auth.sendSmsCode(smsCode: pin);
                                  checkLoginState();
                                }
                              },
                              textStyle: TextStyle(
                                  fontSize: 45,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              focusNode: _pinPutFocusNode,
                              controller: textFieldCtrl,
                              submittedFieldDecoration:
                                  _pinPutDecoration.copyWith(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              selectedFieldDecoration:
                                  _pinPutDecoration.copyWith(
                                border: Border.all(
                                    color: Color(0xff18B9FF), width: 2),
                              ),
                              followingFieldDecoration:
                                  _pinPutDecoration.copyWith(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          secondValue > 0
                              ? Container(
                                  margin: EdgeInsets.only(top: 40, bottom: 20),
                                  child: Text(
                                    'Переотправить SMS: $secondValue сек',
                                    style: TextStyle(fontFamily: "Root",
                                        fontSize: 14, color: Color(0xffCFD5DC)),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    auth.retrySendSmsCode();
                                    secondValue = 60;
                                    timer();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    alignment: Alignment.center,
                                    width: w * 0.9,
                                    height: 60,
                                    child: Text(
                                      'Переотправить SMS',
                                      style: TextStyle(fontFamily: "Root",
                                          fontSize: 14,
                                          color: Color(0xffCFD5DC)),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Divider(
                        thickness: 1.5,
                        endIndent: 16,
                        indent: 16,
                        height: 0,
                        color: Color(0xffFEFFFE).withOpacity(0.12),
                      ),
                      Container(
                        width: w * 0.9,
                        margin: EdgeInsets.only(top: 16),
                        //child: Text('Авторизируясь вы автоматически соглашаетесь  с правилами сервиса и пользовательским соглашением сервиса Odyssey Rotation', textAlign: TextAlign.center, style: TextStyle(fontFamily: "Root",fontSize: 13, color: Color(0xffCFD5DC)),),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: TextStyle(fontFamily: "Root",
                                fontSize: 13,
                                color: Color(0xffCFD5DC),
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              new TextSpan(
                                  text:
                                      'Авторизируясь вы автоматически соглашаетесь  с '),
                              new TextSpan(
                                text: 'правилами сервиса ',
                                style: new TextStyle(color: Color(0xff40BDFF)),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => print('Tap Here onTap'),
                              ),
                              new TextSpan(text: 'и '),
                              new TextSpan(
                                text: 'пользовательским соглашением ',
                                style: new TextStyle(color: Color(0xff40BDFF)),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => print('Tap Here onTap'),
                              ),
                              new TextSpan(text: 'сервиса Odyssey'),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textFieldCtrl.dispose();
    super.dispose();
  }
}

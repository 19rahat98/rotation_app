import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'package:rotation_app/ui/nav_bar.dart';
import 'package:rotation_app/ui/widgets/custom_bottom_sheet.dart';

class SmsPinPage extends StatefulWidget {
  @override
  _SmsPinPageState createState() => _SmsPinPageState();
}

class _SmsPinPageState extends State<SmsPinPage> {
  var textFieldCtrl = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  StreamSubscription periodicSub;
  int secondValue = 60;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(5.0),
        color: Color(0xff76B0FD).withOpacity(0.19));
  }

  @override
  void initState() {
    textFieldCtrl.addListener(() {});
    periodicSub = new Stream.periodic(const Duration(milliseconds: 100), (v) => v)
        .take(60)
        .listen((count) {
      setState(() {
        secondValue -= 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'На номер +7 (701) 399 35 38 отправлено SMS с кодом авторизации',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                              style: TextStyle(
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
                              onSubmit: (String pin){
                                print(pin);
                                if(pin == '1111') {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) => DeactivateAccountBottomSheet());
                                }
                                if(pin == '2222'){
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) => SocialMediaBottomSheet());
                                }
                                if(pin == '3333'){
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) => NoAccountBottomSheet());
                                }

                              },
                              textStyle: TextStyle(fontSize: 45, color: Colors.white, fontWeight: FontWeight.bold),
                              focusNode: _pinPutFocusNode,
                              controller: textFieldCtrl,
                              submittedFieldDecoration:
                                  _pinPutDecoration.copyWith(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              selectedFieldDecoration: _pinPutDecoration.copyWith(
                                border: Border.all(color: Color(0xff18B9FF),width: 2),
                              ),
                              followingFieldDecoration:
                                  _pinPutDecoration.copyWith(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          secondValue > 0 ?
                          Container(
                            margin: EdgeInsets.only(top: 40, bottom: 20),
                            child: Text('Переотправить SMS: $secondValue сек', style: TextStyle(fontSize: 14, color: Color(0xffCFD5DC)),),
                          ) : Container(
                            margin: EdgeInsets.only(top: 15),
                            width: w * 0.9,
                            height: 60,
                            decoration: new BoxDecoration(
                              gradient: new RadialGradient(
                                radius: 3,
                                colors: [
                                  Color(0xFF1989DD),
                                  Color(0xFF1262CB),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TabsPage()),
                                );
                              },
                              child: Center(
                                child: Text(
                                  'Войти по ИИН',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
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
                        //child: Text('Авторизируясь вы автоматически соглашаетесь  с правилами сервиса и пользовательским соглашением сервиса Odyssey Rotation', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Color(0xffCFD5DC)),),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: TextStyle(
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
                              new TextSpan(text: 'сервиса Odyssey Rotation'),
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
    periodicSub.cancel();
    textFieldCtrl.dispose();
    super.dispose();
  }
}

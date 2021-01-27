import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/providers/user_login_provider.dart';
import 'package:rotation_app/ui/login_pages/sms_pin_page.dart';
import 'package:rotation_app/ui/widgets/custom_bottom_sheet.dart';

class UpdatePhoneNumber extends StatefulWidget {
  final String phoneNumber;

  const UpdatePhoneNumber({Key key, this.phoneNumber}) : super(key: key);

  @override
  _UpdatePhoneNumberState createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber>
    with TickerProviderStateMixin {
  var textFieldCtrl = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});
  Future<Status> _status;

  @override
  void initState() {
    textFieldCtrl.addListener(() {});
    super.initState();
  }

  ///On login
  void _confirmPhoneNumber() {
    UserLoginProvider auth =
        Provider.of<UserLoginProvider>(context, listen: false);
    FocusScope.of(context).requestFocus(new FocusNode());
    if (maskFormatter.getUnmaskedText().length == 10) {
      print(maskFormatter.getUnmaskedText());
      _status = auth.updatePhoneNumber(phone: '7' + maskFormatter.getUnmaskedText());
      handleLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    UserLoginProvider auth = Provider.of<UserLoginProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xff174887),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Подтвердите данные',
                            style: TextStyle(fontFamily: "Root",
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'С указанным ИИН найден сотрудник',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: "Root",
                                fontSize: 14,
                                color: Color(0xffCFD5DC),
                                height: 1.2),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Изменить ИИН',
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
                        children: [
                          Container(
                            width: w * 0.9,
                            margin: EdgeInsets.only(top: 30, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  thickness: 1.5,
                                  height: 0,
                                  color: Color(0xffFEFFFE).withOpacity(0.12),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        auth.employee.firstName == null ? 'Сотрудник' : '${auth.employee.firstName} ${auth.employee.lastName} ${auth.employee.patronymic}',
                                        style: TextStyle(fontFamily: "Root",
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        auth.employee.position == null ? 'Сотрудник' : '${auth.employee.position}',
                                        style: TextStyle(fontFamily: "Root",
                                          fontSize: 14,
                                          color: Color(0xffCFD5DC),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1.5,
                                  height: 0,
                                  color: Color(0xffFEFFFE).withOpacity(0.12),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: w * 0.9,
                            padding: EdgeInsets.only(left: 16, top: 5),
                            margin: EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xff76B0FD).withOpacity(0.19),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.08),
                                  width: 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Телефон',
                                  style: TextStyle(fontFamily: "Root",
                                      fontSize: 13,
                                      color:
                                          Color(0xffEBEBEB).withOpacity(0.39)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  padding: EdgeInsets.symmetric(vertical: 3),
                                  child: TextFormField(
                                    inputFormatters: [maskFormatter],
                                    autofocus: false,
                                    controller: textFieldCtrl,
                                    style: TextStyle(fontFamily: "Root",
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      hintText: '+ 7 (',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(0.0),
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value.length == 0)
                                        return ("Comments can't be empty!");
                                      return value = null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
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
                                _confirmPhoneNumber();
                              },
                              child: Center(
                                child: Text(
                                  'Добавить номер телефона',
                                  style: TextStyle(fontFamily: "Root",
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

  handleLogin() {
    UserLoginProvider auth =
        Provider.of<UserLoginProvider>(context, listen: false);
    _status.then((value) {
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
        case Status.EmployeeNotFound:
          return showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => NoAccountBottomSheet());
        case Status.Authenticating:
          return Center(child: CircularProgressIndicator());
        case Status.LoginFail:
          return showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => SocialMediaBottomSheet());
        case Status.SecondStepSuccessful:
          print('SecondStepSuccessful');
         Navigator.push(
              context, MaterialPageRoute(builder: (context) => SmsPinPage(phoneNumber: textFieldCtrl.text, hasIIN: true,)));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textFieldCtrl.dispose();
    super.dispose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:masked_text/masked_text.dart';

import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/providers/user_login_provider.dart';
import 'package:rotation_app/ui/login_pages/update_employee_phone_number.dart';
import 'package:rotation_app/ui/login_pages/sms_pin_page.dart';
import 'package:rotation_app/ui/widgets/custom_bottom_sheet.dart';

class UserIdPage extends StatefulWidget {
  final String phoneNumber;

  const UserIdPage({Key key, this.phoneNumber}) : super(key: key);

  @override
  _UserIdPageState createState() => _UserIdPageState();
}

class _UserIdPageState extends State<UserIdPage> with TickerProviderStateMixin{

  var textFieldCtrl = TextEditingController();

  Future<Status> _status;
  @override
  void initState() {
    textFieldCtrl.addListener(() {});
    super.initState();
  }

  ///On login
  void _searchEmployee(){
    UserLoginProvider auth = Provider.of<UserLoginProvider>(context, listen: false);
    FocusScope.of(context).requestFocus(new FocusNode());
    print(textFieldCtrl.text.replaceAll(new RegExp(r'[^\w\s]+'),'').replaceAll(' ', ''));
    if (textFieldCtrl.text.replaceAll(new RegExp(r'[^\w\s]+'),'').replaceAll(' ', '').length == 12) {
      _status = auth.searchEmployeeByIin(iin: textFieldCtrl.text.replaceAll(new RegExp(r'[^\w\s]+'),'').replaceAll(' ', ''));
      handleLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    //UserLoginProvider auth = Provider.of<UserLoginProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
                            'Номер не найден',
                            style: TextStyle(fontFamily: "Root",
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.phoneNumber == null
                                ? 'Номер не найден.  Пожалуйста, введите ваш ИИН'
                                : 'Номер ${widget.phoneNumber} не найден.  Пожалуйста, введите ваш ИИН',
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
                        children: [
                          Container(
                            width: w * 0.9,
                            height: 60,
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
                                  'ИИН',
                                  style: TextStyle(fontFamily: "Root",
                                      fontSize: 13,
                                      color:
                                          Color(0xffEBEBEB).withOpacity(0.39)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: MaskedTextField(
                                    maskedTextFieldController: textFieldCtrl,
                                    mask: "x x x x x x x x x x x x ",
                                    maxLength: 23,
                                    keyboardType: TextInputType.number,
                                    inputDecoration: new InputDecoration(
                                      hintText: '_ _ _ _ _ _ _ _ _ _ _ _',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(0.0),
                                      border: InputBorder.none,
                                      counterText: '',
                                    ),
                                  ),
                                ),
                                /*Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    inputFormatters: [maskFormatter],
                                    autofocus: false,
                                    controller: textFieldCtrl,
                                    style: TextStyle(fontFamily: "Root",
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      hintText: '_ _ _ _ _ _ _ _ _ _ _ _',
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
                                ),*/
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
                                _searchEmployee();
                              },
                              child: Center(
                                child: Text(
                                  'Войти по ИИН',
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

  handleLogin() {
    UserLoginProvider auth = Provider.of<UserLoginProvider>(context, listen: false);
    print(auth.status);
    _status.then((value){
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
              builder: (BuildContext context) =>
                  NoAccountBottomSheet());
        case Status.Authenticating:
          return Center(child: CircularProgressIndicator());
        case Status.LoginFail:
          return showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => SocialMediaBottomSheet());
        case Status.EmployeeFind:
          print('FirstStepSuccessful');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UpdatePhoneNumber()));
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

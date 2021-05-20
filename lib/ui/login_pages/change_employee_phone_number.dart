import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:masked_text/masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/providers/user_login_provider.dart';
import 'package:rotation_app/ui/login_pages/login_page.dart';
import 'package:rotation_app/ui/login_pages/sms_pin_page.dart';
import 'package:rotation_app/ui/widgets/custom_bottom_sheet.dart';

class ChangePhoneNumber extends StatefulWidget {
  final String phoneNumber;

  const ChangePhoneNumber({Key key, this.phoneNumber}) : super(key: key);

  @override
  _ChangePhoneNumberState createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> with TickerProviderStateMixin {
  var textFieldCtrl = TextEditingController();
  Future<Status> _status;
  bool _firstPress = true;
  bool _requestSuccess = false;

  @override
  void initState() {
    textFieldCtrl.addListener(() {});
    super.initState();
  }

  ///On login
  void _confirmPhoneNumber() {
    UserLoginProvider auth = Provider.of<UserLoginProvider>(context, listen: false);
    FocusScope.of(context).requestFocus(new FocusNode());
    print(auth.employee);
    if (textFieldCtrl.text.replaceAll(new RegExp(r'[^\w\s]+'),'').replaceAll(' ', '').length == 10) {
      _status = auth.updatePhoneNumber(phone: '7' + textFieldCtrl.text.replaceAll(new RegExp(r'[^\w\s]+'),'').replaceAll(' ', ''), firstName: auth.employee.firstName, lastName: auth.employee.lastName, employeeNumber: auth.employee.docNumber, employeeId: auth.employee.id.toString()).whenComplete(() =>  _firstPress = true);
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, top: 30),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/icon-back.svg',
                              width: 10,
                              height: 16,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'Назад',
                              style: TextStyle(
                                fontFamily: "Root",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Изменить номер',
                            style: TextStyle(fontFamily: "Root",
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Для указаного ИИН уже закреплен  номер телефона. Желаете его изменить?',
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
                            margin: EdgeInsets.only(bottom: 16,top: 25),
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
                                  'Телефон',
                                  style: TextStyle(fontFamily: "Root",
                                      fontSize: 13,
                                      color: Color(0xffEBEBEB)
                                          .withOpacity(0.39)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '+ 7 (',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: MaskedTextField(
                                          maskedTextFieldController: textFieldCtrl,
                                          mask: 'xxx) xxx xxxxx',
                                          maxLength: 13,
                                          keyboardType: TextInputType.phone,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          inputDecoration: new InputDecoration(
                                            hintText: "",
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(0.0),
                                            border: InputBorder.none,
                                            counterText: '',
                                          ),
                                          onChange: (c){
                                            print(c.length.toString());
                                          },
                                        ),
                                      ),
                                    ],
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
                                    ),*/
                              ],
                            ),
                          ),
                          !_requestSuccess ? Container(
                            width: w,
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 16),
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
                                print(_firstPress);
                                if(_firstPress){
                                  _firstPress = false;
                                  if(textFieldCtrl.text.replaceAll(new RegExp(r'[^\w\s]+'),'').replaceAll(' ', '').length != 10){
                                    return showDialog<void>(
                                        context: context,
                                        barrierDismissible: false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return CupertinoAlertDialog(
                                            title: Text('Номер телефона неполный.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('изменить'),
                                                onPressed: () {
                                                  _firstPress = true;
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                    );
                                  }
                                  /*else if(auth.userPhoneNumber != '7' + textFieldCtrl.text.replaceAll(new RegExp(r'[^\w\s]+'),'').replaceAll(' ', '')){
                                    return showDialog<void>(
                                        context: context,
                                        barrierDismissible: false, // user  must tap button!
                                        builder: (BuildContext context) {
                                          return Consumer(
                                            builder: (context, UserLoginProvider user, _) {
                                              print(user.errorMessage);
                                              return AlertDialog(
                                                title: Text('Номер телефона отличается от введенного на первом шаге'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('ОК'),
                                                    onPressed: () {
                                                      _confirmPhoneNumber();
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                    );
                                  }*/
                                  else{
                                    _confirmPhoneNumber();
                                  }
                                }

                              },
                              child: Center(
                                child: Text(
                                  'Изменить номер телефона',
                                  style: TextStyle(fontFamily: "Root",
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ) : Container(
                            width: w,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: Text(
                                    'Заявка отправлена',
                                    style: TextStyle(
                                      fontFamily: "Root",
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: w,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 8, right: 32, left: 32, bottom: 24),
                                  child: Text(
                                    '''Заявка на изменение номера телефона на 
+7 (${textFieldCtrl.text}. успешно отправлена. Обработка займет до 30 минут.  После подтверждения Вы получите уведомление на Ваш телефон.''',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Root",
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffCFD5DC),
                                    ),
                                  ),
                                ),
                              ],
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
    print('asdasdasd');
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
              builder: (BuildContext context) => ShowErrorBottomSheet());
        case Status.SecondStepSuccessful:
          print('SecondStepSuccessful');
          setState(() {
            _requestSuccess = true;
          });
          /*return showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => SendedRequestBottomSheet(phoneNumber: textFieldCtrl.text,));*/
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

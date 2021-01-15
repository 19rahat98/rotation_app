import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rotation_app/ui/sms_pin_page.dart';

class UserIdPage extends StatefulWidget {
  @override
  _UserIdPageState createState() => _UserIdPageState();
}

class _UserIdPageState extends State<UserIdPage> {
  var textFieldCtrl = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '# # # # # # # # # # # #', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    textFieldCtrl.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Номер +7 (701) 620 94 40 не найден.  Пожалуйста, введите ваш ИИН',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                              style: TextStyle(
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
                                  style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          Color(0xffEBEBEB).withOpacity(0.39)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    inputFormatters: [maskFormatter],
                                    autofocus: false,
                                    controller: textFieldCtrl,
                                    style: TextStyle(
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

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SmsPinPage()),
                                );

                                /*final act = CupertinoActionSheet(
                                    title: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Сотрудник не найден',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff1B344F),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    message: Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Сотрудник с ИИН:920911300248 не найден. Внимательно проверьте ваши данные и попробуйте снова.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff1B3652).withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      CupertinoActionSheetAction(
                                        child: Text('Обратиться в поддержку',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Color(0xff1262CB),
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () {
                                          print('pressed');
                                        },
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: Text(
                                        'Попробовать снова',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff1262CB),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ));
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext context) => act);*/
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
    textFieldCtrl.dispose();
    super.dispose();
  }
}

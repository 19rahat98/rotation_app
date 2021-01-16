import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MoreAboutPassport extends StatefulWidget {
  @override
  _MoreAboutPassportState createState() => _MoreAboutPassportState();
}

class _MoreAboutPassportState extends State<MoreAboutPassport> {

  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _userSecondNameTextController =
  TextEditingController();
  final TextEditingController _userMiddleNameTextController =
  TextEditingController();
  final TextEditingController _userIdTextController = TextEditingController();
  final TextEditingController _userDocumentNumberController = TextEditingController();

  final TextEditingController _userCountryNameTextController =
  TextEditingController(text: "МВД РК");
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  DateTime birthDate; // instance of DateTime
  String birthDateInString = '11.09.1992';
  DateTime dateOfIssue;
  String dateOfIssueString = '11.09.2016';
  DateTime idValidityDay;
  String idValidityDayString = '11.09.2020';

  @override
  void initState() {
    _userNameTextController.addListener(() {});
    _userSecondNameTextController.addListener(() {});
    _userMiddleNameTextController.addListener(() {});
    _userIdTextController.addListener(() {});
    _userNameTextController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    'Паспорт',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff1B344F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: Color(0xff748595),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Будьте внимательны, при заполнении.  Данные должны соответсвовать документу.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff1B344F).withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: w,
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      autofocus: false,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      controller: _userNameTextController,
                      //initialValue: 'Руслан',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff15304D),
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Имя", hintTextStr: "Имя (на латинце)"),
                      validator: (value) {
                        if (value.length == 0) return ("Comments can't be empty!");

                        return value = null;
                      },
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      autofocus: false,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      controller: _userSecondNameTextController,
                      //initialValue: 'Руслан',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff15304D),
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Фамилия", hintTextStr: "Фамилия (на латинце)"),
                      validator: (value) {
                        if (value.length == 0) return ("Comments can't be empty!");

                        return value = null;
                      },
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      autofocus: false,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      controller: _userMiddleNameTextController,
                      //initialValue: 'Руслан',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff15304D),
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Отчество", hintTextStr: "Отчество"),
                      validator: (value) {
                        if (value.length == 0) return ("Comments can't be empty!");

                        return value = null;
                      },
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Дата рождения',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff748595),
                    ),
                  ),
                  GestureDetector(
                      child: new Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:
                              EdgeInsets.only(top: 4, bottom: 7),
                              child: Text(
                                birthDateInString,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff15304D),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xff1262CB),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        final datePick = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.utc(1992, 9, 11),
                            firstDate: new DateTime(1900),
                            lastDate: new DateTime(2100));
                        if (datePick != null && datePick != birthDate) {
                          setState(() {
                            birthDate = datePick;
                            birthDateInString =
                            "${birthDate.month}.${birthDate.day}.${birthDate.year}";
                            print(birthDateInString);
                          });
                        }
                      }),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      controller: _userIdTextController,
                      //initialValue: 'Руслан',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff15304D),
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "ИИН", hintTextStr: "Индивидуальный идентификационный номер"),
                      validator: (value) {
                        if (value.length == 0) return ("Comments can't be empty!");

                        return value = null;
                      },
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      controller: _userDocumentNumberController,
                      //initialValue: 'Руслан',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff15304D),
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "№ документа", hintTextStr: "Kод индивидуального идентификационного номера"),
                      validator: (value) {
                        if (value.length == 0) return ("Comments can't be empty!");

                        return value = null;
                      },
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Дата выдачи',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff748595),
                    ),
                  ),
                  GestureDetector(
                      child: new Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:
                              EdgeInsets.only(top: 4, bottom: 7),
                              child: Text(
                                dateOfIssueString,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff15304D),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xff1262CB),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        final datePick = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.utc(1992, 9, 11),
                            firstDate: new DateTime(1900),
                            lastDate: new DateTime(2100));
                        if (datePick != null && datePick != birthDate) {
                          setState(() {
                            dateOfIssue = datePick;
                            dateOfIssueString =
                            "${dateOfIssue.month}.${dateOfIssue.day}.${dateOfIssue.year}";
                            print(dateOfIssueString);
                          });
                        }
                      }),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Срок действия',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff748595),
                    ),
                  ),
                  GestureDetector(
                      child: new Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:
                              EdgeInsets.only(top: 4, bottom: 7),
                              child: Text(
                                idValidityDayString,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff15304D),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xff1262CB),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        final datePick = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.utc(1992, 9, 11),
                            firstDate: new DateTime(1900),
                            lastDate: new DateTime(2100));
                        if (datePick != null && datePick != birthDate) {
                          setState(() {
                            idValidityDay = datePick;
                            idValidityDayString =
                            "${idValidityDay.month}.${idValidityDay.day}.${idValidityDay.year}";
                            print(idValidityDayString);
                          });
                        }
                      }),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      autofocus: false,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      controller: _userCountryNameTextController,
                      //initialValue: 'Руслан',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff15304D),
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Орган выдачи", hintTextStr: "Орган выдачи документа"),
                      validator: (value) {
                        if (value.length == 0) return ("Comments can't be empty!");

                        return value = null;
                      },
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 16),
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
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  print('press');
                },
                child: Center(
                  child: Text(
                    'Сохранить',
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
      ),
    );
  }
}

class CommonStyle {
  static InputDecoration textFieldStyle(
      {String labelTextStr = "", String hintTextStr = ""}) {
    return InputDecoration(

      labelStyle: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: Color(0xff748595),
      ),
      isDense: true,
      contentPadding: EdgeInsets.only(top: 4, bottom: 8),
      border: InputBorder.none,
      labelText: labelTextStr,
      hintText: hintTextStr,
    );
  }
}

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:rotation_app/logic_block/providers/login_provider.dart';

import 'more_about_document_widget.dart';

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
  final TextEditingController _userDocumentNumberController =
      TextEditingController();
  final TextEditingController _userBirthdayDateController =
  TextEditingController();
  final TextEditingController _userCountryNameTextController =
  TextEditingController();
  final TextEditingController _dateOfIssueController =
  TextEditingController();
  final TextEditingController _idValidityDayController =
  TextEditingController();

  bool _isValidate = false;

  var idValidityDayMask = new MaskTextInputFormatter(
      mask: '##.##.####', filter: {"#": RegExp(r'[0-9]')});
  var dateOfIssueMask = new MaskTextInputFormatter(
      mask: '##.##.####', filter: {"#": RegExp(r'[0-9]')});
  var dateTextFormatter = new MaskTextInputFormatter(
      mask: '##.##.####', filter: {"#": RegExp(r'[0-9]')});

  DateTime dateOfIssue, idValidityDay; // instance of DateTime

  Future<void> _showMessage(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'error',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'close',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
    LoginProvider lp = Provider.of<LoginProvider>(context, listen: false);
    lp.getEmployeeData();
    _userNameTextController.text = lp.employee.firstNameEn;
    _userSecondNameTextController.text = lp.employee.lastNameEn;
    _userIdTextController.text = lp.employee.iin;
    _userDocumentNumberController.text = lp.employee.docNumber;
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
                      fontFamily: "Root",
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
                  fontFamily: "Root",
                  fontSize: 15,
                  color: Color(0xff1B344F).withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: w,
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
                  fontFamily: "Root",
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff15304D),
                ),
                decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Имя", hintTextStr: "Имя (на латинце)"),
                validator: (value) {
                  if (value.length == 0)
                    return ("Comments can't be empty!");

                  return value = null;
                },
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              child:  TextFormField(
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
                  fontFamily: "Root",
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff15304D),
                ),
                decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Фамилия",
                    hintTextStr: "Фамилия (на латинце)"),
                validator: (value) {
                  if (value.length == 0)
                    return ("Comments can't be empty!");

                  return value = null;
                },
              ),
            ),
            /*Container(
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
                        fontFamily: "Root",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff15304D),
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Отчество", hintTextStr: "Отчество"),
                      validator: (value) {
                        if (value.length == 0)
                          return ("Comments can't be empty!");

                        return value = null;
                      },
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),*/
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              child: Form(
                autovalidate: true,
                child: TextFormField(
                  autofocus: false,
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true,
                    selectAll: true,
                  ),
                  controller: _userBirthdayDateController,
                  inputFormatters: [dateTextFormatter],
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(
                    fontFamily: "Root",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff15304D),
                  ),
                  decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Дата рождения",
                    hintTextStr: "Дата рождения",
                    istDate: true,
                  ),
                  validator: (value) {
                    if (value.length > 9) {
                      DateFormat inputFormat = DateFormat("dd/MM/yyyy");
                      if (!DateValidator('dd/MM/yyyy', errorText: "")
                          .isValid(value.replaceAll('.', '/'))) {
                        _isValidate = true;

                        return ("Введите корректное значение!");
                      }
                      else if(DateTime.now().isBefore(inputFormat.parse(value.replaceAll('.', '/')))){
                        return ("Введите корректное значение!");
                      }
                      else if(inputFormat.parse("01.01.1900".replaceAll('.', '/')).isAfter(inputFormat.parse(value.replaceAll('.', '/')))){
                        return ("Введите корректное значение!");
                      }
                    }
                    return value = null;
                  },
                ),
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
                        fontFamily: "Root",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff15304D),
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "ИИН",
                          hintTextStr:
                              "Индивидуальный идентификационный номер"),
                      validator: (value) {
                        if (value.length == 0)
                          return ("Comments can't be empty!");

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
                        fontFamily: "Root",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff15304D),
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "№ документа",
                          hintTextStr:
                              "Kод индивидуального идентификационного номера"),
                      validator: (value) {
                        if (value.length == 0)
                          return ("Comments can't be empty!");

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
              child: Form(
                autovalidate: true,
                child: TextFormField(
                  autofocus: false,
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true,
                    selectAll: true,
                  ),
                  controller: _dateOfIssueController,
                  inputFormatters: [dateOfIssueMask],
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    fontFamily: "Root",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff15304D),
                  ),
                  decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Дата выдачи",
                    hintTextStr: "Дата выдачи",
                    istDate: true,
                  ),
                  validator: (value) {
                    if (value.length > 9) {
                      DateFormat inputFormat = DateFormat("dd/MM/yyyy");
                      if (!DateValidator('dd/MM/yyyy', errorText: "")
                          .isValid(value.replaceAll('.', '/'))) {
                        _isValidate = true;

                        return ("Введите корректное значение!");
                      }
                      else if(DateTime.now().isBefore(inputFormat.parse(value.replaceAll('.', '/')))){
                        return ("Введите корректное значение!");
                      }
                      else if(inputFormat.parse("01.01.1900".replaceAll('.', '/')).isAfter(inputFormat.parse(value.replaceAll('.', '/')))){
                        return ("Введите корректное значение!");
                      }
                    }
                    return value = null;
                  },
                ),
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 16),
              child: Form(
                autovalidate: true,
                child: TextFormField(
                  autofocus: false,
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true,
                    selectAll: true,
                  ),
                  controller: _idValidityDayController,
                  inputFormatters: [idValidityDayMask],
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    fontFamily: "Root",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff15304D),
                  ),
                  decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Срок действия",
                    hintTextStr: "Срок действия документа",
                    istDate: true,
                  ),
                  validator: (value) {
                    if (value.length > 9) {
                      DateFormat inputFormat = DateFormat("dd/MM/yyyy");
                      if (!DateValidator('dd/MM/yyyy', errorText: "")
                          .isValid(value.replaceAll('.', '/'))) {
                        _isValidate = true;

                        return ("Введите корректное значение!");
                      }
                      else if(DateTime.now().isBefore(inputFormat.parse(value.replaceAll('.', '/')))){
                        return ("Введите корректное значение!");
                      }
                      else if(inputFormat.parse("01.01.1900".replaceAll('.', '/')).isAfter(inputFormat.parse(value.replaceAll('.', '/')))){
                        return ("Введите корректное значение!");
                      }
                    }
                    return value = null;
                  },
                ),
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
                        fontFamily: "Root",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff15304D),
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Орган выдачи",
                          hintTextStr: "Орган выдачи документа"),
                      validator: (value) {
                        if (value.length == 0)
                          return ("Comments can't be empty!");

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
                  if(idValidityDayMask.getMaskedText().isNotEmpty){
                    idValidityDay = DateFormat().add_yMd().parse(
                        idValidityDayMask.getMaskedText().replaceAll('.', '/'));
                  }
                  if(dateOfIssueMask.getMaskedText().isNotEmpty){
                    dateOfIssue = DateFormat().add_yMd().parse(
                        dateOfIssueMask.getMaskedText().replaceAll('.', '/'));
                  }
                  lp.updateUserDocument(
                    type: "passport",
                    number: _userIdTextController.text,
                    issueDate: dateOfIssue,
                    expireDate: idValidityDay,
                    issueBy: _userCountryNameTextController.text,
                  ).then((value) {
                    if (value) {
                      Navigator.pop(context);
                    } else {
                      _showMessage(
                        'Ошибка на сервере',
                      );
                    }
                  });
                  print('press');
                },
                child: Center(
                  child: Text(
                    'Сохранить',
                    style: TextStyle(
                        fontFamily: "Root",
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



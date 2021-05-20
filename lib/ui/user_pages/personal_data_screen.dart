import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:masked_text/masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:rotation_app/logic_block/providers/login_provider.dart';

import 'more_about_document_widget.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _userSecondNameTextController = TextEditingController();
  TextEditingController _userMiddleNameTextController = TextEditingController();
  TextEditingController _userIdTextController = TextEditingController();
  TextEditingController _userPhoneNumberTextController = TextEditingController();
  TextEditingController _userEmailTextController = TextEditingController();
  TextEditingController _userBirthdayDateController = TextEditingController();

  DateTime birthDate; // instance of DateTime
  String _gender;
  String _frequencyValue = "KAZ";
  int _radioValue = 1 ;
  static const Map<String, String> frequencyOptions = {
    "Казахстан": "KAZ",
    "Россия": "RUS",
    "Узбекистан": "UZB",
  };

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
    LoginProvider lp = Provider.of<LoginProvider>(context, listen: false);
    lp.getEmployeeData();
    lp.getEmployeePhoneNumber();
    print(DateFormat.yMd('ru').format(DateTime.parse(lp.employee.birthDate)));
    _userNameTextController.text = lp.employee.firstName;
    _userSecondNameTextController.text = lp.employee.lastName;
    _userMiddleNameTextController.text = lp.employee.patronymic;
    _userIdTextController.text = lp.employee.iin;
    _userBirthdayDateController.text = DateFormat.yMd('ru').format(DateTime.parse(lp.employee.birthDate));
    _frequencyValue = lp.employee.countryCode;
    _gender = lp.employee.gender;
    if (lp.userPhoneNumber != null) {
      _userPhoneNumberTextController.text =
          lp.userPhoneNumber.substring(1, 4) +
          ") " +
          lp.userPhoneNumber.substring(4, 7) +
          " " +
          lp.userPhoneNumber.substring(7, lp.userPhoneNumber.length);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    LoginProvider lp = Provider.of<LoginProvider>(context, listen: false);
    lp.getEmployeeData();
    lp.getEmployeePhoneNumber();

    return Scaffold(
      backgroundColor: Color(0xffF3F6FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          'Личные данные',
          style: TextStyle(
              fontFamily: "Root",
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2D4461),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Личные данные',
                  style: TextStyle(
                    fontFamily: "Root",
                    fontSize: 24,
                    color: Color(0xff1B344F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: w,
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      //margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Основная информация',
                        style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 19,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: w,
                      margin: EdgeInsets.only(top: 16, left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Имя',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              autofocus: false,
                              controller: _userNameTextController,
                              style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff15304D),
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.only(top: 4, bottom: 7),
                                border: InputBorder.none,
                                /*hintText: "Найти…",
                                hintStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff748595)),*/
                              ),
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
                      margin: EdgeInsets.only(top: 16, left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Фамилия',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500,

                            ),
                          ),
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
                                fontFamily: "Root",
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff15304D),
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.only(top: 4, bottom: 7),
                                border: InputBorder.none,
                                /*hintText: "Найти…",
                                hintStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff748595)),*/
                              ),
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
                      margin: EdgeInsets.only(top: 16, left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Отчество',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                          Container(
                            child: TextFormField(
                              autofocus: false,
                              controller: _userMiddleNameTextController,
                              style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff15304D),
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.only(top: 4, bottom: 7),
                                border: InputBorder.none,
                              ),
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
                      margin: EdgeInsets.only(left: 4),
                      //margin: EdgeInsets.only(top: 16),
                      child: Form(
                        autovalidate: true,
                        child: MaskedTextField(
                          maskedTextFieldController: _userBirthdayDateController,
                          mask: "xx.xx.xxxx",
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff15304D),
                          ),
                          inputDecoration: CommonStyle.textFieldStyle(
                            labelTextStr: "Дата рождения",
                            hintTextStr: "Дата рождения",
                            contentPadding: EdgeInsets.only(top: 15, bottom: 4),
                            istDate: true,
                          ),
                          validator: (value) {
                            if (value.length > 9) {
                              DateFormat inputFormat = DateFormat("dd/MM/yyyy");
                              if (!DateValidator('dd/MM/yyyy', errorText: "")
                                  .isValid(value.replaceAll('.', '/'))) {
                                return ("Введите корректное значение!");
                              }
                              else if(inputFormat.parse("01.01.2050".replaceAll('.', '/')).isBefore(inputFormat.parse(value.replaceAll('.', '/')))){
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text(
                              'Пол',
                              style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 13,
                                color: Color(0xff748595),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, bottom: 8),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      _gender = 'male';
                                    });
                                  },
                                  child: Container(
                                    height: 24,
                                    margin: EdgeInsets.only(right: 10),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: _gender == 'male' ? Color(0xff1262CB) : Colors.transparent,
                                    ),
                                    child: Text(
                                      'Мужской',
                                      style: TextStyle(
                                        fontFamily: 'Root',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: _gender == 'male' ? Colors.white : Color(0xff15304D),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      _gender = 'female';
                                    });
                                  },
                                  child: Container(
                                    height: 24,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: _gender == 'female' ? Color(0xff1262CB) : Colors.transparent,
                                    ),
                                    child: Text(
                                      'Женский',
                                      style: TextStyle(
                                        fontFamily: 'Root',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: _gender == 'female' ? Colors.white : Color(0xff15304D),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*Container(
                            margin: EdgeInsets.only(top: 4, bottom: 7),
                            child: GroupButton(
                              isRadio: true,
                              spacing: 3,
                              unselectedTextStyle: TextStyle(
                                fontSize: 17,
                                color: Color(0xff15304D),
                              ),
                              selectedTextStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                              selectedColor: Color(0xff1262CB),
                              selectedShadow: null,
                              unselectedShadow: null,
                              unselectedColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(5.0),
                              onSelected: (index, isSelected) {
                                setState(() {
                                  if (index == 0) {
                                    _gender = 'male';
                                  } else if (index == 1) {
                                    _gender = 'female';
                                  } else
                                    _gender = 'male';
                                });
                              },
                              buttons: [
                                "Мужской",
                                "Женский",
                              ],
                            ),
                          ),*/
                          Divider(
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: w,
                      margin: EdgeInsets.only(top: 16, left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ИИН',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              autofocus: false,
                              controller: _userIdTextController,
                              keyboardType: TextInputType.phone,
                              //initialValue: 'Руслан',
                              style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff15304D),
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.only(top: 4, bottom: 7),
                                border: InputBorder.none,
                                /*hintText: "Найти…",
                                hintStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff748595)),*/
                              ),
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
                      margin: EdgeInsets.only(top: 16, left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Гражданство',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xff1262CB),
                                ),
                                iconSize: 24,
                                dropdownColor: Colors.white,
                                isDense: true,
                                elevation: 1,
                                items: frequencyOptions
                                    .map((description, value) {
                                      return MapEntry(
                                          description,
                                          DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(description),
                                          ));
                                    })
                                    .values
                                    .toList(),
                                value: _frequencyValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    _frequencyValue = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: w * 0.7,
                                child: TextFormField(
                                  autofocus: false,
                                  controller: _userCountryNameTextController,
                                  style: TextStyle(fontFamily: "Root",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff15304D),
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.only(top: 4, bottom: 7),
                                    border: InputBorder.none,
                                    */ /*hintText: "Найти…",
                                    hintStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff748595)),*/ /*
                                  ),
                                  validator: (value) {
                                    if (value.length == 0)
                                      return ("Comments can't be empty!");

                                    return value = null;
                                  },
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color(0xff1262CB),
                                size: 24,
                              ),
                            ],
                          ),*/
                          Divider(
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: w,
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Контактные данные',
                        style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 19,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: w,
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Телефон',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            width: w,
                            child: Row(
                              children: [
                                Text(
                                  '+ 7 (',
                                  style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff15304D),
                                  ),
                                ),
                                Expanded(
                                  child: MaskedTextField(
                                    maskedTextFieldController: _userPhoneNumberTextController,
                                    mask: "xxx) xxx xxxxx",
                                    maxLength: 13,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                      fontFamily: "Root",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff15304D),
                                    ),
                                    inputDecoration: CommonStyle.textFieldStyle(
                                      hintTextStr: "",
                                      contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                                      istDate: false,
                                      removeBorder: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: w * 0.7,
                                child: TextFormField(
                                  autofocus: false,
                                  controller: _userCountryNameTextController,
                                  style: TextStyle(fontFamily: "Root",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff15304D),
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.only(top: 4, bottom: 7),
                                    border: InputBorder.none,
                                    */ /*hintText: "Найти…",
                                    hintStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff748595)),*/ /*
                                  ),
                                  validator: (value) {
                                    if (value.length == 0)
                                      return ("Comments can't be empty!");

                                    return value = null;
                                  },
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color(0xff1262CB),
                                size: 24,
                              ),
                            ],
                          ),*/
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
                            'Эл. почта',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              autofocus: false,
                              controller: _userEmailTextController,
                              //initialValue: 'Руслан',
                              style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff15304D),
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.only(top: 4, bottom: 7),
                                border: InputBorder.none,
                                /*hintText: "Найти…",
                                hintStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff748595)),*/
                              ),
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
                  ],
                ),
              ),
              Container(
                width: w,
                margin: EdgeInsets.only(top: 16, left: 16, right: 16),
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
                    if(_userBirthdayDateController.text.isNotEmpty){
                      birthDate = DateFormat().add_yMd().parse(
                          _userBirthdayDateController.text.replaceAll('.', '/'));
                    }
                    lp.updateUserData(
                      firstName: _userNameTextController.text,
                      lastName: _userSecondNameTextController.text,
                      patronymic: _userMiddleNameTextController.text,
                      countryCode: _frequencyValue,
                      birthDate: birthDate,
                      iin: _userIdTextController.text,
                      gender: _gender,
                    ).then((value) {
                      if (value) {
                        Navigator.pop(context);
                      } else {
                        _showMessage(
                          'Ошибка на сервере',
                        );
                      }
                    });
                    print(birthDate);
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
      ),
    );
  }

}

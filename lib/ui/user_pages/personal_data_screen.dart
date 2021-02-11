import 'dart:async';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/ui/trips_pages/tickets_bottom_sheet.dart';
import 'package:rotation_app/ui/support_pages/more_article_info_widget.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _userSecondNameTextController = TextEditingController();
  TextEditingController _userMiddleNameTextController = TextEditingController();
  TextEditingController _userIdTextController = TextEditingController();
  TextEditingController _userCountryNameTextController =
      TextEditingController();
  TextEditingController _userPhoneNumberTextController =
      TextEditingController();
  TextEditingController _userEmailTextController = TextEditingController();
  TextEditingController _userBirthdayDateController = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});
  var dateTextFormatter = new MaskTextInputFormatter(
      mask: '##.##.####', filter: {"#": RegExp(r'[0-9]')});

  DateTime birthDate; // instance of DateTime
  String _gender = "male";
  String _frequencyValue = "KAZ";

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
    _userNameTextController.addListener(() {});
    _userSecondNameTextController.addListener(() {});
    _userMiddleNameTextController.addListener(() {});
    _userIdTextController.addListener(() {});
    _userPhoneNumberTextController.addListener(() {});
    _userEmailTextController.addListener(() {});
    _userNameTextController.addListener(() {});
    _userBirthdayDateController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    LoginProvider lp = Provider.of<LoginProvider>(context, listen: false);
    lp.getEmployeeData();
    lp.getEmployeePhoneNumber();
    _userNameTextController.text = lp.employee.firstName;
    _userSecondNameTextController.text = lp.employee.lastName;
    _userMiddleNameTextController.text = lp.employee.patronymic;
    _userIdTextController.text = lp.employee.iin;
    _userCountryNameTextController.text = "Казахстан";
    if (lp.userPhoneNumber != null) {
      _userPhoneNumberTextController.text = "+ ${lp.userPhoneNumber[0]}" +
          "(" +
          lp.userPhoneNumber.substring(1, 4) +
          ") " +
          lp.userPhoneNumber.substring(4, 7) +
          " " +
          lp.userPhoneNumber.substring(7, lp.userPhoneNumber.length);
    }

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
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Имя',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
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
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Фамилия',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
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
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Отчество',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
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
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Дата рождения',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: _userBirthdayDateController,
                                    inputFormatters: [dateTextFormatter],
                                    keyboardType: TextInputType.phone,
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
                                  width: w * 0.75,
                                ),
                                SvgPicture.asset(
                                  'assets/svg/Calendar.svg',
                                  width: 24,
                                  height: 24,
                                  color: Color(0xff1262CB),
                                ),
                              ],
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
                            'Пол',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                            ),
                          ),
                          Container(
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
                                    print(_gender);
                                  } else if (index == 1) {
                                    _gender = 'female';
                                    print(_gender);
                                  } else
                                    _gender = 'male';
                                });
                              },
                              buttons: [
                                "Мужской",
                                "Женский",
                              ],
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
                            'ИИН',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
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
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Гражданство',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
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
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              autofocus: false,
                              controller: _userPhoneNumberTextController,
                              inputFormatters: [maskFormatter],
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

  void _onOpenMore(BuildContext context, String title, String text) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: w,
          constraints: new BoxConstraints(
            maxHeight: h * 0.90,
          ),
          //height: h * 0.90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: MoreArticleWidget(
            title: title,
            articleText: text,
          ),
        );
      },
    );
  }
}

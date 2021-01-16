import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:rotation_app/ui/trips_pages/tickets_bottom_sheet.dart';
import 'package:rotation_app/ui/support_pages/more_article_info_widget.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final TextEditingController _userNameTextController =
      TextEditingController(text: "Руслан");
  final TextEditingController _userSecondNameTextController =
      TextEditingController(text: "Баталагазиев");
  final TextEditingController _userMiddleNameTextController =
      TextEditingController(text: "Владимирович");
  final TextEditingController _userIdTextController =
      TextEditingController(text: "920911300280");
  final TextEditingController _userCountryNameTextController =
      TextEditingController(text: "Казахстан");
  final TextEditingController _userPhoneNumberTextController =
      TextEditingController(text: "+7 (701) 399 3538");
  final TextEditingController _userEmailTextController =
      TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  DateTime birthDate; // instance of DateTime
  String birthDateInString = '11.09.1992';

  @override
  void initState() {
    _userNameTextController.addListener(() {});
    _userSecondNameTextController.addListener(() {});
    _userMiddleNameTextController.addListener(() {});
    _userIdTextController.addListener(() {});
    _userPhoneNumberTextController.addListener(() {});
    _userEmailTextController.addListener(() {});
    _userNameTextController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
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
                              fontSize: 13,
                              color: Color(0xff748595),
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              autofocus: false,
                              controller: _userNameTextController,
                              //initialValue: 'Руслан',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
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
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
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
                              fontSize: 13,
                              color: Color(0xff748595),
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              autofocus: false,
                              controller: _userMiddleNameTextController,
                              //initialValue: 'Руслан',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
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
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Пол',
                            style: TextStyle(
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
                              onSelected: (index, isSelected) =>
                                  print('$index button is selected'),
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
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
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
                              fontSize: 13,
                              color: Color(0xff748595),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: w * 0.7,
                                child: TextFormField(
                                  autofocus: false,
                                  controller: _userCountryNameTextController,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
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
                              Icon(
                                Icons.calendar_today,
                                color: Color(0xff1262CB),
                                size: 20,
                              ),
                            ],
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
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
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
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
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
      ),
    );
  }

  void _onOpenMore(BuildContext context, String title, String text) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: false,
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



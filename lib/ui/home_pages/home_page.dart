import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
import 'package:rotation_app/logic_block/providers/conversation_rates_provider.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/providers/notification_provider.dart';
import 'package:rotation_app/ui/home_pages/widgets/nearest_trip_widget.dart';
import 'package:rotation_app/ui/support_pages/call_support_widget.dart';
import 'package:rotation_app/ui/support_pages/questions_answers_screen.dart';
import 'package:rotation_app/ui/support_pages/social_media_widget.dart';
import 'package:rotation_app/ui/widgets/emptyPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  DateTime _targetDateTime = DateTime.now();
  String _weekDay = '';
  String _monthName = '';
  CalendarCarousel _calendarCarouselNoHeader;

  void weekDays() async {
    switch (_targetDateTime.weekday) {
      case 1:
        {
          _weekDay = "Понедельник";
        }
        break;

      case 2:
        {
          _weekDay = "Вторник";
        }
        break;

      case 3:
        {
          _weekDay = "Среда";
        }
        break;

      case 4:
        {
          _weekDay = "Четверг";
        }
        break;

      case 5:
        {
          _weekDay = "Пятница";
        }
        break;

      case 6:
        {
          _weekDay = "Суббота";
        }
        break;

      case 7:
        {
          _weekDay = "Воскресенье";
        }
        break;

      default:
        {
          _weekDay = "Понедельник";
        }
        break;
    }
  }

  void monthDays() async {
    switch (_targetDateTime.month) {
      case 1:
        {
          _monthName = "Январь";
        }
        break;

      case 2:
        {
          _monthName = "Февраль";
        }
        break;

      case 3:
        {
          _monthName = "Март";
        }
        break;

      case 4:
        {
          _monthName = "Апрель";
        }
        break;

      case 5:
        {
          _monthName = "Май";
        }
        break;

      case 6:
        {
          _monthName = "Июнь";
        }
        break;

      case 7:
        {
          _monthName = "Июль";
        }
        break;

      case 8:
        {
          _monthName = "Август";
        }
        break;

      case 9:
        {
          _monthName = "Сентябрь";
        }
        break;

      case 10:
        {
          _monthName = "Октябрь";
        }
        break;

      case 11:
        {
          _monthName = "Ноябрь";
        }
        break;

      case 12:
        {
          _monthName = "Декабрь";
        }
        break;

      default:
        {
          _monthName = "Январь";
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    weekDays();
    monthDays();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    LoginProvider lp = Provider.of<LoginProvider>(context, listen: false);
    NotificationProvider np =
        Provider.of<NotificationProvider>(context, listen: false);
    ConversationRatesProvider crp =
        Provider.of<ConversationRatesProvider>(context, listen: false);
    lp.getEmployeeData();
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayTextStyle: TextStyle(
          fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
      weekdayTextStyle: TextStyle(
          fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xff748595)),
      weekendTextStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Color(0xff1B344F).withOpacity(0.3)),
      nextDaysTextStyle: TextStyle(
          fontSize: 13, fontWeight: FontWeight.bold, color: Colors.red),
      todayButtonColor: Color(0xff1262CB),
      showHeader: false,
      showOnlyCurrentMonthDate: true,
      width: MediaQuery.of(context).size.width * 0.53,
      dayPadding: 0,
      childAspectRatio: 1.4,
      daysTextStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Color(0xff1B344F).withOpacity(0.3)),
      locale: "ru",
      customDayBuilder: (
        bool isSelectable,
        int index,
        bool isSelectedDay,
        bool isToday,
        bool isPrevMonthDay,
        TextStyle textStyle,
        bool isNextMonthDay,
        bool isThisMonthDay,
        DateTime day,
      ) {
        if (DateTime.now().isBefore(day)) {
          return Center(
            child: Text(
              day.day.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Root",
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1B344F)),
            ),
          );
        } else {
          return null;
        }
      },
    );

    return FutureBuilder<List<Application>>(
        future: lp.getEmployeeApplication(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            print('snapshot.connectionState == ConnectionState.none');
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError)
            return Center(
                child: emptyPage(Icons.error_outline, 'Something is wrong'));
          else if (snapshot.data != null) {
            return Scaffold(
              backgroundColor: Color(0xffF3F6FB),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'Главная',
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
                  margin: EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: w,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              margin: EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/ava.png'),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: w * 0.7,
                                  child: Text(
                                    lp.employee.orgName != null
                                        ? lp.employee.orgName
                                        : 'ТОО',
                                    style: TextStyle(
                                        fontFamily: "Root",
                                        fontSize: 15,
                                        color: Color(0xff748595),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  width: w * 0.7,
                                  child: Text(
                                    lp.employee != null
                                        ? lp.employee.firstName +
                                            " " +
                                            lp.employee.lastName
                                        : 'Нурдаулет Атамбаев',
                                    style: TextStyle(
                                        fontFamily: "Root",
                                        fontSize: 24,
                                        color: Color(0xff1B344F),
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: w,
                        height: 150,
                        margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: w * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _weekDay.toUpperCase(),
                                    style: TextStyle(
                                        fontFamily: "Root",
                                        fontSize: 13,
                                        color: Color(0xff748595),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        DateTime.now().day.toString(),
                                        style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 55,
                                            color: Color(0xff1262CB),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    _monthName.toUpperCase(),
                                    style: TextStyle(
                                        fontFamily: "Root",
                                        fontSize: 13,
                                        color: Color(0xff748595),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              indent: 12,
                              endIndent: 12,
                              color: Color(0xffEBEBEB),
                              thickness: 1.2,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10, top: 10),
                                child: _calendarCarouselNoHeader),
                          ],
                        ),
                      ),
                      Container(
                        width: w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: 16, left: 16, right: 16),
                              child: Text(
                                'Уведомления',
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 17,
                                    color: Color(0xff748595),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: w,
                              height: 110,
                              padding: EdgeInsets.only(top: 8),
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(width: 16),
                                  InkWell(
                                    onTap: () async {
                                      /* np.sendFmcTokenToServer();
                                      final taskId = await FlutterDownloader.enqueue(
                                        url: 'https://tmp.ptravels.kz/download-print/32470/issue',
                                        savedDir: '/test',
                                        showNotification: true, // show download progress in status bar (for Android)
                                        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                                      );
                                      print(taskId);*/
                                    },
                                    child: Container(
                                      width: 200,
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          top: 10,
                                          bottom: 5),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Color(0xffD0DAE7)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Билеты куплены',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontFamily: "Root",
                                                      fontSize: 17,
                                                      color: Color(0xff385780),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SvgPicture.asset(
                                                  'assets/svg/icon-notify-success.svg',
                                                  width: 17,
                                                  height: 17,
                                                  color: AppTheme.mainColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: 150,
                                            child: Text(
                                              'Домой, в Алматы на 8 авг, вторник',
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontFamily: "Root",
                                                  fontSize: 14,
                                                  color: Color(0xff385780),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: 150,
                                            child: Text(
                                              'только что',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily: "Root",
                                                  fontSize: 11,
                                                  color: Color(0xff385780),
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.only(
                                        left: 12, right: 12, top: 10),
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Color(0xffD0DAE7)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Color(0xffC81D5E),
                                              Color(0xffFF4963),
                                            ])),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'РВД +3 дня',
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SvgPicture.asset(
                                                'assets/svg/Zap.svg',
                                                width: 17,
                                                height: 19,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          width: 150,
                                          child: Text(
                                            'Текущая вахта, до 8 авг, вт',
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontFamily: "Root",
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          width: 150,
                                          child: Text(
                                            '3 часа назад',
                                            style: TextStyle(
                                                fontFamily: "Root",
                                                fontSize: 11,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.only(
                                        left: 12, right: 12, top: 10),
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Color(0xffD0DAE7)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Важная новость',
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 16,
                                                    color: Color(0xff385780),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SvgPicture.asset(
                                                'assets/svg/News.svg',
                                                width: 19,
                                                height: 19,
                                                color: AppTheme.mainColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          width: 150,
                                          child: Text(
                                            'Домой, в Алматы на 8 авг, вторник',
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontFamily: "Root",
                                                fontSize: 14,
                                                color: Color(0xff385780),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          width: 150,
                                          child: Text(
                                            'только что',
                                            style: TextStyle(
                                                fontFamily: "Root",
                                                fontSize: 11,
                                                color: Color(0xff385780),
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder<bool>(
                          future: crp.getExchangeRate(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.none) {
                              print(
                                  'snapshot.connectionState == ConnectionState.none');
                              return Container(
                                width: w,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (snapshot.hasError)
                              return Center(
                                  child: emptyPage(Icons.error_outline,
                                      'Something is wrong'));
                            else if (snapshot.data != null) {
                              return Container(
                                width: w,
                                margin: EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Курс валют',
                                      style: TextStyle(
                                          fontFamily: "Root",
                                          fontSize: 17,
                                          color: Color(0xff748595),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: 50.0,
                                      width: w,
                                      margin: EdgeInsets.only(top: 8),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.white),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/svg/US.svg",
                                                width: 31,
                                                height: 22,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'USD',
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 16,
                                                    color: Color(0xff748595),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                crp.usd != null
                                                    ? crp.usd.toStringAsFixed(1)
                                                    : '407.4',
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 16,
                                                    color: Color(0xff1B344F),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/svg/EU.svg",
                                                width: 31,
                                                height: 22,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'EUR',
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 16,
                                                    color: Color(0xff748595),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                crp.usd != null
                                                    ? crp.eur.toStringAsFixed(1)
                                                    : '487.4',
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 16,
                                                    color: Color(0xff1B344F),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else
                              return Container(
                                width: w,
                                height: 50.0,
                                margin: EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                          }),
                      Container(
                        width: w,
                        margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ближайшая поездка',
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 17,
                                  color: Color(0xff748595),
                                  fontWeight: FontWeight.bold),
                            ),
                            lp.data != null && lp.data.isNotEmpty
                                ? NearestTripWidget(tripsList: lp.data)
                                : Container(
                                    width: w,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(top: 8),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          spreadRadius: 0,
                                          blurRadius: 8,
                                          offset: Offset(0,
                                              4), // changes position of shadow
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      'У вас нет активных поездок.',
                                      style: TextStyle(
                                        fontFamily: "Root",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color(0xff748595).withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Container(
                        width: w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: 16, left: 16, right: 16),
                              child: Text(
                                'Помощь 24/7',
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 17,
                                    color: Color(0xff748595),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 150.0,
                              width: w,
                              padding: EdgeInsets.only(top: 8),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(width: 16),
                                  InkWell(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CallSupportWidget());
                                    },
                                    child: Container(
                                      height: 130,
                                      width: 121,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Color(0xffD0DAE7)),
                                          color: Colors.white),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/svg/icon-help-phone.png'),
                                            width: 30,
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Позвонить',
                                            style: TextStyle(
                                                fontFamily: "Root",
                                                fontSize: 18,
                                                color: Color(0xff385780),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'в колл-центр',
                                            style: TextStyle(
                                                fontFamily: "Root",
                                                fontSize: 14,
                                                color: Color(0xff385780)
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 130,
                                    width: 121,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Color(0xffD0DAE7)),
                                        color: Colors.white),
                                    child: InkWell(
                                      onTap: () {
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                SocialMediaBottomSheet());
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/svg/icon-help-message.png'),
                                            width: 30,
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Написать',
                                            style: TextStyle(
                                                fontFamily: "Root",
                                                fontSize: 18,
                                                color: Color(0xff385780),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'в онлайн-чат',
                                            style: TextStyle(
                                                fontFamily: "Root",
                                                fontSize: 14,
                                                color: Color(0xff385780)
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 130,
                                    width: 121,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Color(0xffD0DAE7)),
                                        color: Colors.white),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QuestionsAnswers()),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/svg/icon-help-faq.png'),
                                            width: 24,
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Прочитать',
                                            style: TextStyle(
                                                fontFamily: "Root",
                                                fontSize: 18,
                                                color: Color(0xff385780),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Вопросы/Ответы',
                                            style: TextStyle(
                                                fontFamily: "Root",
                                                fontSize: 14,
                                                color: Color(0xff385780)
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

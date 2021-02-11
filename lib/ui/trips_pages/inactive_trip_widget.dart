import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';

class InactiveTripWidget extends StatelessWidget {
  final Application tripData;

  const InactiveTripWidget({Key key, this.tripData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width  - 56;
    initializeDateFormatting();
    return Container(
      width: w,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 4), // changes position of shadow
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w * .50,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              tripData.direction == "to-work"
                                  ? 'На вахту, '
                                  : 'Домой, ',
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 19,
                                  color: Color(0xff0C2B4C),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.MMMd('ru')
                                  .format(DateTime.parse(tripData.date))
                                  .toString()
                                  .replaceAll('.', ''),
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 19,
                                  color: tripData.overTime > 0 && tripData.overTime != null ? AppTheme.dangerousColor : Color(0xff0C2B4C),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 20,),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: w * .50,
                      alignment: Alignment.centerRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            tripData.shift == 'day' ?
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: SvgPicture.asset(
                                'assets/svg/Moon.svg',
                                width: 24,
                                height: 24,
                                color: AppTheme.nearlyWhite,
                              ),
                            ) :
                            Container(
                              width: 32,
                              height: 32,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppTheme.mainDarkColor,),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/svg/Moon.svg",
                                  color: Colors.white,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                            tripData.overTime > 0 && tripData.overTime != null ? Container(
                              padding: EdgeInsets.only(right: 8, top: 2, bottom: 2, left: 3),
                              margin: EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xffFF4242)),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/Zap.svg',
                                    width: 24,
                                    height: 24,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'РВД +${tripData.overTime}',
                                    style: TextStyle(fontFamily: "Root",
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ) : Container(
                              margin: EdgeInsets.only(right: 10),
                              child: SvgPicture.asset(
                                'assets/svg/Zap.svg',
                                width: 24,
                                height: 24,
                                color: AppTheme.nearlyWhite,
                              ),
                            ),
                            tripData.segments.isEmpty ?
                            SvgPicture.asset(
                              'assets/svg/Ticket.svg',
                              width: 24,
                              height: 24,
                              color: AppTheme.nearlyWhite
                            ) : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "В ${tripData.endStation[0].toUpperCase()}${tripData.endStation.toLowerCase().substring(1)}",
                  style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 14,
                      color: Color(0xff748595),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              'Билеты еще не оформлены',
              style: TextStyle(
                  fontFamily: "Root",
                  fontSize: 14,
                  color: Color(0xff748595),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class InactiveTripActionSheet extends StatelessWidget {
  final Application tripData;

  const InactiveTripActionSheet({Key key, this.tripData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Container(
            margin: EdgeInsets.only(top: 10, left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Text(
                        tripData.direction == "to-work"
                            ? 'На вахту, '
                            : 'Домой, ',
                        style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 22,
                            color: Color(0xff0C2B4C),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.MMMd('ru')
                            .format(DateTime.parse(tripData.date))
                            .toString()
                            .replaceAll('.', ''),
                        style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 22,
                            color: Color(0xff0C2B4C),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      tripData.businessTripDays != null && tripData.endStation != null ? "на ${tripData.businessTripDays} дней, " + "в ${tripData.endStation[0].toUpperCase()}${tripData.endStation.toLowerCase().substring(1)}" : "",
                      style: TextStyle(fontFamily: "Root",
                          fontSize: 14,
                          color: Color(0xff748595).withOpacity(0.7),
                          fontWeight: FontWeight.w500),
                    ),
                    tripData.shift != 'night'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/Moon.svg",
                              ),
                              Text(
                                'Ночная смена',
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xff748595).withOpacity(0.7)),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Билеты еще не куплены!',
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 17,
                        color: Color(0xff1B344F),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Text(
                    'Когда координатор закупит и оформит билеты на данную поездку, отобразится вся необходимая информация.',
                    style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 15,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1B3652).withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            print('pressed');
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          'Закрыть',
          style: TextStyle(
              fontFamily: "Root",
              fontSize: 17,
              color: Color(0xff1262CB),
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

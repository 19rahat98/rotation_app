import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';

class ActiveWidget extends StatelessWidget {
  final Application tripData;
  ActiveWidget({Key key, this.tripData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width  - 56;
    initializeDateFormatting();
    return Container(
      width: w,
      margin: EdgeInsets.only(top: 8),
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
                            /*tripData.overTime > 0 && tripData.overTime != null ? Container(
                              height: 32,
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
                            ),*/
                            tripData.segments.isEmpty ?
                            SvgPicture.asset(
                                'assets/svg/Ticket.svg',
                                width: 24,
                                height: 24,
                                color: AppTheme.nearlyWhite
                            ) : tripData.segments.length > 1 && tripData.productKey == 'rail'
                                ? Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xff00B688)),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/svg/Trains.svg",
                                  color: Colors.white,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            )
                                : tripData.productKey == 'rail' ?  Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xff00B688)),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/svg/Train.svg",
                                  color: Colors.white,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ) : Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xff00B688)),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/svg/Plane.svg",
                                  color: Colors.white,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  tripData.businessTripDays != null && tripData.endStation != null ? "в ${tripData.endStation[0].toUpperCase()}${tripData.endStation.toLowerCase().substring(1)}" : "",
                  style: TextStyle(fontFamily: "Root",
                      fontSize: 14,
                      color: Color(0xff748595),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tripData.segments.length,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        tripData.segments[index].icon != null && tripData.segments[index].icon.isNotEmpty ?
                            Image(image: NetworkImage(tripData.segments[index].icon), width: 31, height: 22,):
                        SvgPicture.asset(
                          "assets/svg/avia-bekair.svg",
                          width: 31,
                          height: 22,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: w * 0.35,
                          child: Text(
                            "${tripData.segments[index].train.depStationName[0].toUpperCase()}${tripData.segments[index].train.depStationName.toLowerCase().substring(1)} - ${tripData.segments[index].train.arrStationName[0].toUpperCase()}${tripData.segments[index].train.arrStationName.toLowerCase().substring(1)}",
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 14,
                                color: Color(0xff1B344F),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: w * 0.40 + 26,
                      alignment: Alignment.centerRight,
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: new TextSpan(
                            children: <TextSpan>[
                              new TextSpan(
                                text: DateFormat.MMMd('ru').format(
                                  DateTime.parse(tripData
                                      .segments[index].train.depDateTime),
                                ).toString().replaceAll('.', ','),
                                style: TextStyle(fontFamily: "Root",
                                  fontSize: 14,
                                  color: Color(0xff1B344F),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              new TextSpan(
                                text:
                                ' ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments[index].train.depDateTime))} - ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments[index].train.arrDateTime))}',
                                style: new TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          if(tripData.overTime != 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Container(
                width: w,
                child: Text(
                  'У вас овертайм +${tripData.overTime} дней,  билеты на новую дату куплены',
                  style: TextStyle(fontFamily: "Root",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff748595).withOpacity(0.6),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


class SingleActiveWidget extends StatelessWidget {
  final Application tripData;
  SingleActiveWidget({Key key, this.tripData}) : super(key: key);

  String getTimeToWork({String tripeDate}){
    if(tripeDate != null){
      if(DateTime.parse(tripeDate).difference(DateTime.now()).inHours > 48){
        return "через " + DateTime.parse(tripeDate).difference(DateTime.now()).inDays.toString() + " д";
      }
      else if(DateTime.parse(tripeDate).difference(DateTime.now()).inHours > 48 && DateTime.parse(tripeDate).difference(DateTime.now()).inHours > 24){
        int hours = DateTime.parse(tripeDate).difference(DateTime.now()).inHours  % 24;
        return "через " + DateTime.parse(tripeDate).difference(DateTime.now()).inDays.toString() + " д " + hours.toString() + " ч";
      }
      else if(DateTime.parse(tripeDate).difference(DateTime.now()).inHours < 24){
        int hours = DateTime.parse(tripeDate).difference(DateTime.now()).inHours  % 24;
        int minutes = DateTime.parse(tripeDate).difference(DateTime.now()).inMinutes  % 60;
        return "через " + hours.toString() + " ч " + minutes.toString() + " м";
      }
      else{
        return "через " + DateTime.parse(tripeDate).difference(DateTime.now()).inDays.toString() + " д";
      }
    } else return "";
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width  - 56;
    initializeDateFormatting();
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 8),
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
                            /*tripData.overTime > 0 && tripData.overTime != null ? Container(
                              height: 32,
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
                            ),*/
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xff00B688)),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/svg/Train.svg",
                                  color: Colors.white,
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  tripData.endStation != null ? "В ${tripData.endStation[0].toUpperCase()}${tripData.endStation.toLowerCase().substring(1)} (${getTimeToWork(tripeDate: tripData.date)})" : "",
                  style: TextStyle(fontFamily: "Root",
                      fontSize: 14,
                      color: Color(0xff748595),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tripData.segments.length,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        tripData.segments[index].icon != null && tripData.segments[index].icon.isNotEmpty ?
                        Image(image: NetworkImage(tripData.segments[index].icon), width: 31, height: 22,):
                        SvgPicture.asset(
                          "assets/svg/avia-bekair.svg",
                          width: 31,
                          height: 22,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: w * 0.35,
                          child: Text(
                            "${tripData.segments[index].train.depStationName[0].toUpperCase()}${tripData.segments[index].train.depStationName.toLowerCase().substring(1)} - ${tripData.segments[index].train.arrStationName[0].toUpperCase()}${tripData.segments[index].train.arrStationName.toLowerCase().substring(1)}",
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 14,
                                color: Color(0xff1B344F),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: w * 0.40 + 26,
                      alignment: Alignment.centerRight,
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: new TextSpan(
                            children: <TextSpan>[
                              new TextSpan(
                                text: DateFormat.MMMd('ru').format(
                                  DateTime.parse(tripData
                                      .segments[index].train.depDateTime),
                                ).toString().replaceAll('.', ','),
                                style: TextStyle(fontFamily: "Root",
                                  fontSize: 14,
                                  color: Color(0xff1B344F),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              new TextSpan(
                                text:
                                ' ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments[index].train.depDateTime))} - ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments[index].train.arrDateTime))}',
                                style: new TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          if(tripData.overTime != 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  child: Text(
                    'У вас овертайм +${tripData.overTime} дней,  билеты на новую дату куплены',
                    style: TextStyle(fontFamily: "Root",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff748595).withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
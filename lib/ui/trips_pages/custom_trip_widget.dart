import 'dart:ui';
import 'dart:isolate';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';

class CustomTripPage extends StatelessWidget {
  final Application tripData;

  CustomTripPage({Key key, this.tripData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 56;
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
                                  color: tripData.overTime > 0 &&
                                          tripData.overTime != null
                                      ? AppTheme.dangerousColor
                                      : Color(0xff0C2B4C),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20,
                            ),
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
                            tripData.shift == 'day'
                                ? Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: SvgPicture.asset(
                                      'assets/svg/Moon.svg',
                                      width: 24,
                                      height: 24,
                                      color: AppTheme.nearlyWhite,
                                    ),
                                  )
                                : Container(
                                    width: 32,
                                    height: 32,
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppTheme.mainDarkColor,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/svg/Moon.svg",
                                        color: Colors.white,
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                  ),
                            tripData.overTime != null && tripData.overTime > 0
                                ? Container(
                                    height: 32,
                                    padding: EdgeInsets.only(
                                        right: 8, top: 2, bottom: 2, left: 3),
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
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: SvgPicture.asset(
                                      'assets/svg/Zap.svg',
                                      width: 24,
                                      height: 24,
                                      color: AppTheme.nearlyWhite,
                                    ),
                                  ),
                            if (tripData.segments.length >= 2 &&
                                tripData.segments.first.activeProcess == 'watching' &&
                                tripData.segments.last.activeProcess == 'watching')
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xffEA9F3F)),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/svg/Trains.svg",
                                    color: Colors.white,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            if (tripData.segments.length >= 2 &&
                                tripData.status == 'partly' &&
                                tripData.segments.first.status == 'issued' &&
                                tripData.segments.last.status == "opened" &&
                                tripData.segments.last.activeProcess == null)
                              Container(
                                height: 32,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xff00B688),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xffC5CAD1),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (tripData.segments.length >= 2 &&
                                tripData.status == 'partly' &&
                                tripData.segments.last.status == 'issued' &&
                                tripData.segments.first.status == "opened" &&
                                tripData.segments.first.activeProcess == null)
                              Container(
                                height: 32,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xffC5CAD1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xff00B688),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (tripData.segments.length >= 2 &&
                                tripData.status == 'partly' &&
                                tripData.segments.first.status == 'issued' &&
                                tripData.segments.last.activeProcess == "watching")
                              Container(
                                height: 32,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xff00B688),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xffEA9F3F),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (tripData.segments.length >= 2 &&
                                tripData.status == 'partly' &&
                                tripData.segments.last.status == 'issued' &&
                                tripData.segments.first.activeProcess == "watching")
                              Container(
                                height: 32,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xffEA9F3F),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xff00B688),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (tripData.segments.length >= 2 &&
                                tripData.status == 'issued' &&
                                tripData.segments.first.status == 'issued' &&
                                tripData.segments.last.status == "returned")
                              Container(
                                height: 32,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xff00B688),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xffC5CAD1),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.not_interested_rounded,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (tripData.segments.length >= 2 &&
                                tripData.status == 'partly' &&
                                tripData.segments.last.status == 'issued' &&
                                tripData.segments.first.status == "returned")
                              Container(
                                height: 32,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xffEA9F3F),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xff00B688),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            if (tripData.segments.length >= 2 &&
                                tripData.segments.first.activeProcess == 'watching' &&
                                tripData.segments.last.status == "opened" &&
                                tripData.segments.last.activeProcess == null)
                              Container(
                                height: 32,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xffEA9F3F),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xffC5CAD1),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (tripData.segments.length >= 2 &&
                                tripData.segments.last.activeProcess == 'watching' &&
                                tripData.segments.first.status == "opened" &&
                                tripData.segments.first.activeProcess == null)
                              Container(
                                height: 32,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xffC5CAD1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 32,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Color(0xffEA9F3F),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/Train.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (tripData.segments.length >= 2 &&
                                tripData.segments.first.status == 'opened' &&
                                tripData.segments.last.status == "opened" &&
                                tripData.segments.last.activeProcess == null &&
                                tripData.segments.first.activeProcess == null)
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xffEA9F3F)),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/svg/Trains.svg",
                                    color: Colors.white,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            /*tripData.segments.length >= 2
                                ? SvgPicture.asset('assets/svg/Ticket.svg',
                                    width: 24,
                                    height: 24,
                                    color: AppTheme.nearlyWhite)
                                : tripData.segments.length > 1 &&
                                        tripData.productKey == 'rail'
                                    ? Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
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
                                    : tripData.productKey == 'rail'
                                        ? Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Color(0xff00B688)),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                "assets/svg/Train.svg",
                                                color: Colors.white,
                                                width: 24,
                                                height: 24,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Color(0xff00B688)),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                "assets/svg/Plane.svg",
                                                color: Colors.white,
                                                width: 24,
                                                height: 24,
                                              ),
                                            ),
                                          ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  tripData.businessTripDays != null &&
                          tripData.endStation != null
                      ? "на ${tripData.businessTripDays} дней, " +
                          "в ${tripData.endStation[0].toUpperCase()}${tripData.endStation.toLowerCase().substring(1)}"
                      : "",
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
                        tripData.segments[index].icon != null &&
                                tripData.segments[index].icon.isNotEmpty
                            ? Image(
                                image:
                                    NetworkImage(tripData.segments[index].icon),
                                width: 31,
                                height: 22,
                              )
                            : SvgPicture.asset(
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
                                decoration: tripData.segments[index].status == "returned" ?  TextDecoration.lineThrough : null,
                                color: tripData.segments[index].status == "returned" ? Color(0xff1B344F).withOpacity(0.5) : Color(0xff1B344F),
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
                                text: DateFormat.MMMd('ru')
                                    .format(
                                      DateTime.parse(tripData
                                          .segments[index].train.depDateTime),
                                    )
                                    .toString()
                                    .replaceAll('.', ','),
                                style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 14,
                                  decoration: tripData.segments[index].status == "returned" ?  TextDecoration.lineThrough : null,
                                  color: tripData.segments[index].status == "returned" ? Color(0xff1B344F).withOpacity(0.5) : Color(0xff1B344F),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              new TextSpan(
                                text:
                                    ' ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments[index].train.depDateTime))} - ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments[index].train.arrDateTime))}',
                                style: new TextStyle(
                                    fontSize: 14,
                                    decoration: tripData.segments[index].status == "returned" ?  TextDecoration.lineThrough : null,
                                    color: tripData.segments[index].status == "returned" ? Color(0xff1B344F).withOpacity(0.5) : Color(0xff1B344F),
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
          if (tripData.overTime != 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  child: Text(
                    'У вас овертайм +${tripData.overTime} дней,  билеты на новую дату куплены',
                    style: TextStyle(
                      fontFamily: "Root",
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

class CustomTripSheet extends StatefulWidget {
  final Application tripData;

  const CustomTripSheet({Key key, this.tripData}) : super(key: key);

  @override
  _CustomTripSheetState createState() => _CustomTripSheetState();
}

class _CustomTripSheetState extends State<CustomTripSheet> {
  int _ticketPrice = 0;
  int _totalPrice = 0;

  void _calculateTicketPrice() {
    if (widget.tripData.segments.isNotEmpty) {
      for (int i = 0; i < widget.tripData.segments.length; i++) {
        if (widget.tripData.segments[i].ticket != null) {
          _ticketPrice += widget.tripData.segments[i].ticket.minPrice;
          _totalPrice += widget.tripData.segments[i].ticket.sum;
        }
      }
    }
  }

  String durationToString() {
    int minutes = 0;
    initializeDateFormatting();
    if (widget.tripData.segments.isNotEmpty) {
      for (int i = 0; i < widget.tripData.segments.length; i++) {
        minutes += widget.tripData.segments[i].train.inWayMinutes;
      }
      var d = Duration(minutes: minutes);
      List<String> parts = d.toString().split(':');
      return '${parts[0].padLeft(2, '0')}ч ${parts[1].padLeft(2, '0')} мин';
    } else
      return '';
  }

  Duration waitingTime(int index) {
    Duration hour;
    initializeDateFormatting();

    if (widget.tripData.segments.length - 1 > index) {
      hour = DateTime.parse(widget.tripData.segments[1].train.depDateTime)
          .difference(
              DateTime.parse(widget.tripData.segments[0].train.arrDateTime));
      return hour;
    } else
      return Duration(hours: 0, minutes: 0);
  }

  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///sending the data
    sendPort.send([id, status, progress]);
  }

  @override
  void initState() {
    _calculateTicketPrice();

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");
    FlutterDownloader.registerCallback(downloadingCallback);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    initializeDateFormatting();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Text(
                              widget.tripData.direction != null &&
                                      widget.tripData.direction == "to-work"
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
                                  .format(DateTime.parse(widget.tripData.date))
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            durationToString().toString() + " в пути",
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff748595).withOpacity(0.7)),
                          ),
                          widget.tripData.shift == 'night'
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
                                          color: Color(0xff748595)
                                              .withOpacity(0.7)),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ],
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
            ),
            Divider(
              thickness: 1,
              height: 0,
              color: Color(0xffEBEBEB),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.tripData.segments.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                widget.tripData.productKey == "rail"
                                    ? SvgPicture.asset(
                                        "assets/svg/Train.svg",
                                        color: Color(0xff1B344F),
                                        width: 24,
                                        height: 24,
                                      )
                                    : SvgPicture.asset(
                                        "assets/svg/Plane.svg",
                                        color: Color(0xff1B344F),
                                        width: 24,
                                        height: 24,
                                      ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 3),
                                  width: 2,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xff1B344F),
                                  ),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  margin: EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      width: 3,
                                      color: Color(0xff1B344F),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        widget.tripData.segments[index].icon !=
                                                    null &&
                                                widget.tripData.segments[index]
                                                    .icon.isNotEmpty
                                            ? Image(
                                                image: NetworkImage(widget
                                                    .tripData
                                                    .segments[index]
                                                    .icon),
                                                width: 33,
                                                height: 33,
                                              )
                                            : SvgPicture.asset(
                                                "assets/svg/avia-bekair.svg",
                                                width: 33,
                                                height: 33,
                                              ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, bottom: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateFormat.MMMEd('ru')
                                                    .format(
                                                      DateTime.parse(widget
                                                          .tripData
                                                          .segments[index]
                                                          .train
                                                          .depDateTime),
                                                    )
                                                    .toString()
                                                    .replaceAll('.', ','),
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 16,
                                                    color: Color(0xff1B344F),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 4, bottom: 4),
                                                child: Text(
                                                  DateFormat.Hm()
                                                      .format(DateTime.parse(
                                                          widget
                                                              .tripData
                                                              .segments[index]
                                                              .train
                                                              .depDateTime))
                                                      .toString()
                                                      .replaceAll('.', ''),
                                                  style: TextStyle(
                                                      fontFamily: "Root",
                                                      fontSize: 20,
                                                      color: Color(0xff1B344F),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                "${widget.tripData.segments[index].train.depStationName[0].toUpperCase()}${widget.tripData.segments[index].train.depStationName.toLowerCase().substring(1)}, ${widget.tripData.segments[index].depStationName[0].toUpperCase()}${widget.tripData.segments[index].depStationName.toLowerCase().substring(1)}",
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff748595)
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Divider(
                                      thickness: 1,
                                      height: 0,
                                      color: Color(0xffEBEBEB),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 16, left: 10, bottom: 16),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: w * 0.25,
                                              child: Text(
                                                'перевозчик',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff748595)
                                                        .withOpacity(0.7)),
                                              ),
                                            ),
                                            Container(
                                              width: w * 0.55,
                                              child: Text(
                                                'КТЖ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff1B344F)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: w * 0.25,
                                              child: Text(
                                                'поезд',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff748595)
                                                        .withOpacity(0.7)),
                                              ),
                                            ),
                                            Container(
                                              width: w * 0.55,
                                              child: Text(
                                                '№${widget.tripData.segments[index].train.number} (${widget.tripData.segments[index].train.depStation} - ${widget.tripData.segments[index].train.arrStation})',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff1B344F)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        widget.tripData.segments[index]
                                                    .ticket ==
                                                null
                                            ? Row(
                                                children: [
                                                  Container(
                                                    width: w * 0.25,
                                                    child: Text(
                                                      'вагон',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Root",
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff748595)
                                                                  .withOpacity(
                                                                      0.7)),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: w * 0.55,
                                                    child: Text(
                                                      'Купе №',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Root",
                                                          fontSize: 14,
                                                          color: Color(
                                                              0xff1B344F)),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : widget.tripData.segments[index]
                                                        .ticket.seatNumber ==
                                                    null
                                                ? Row(
                                                    children: [
                                                      Container(
                                                        width: w * 0.25,
                                                        child: Text(
                                                          'вагон',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Root",
                                                              fontSize: 14,
                                                              color: Color(
                                                                      0xff748595)
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: w * 0.55,
                                                        child: Text(
                                                          'Купе № ${widget.tripData.segments[index].ticket.seatNumber}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Root",
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xff1B344F)),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      Container(
                                                        width: w * 0.25,
                                                        child: Text(
                                                          'вагон',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Root",
                                                              fontSize: 14,
                                                              color: Color(
                                                                      0xff748595)
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: w * 0.55,
                                                        child: Text(
                                                          'Купе №',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Root",
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xff1B344F)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Divider(
                                      thickness: 1,
                                      height: 0,
                                      color: Color(0xffEBEBEB),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10, top: 16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        widget.tripData.segments[index].icon !=
                                                    null &&
                                                widget.tripData.segments[index]
                                                    .icon.isNotEmpty
                                            ? Image(
                                                image: NetworkImage(widget
                                                    .tripData
                                                    .segments[index]
                                                    .icon),
                                                width: 33,
                                                height: 33,
                                              )
                                            : SvgPicture.asset(
                                                "assets/svg/avia-bekair.svg",
                                                width: 33,
                                                height: 33,
                                              ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, bottom: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateFormat.MMMEd('ru')
                                                    .format(
                                                      DateTime.parse(widget
                                                          .tripData
                                                          .segments[index]
                                                          .train
                                                          .arrDateTime),
                                                    )
                                                    .toString()
                                                    .replaceAll('.', ','),
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 16,
                                                    color: Color(0xff1B344F),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 4, bottom: 4),
                                                child: Text(
                                                  DateFormat.Hm()
                                                      .format(DateTime.parse(
                                                          widget
                                                              .tripData
                                                              .segments[index]
                                                              .train
                                                              .arrDateTime))
                                                      .toString()
                                                      .replaceAll('.', ''),
                                                  style: TextStyle(
                                                      fontFamily: "Root",
                                                      fontSize: 20,
                                                      color: Color(0xff1B344F),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                "${widget.tripData.segments[index].train.arrStationName[0].toUpperCase()}${widget.tripData.segments[index].train.arrStationName.toLowerCase().substring(1)}, ${widget.tripData.segments[index].arrStationName[0].toUpperCase()}${widget.tripData.segments[index].arrStationName.toLowerCase().substring(1)}",
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff748595)
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.bold),
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
                          ],
                        ),
                      ),
                      if (widget.tripData.segments.length > 1 &&
                          widget.tripData.segments.length - index > 1)
                        Container(
                          width: w,
                          padding:
                              EdgeInsets.only(top: 12, bottom: 12, left: 32),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: Color(0xFFE7DDD0),
                            ),
                            color: Color(0xFFFCFCF5),
                          ),
                          child: Text(
                            'Пересадка, ${widget.tripData.segments[index].arrStationName[0].toUpperCase()}${widget.tripData.segments[index].arrStationName.toLowerCase().substring(1)}: ${waitingTime(index).inHours} ч ${waitingTime(index).inMinutes.remainder(60)} мин',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 14,
                              color: Color(0xFF705D4D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  );
                }),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffF5F8FB),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 14),
                    child: Text(
                      'Стоимость',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 18,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Билеты',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Root",
                          fontSize: 16,
                          color: Color(0xff1B344F),
                        ),
                      ),
                      Text(
                        //'${widget.tripData.segments[index].train} тг',
                        '${_ticketPrice.toString()} тг',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Root",
                          fontSize: 16,
                          color: Color(0xff748595),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xffEBEBEB),
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Тариф «Комфорт"',
                        style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 16,
                          color: Color(0xff1B344F),
                        ),
                      ),
                      Text(
                        '+ ${_tariffPrice.toString()} тг',
                        style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 16,
                          color: Color(0xff748595),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xffEBEBEB),
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Итого',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Root",
                          fontSize: 16,
                          color: Color(0xff1B344F),
                        ),
                      ),
                      Text(
                        '${_totalPrice.toString()} тг',
                        style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 16,
                            color: Color(0xff2D4461),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              width: w,
              height: 52,
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: RadialGradient(radius: 4, colors: [
                  Color(0xff1989DD),
                  Color(0xff1262CB),
                ]),
              ),
              child: InkWell(
                onTap: () async {
                  final status = await Permission.storage.request();

                  if (status.isGranted) {
                    final externalDir = await getExternalStorageDirectory();

                    final id = await FlutterDownloader.enqueue(
                      url:
                          "https://firebasestorage.googleapis.com/v0/b/storage-3cff8.appspot.com/o/2020-05-29%2007-18-34.mp4?alt=media&token=841fffde-2b83-430c-87c3-2d2fd658fd41",
                      savedDir: externalDir.path,
                      fileName: "dfsdfsdfdfdsf",
                      showNotification: true,
                      openFileFromNotification: true,
                    );
                  } else {
                    print("Permission deined");
                  }
                },
                child: Center(
                    child: Text(
                  'Скачать билеты',
                  style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

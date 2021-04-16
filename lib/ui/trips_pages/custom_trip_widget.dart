import 'dart:io';
import 'dart:ui';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:rotation_app/ui/pdf_viewer.dart';
import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';

class CustomTripPage extends StatefulWidget {
  final Application tripData;

  CustomTripPage({Key key, this.tripData, }) : super(key: key);

  @override
  _CustomTripPageState createState() => _CustomTripPageState();
}

class _CustomTripPageState extends State<CustomTripPage> {

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

  void statusCode(){
    if(widget.tripData.applicationStatus == null){
      widget.tripData.applicationStatus = LoginProvider().getStatusApplication(widget.tripData);
    }
    if(widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.containsKey("yellow")){
      widget.tripData.segments.sort((b, a) => b.watcherTimeLimit.compareTo(a.watcherTimeLimit));
    }
  }

  @override
  void initState() {
    print(widget.tripData.id);
    super.initState();
    statusCode();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    double w = MediaQuery.of(context).size.width - 56;
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
                              widget.tripData.direction == "to-work"
                                  ? 'На вахту, '
                                  : 'Домой, ',
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 19,
                                  color: widget.tripData.applicationStatus != null && widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.keys.elementAt(0) == "red" ? Color(0xff0C2B4C).withOpacity(0.5) : Color(0xff0C2B4C),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.MMMd('ru')
                                  .format(DateTime.parse(widget.tripData.date))
                                  .toString()
                                  .replaceAll('.', ''),
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 19,
                                  color: widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.keys.elementAt(0) == "green" && widget.tripData.overTime > 0 ? AppTheme.dangerousColor : widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.keys.elementAt(0) == "red" ? Color(0xff0C2B4C).withOpacity(0.5) : Color(0xff0C2B4C),
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
                            widget.tripData.shift == 'day'
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
                            for(int i = 0; i < widget.tripData.applicationStatus.length; i++)
                              if(widget.tripData.applicationStatus.length == 1)
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: widget.tripData.applicationStatus.keys.elementAt(i) == "green" ? Color(0xff00B688) : widget.tripData.applicationStatus.keys.elementAt(i) == "yellow" ? Color(0xffEA9F3F) : widget.tripData.applicationStatus.keys.elementAt(i) == "red" ? Color(0xffFF4242) : widget.tripData.applicationStatus.keys.elementAt(i) == "grey" ||  widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? Color(0xffC5CAD1) :  Color(0xffC5CAD1),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? "assets/svg/Returned.svg" : "assets/svg/Trains.svg",
                                      color: Colors.white,
                                      width: widget.tripData.applicationStatus.keys.elementAt(i) == "red" ? 20 : 24,
                                      height: widget.tripData.applicationStatus.keys.elementAt(i) == "red" ? 20 : 24,
                                    ),
                                  ),
                                )
                              else if(widget.tripData.applicationStatus.length > 1 && i == 0)
                                Container(
                                  width: 26,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: widget.tripData.applicationStatus.keys.elementAt(i) == "green" ? Color(0xff00B688) : widget.tripData.applicationStatus.keys.elementAt(i) == "yellow" ? Color(0xffEA9F3F) : widget.tripData.applicationStatus.keys.elementAt(i) == "red" ? Color(0xffFF4242) : widget.tripData.applicationStatus.keys.elementAt(i) == "grey" ? Color(0xffC5CAD1) :  Color(0xffC5CAD1),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      topLeft: Radius.circular(50),
                                    ),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                        widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? "assets/svg/Returned.svg" : widget.tripData.applicationStatus.values.elementAt(i) > 1 ? "assets/svg/Trains.svg" : "assets/svg/Train.svg",
                                      color: Colors.white,
                                      width: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? 20 : 24,
                                      height: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled"  ? 20 : 24,
                                    ),
                                  ),
                                )
                                else if(widget.tripData.applicationStatus.length > 1 && i + 1 != widget.tripData.applicationStatus.length && i != 0)
                                  Container(
                                    width: 26,
                                    height: 32,
                                    color: widget.tripData.applicationStatus.keys.elementAt(i) == "green" ? Color(0xff00B688) : widget.tripData.applicationStatus.keys.elementAt(i) == "yellow" ? Color(0xffEA9F3F) : widget.tripData.applicationStatus.keys.elementAt(i) == "red" ? Color(0xffFF4242) : widget.tripData.applicationStatus.keys.elementAt(i) == "grey" ? Color(0xffC5CAD1) :  Color(0xffC5CAD1),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? "assets/svg/Returned.svg" : widget.tripData.applicationStatus.values.elementAt(i) > 1 ? "assets/svg/Trains.svg" : "assets/svg/Train.svg",
                                        color: Colors.white,
                                        width: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled"  ? 20 : 24,
                                        height: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? 20 : 24,
                                      ),
                                    ),
                                  )
                                else if(widget.tripData.applicationStatus.length > 1 && i + 1 == widget.tripData.applicationStatus.length)
                                  Container(
                                    width: 26,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: widget.tripData.applicationStatus.keys.elementAt(i) == "green" ? Color(0xff00B688) : widget.tripData.applicationStatus.keys.elementAt(i) == "yellow" ? Color(0xffEA9F3F) : widget.tripData.applicationStatus.keys.elementAt(i) == "red" ? Color(0xffFF4242) : widget.tripData.applicationStatus.keys.elementAt(i) == "grey" ? Color(0xffC5CAD1) :  Color(0xffC5CAD1),
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled"  ? "assets/svg/Returned.svg" : widget.tripData.applicationStatus.values.elementAt(i) > 1 ? "assets/svg/Trains.svg" : "assets/svg/Train.svg",
                                        color: Colors.white,
                                        width: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled"  ? 20 : 24,
                                        height: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled"  ? 20 : 24,
                                      ),
                                    ),
                                  ),
                            /*if (tripData.segments.length == 2 &&
                                tripData.segments.first.activeProcess ==
                                    'watching' &&
                                tripData.segments.last.activeProcess ==
                                    'watching')
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
                            if (tripData.segments.length == 2 &&
                                (tripData.segments.first.status == 'opened' &&
                                tripData.segments[1].status == 'opened') &&
                                (tripData.segments[1].activeProcess == null &&
                                tripData.segments.first.activeProcess == null))
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xffC5CAD1),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/svg/Trains.svg",
                                    color: Colors.white,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            if ((tripData.segments.length == 2 &&
                                tripData.segments.first.status == 'returned' &&
                                tripData.segments.last.status == "returned" &&
                                tripData.segments.last.activeProcess == null &&
                                tripData.segments.first.activeProcess == null) ||
                                (tripData.segments.length == 2 &&
                                tripData.segments.first.status == 'canceled' &&
                                tripData.segments.last.status == "canceled" &&
                                tripData.segments.last.activeProcess == null &&
                                tripData.segments.first.activeProcess == null) ||
                                (tripData.segments.length == 2 &&
                                tripData.segments.first.status == 'canceled' &&
                                tripData.segments.last.status == "returned") ||
                                (tripData.segments.length == 2 &&
                                tripData.segments.first.status == 'returned' &&
                                tripData.segments.last.status == "canceled"))
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xffC5CAD1)),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/svg/Returned.svg",
                                    color: Colors.white,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            if (tripData.segments.length == 2 &&
                                tripData.segments.first.status == 'issued' &&
                                tripData.segments.last.status == "issued")
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
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            if (tripData.segments.length == 2)
                              Container(
                                height: 32,
                                child: Row(
                                  children: [
                                    if ((tripData.segments[1].activeProcess != null ||
                                            tripData.segments[1].status == 'issued' ||
                                            tripData.segments[1].status == "returned") &&
                                        tripData.segments.first.status == 'opened' &&
                                        tripData.segments.first.activeProcess == null &&
                                        (tripData.segments.first.status != 'issued' ||
                                            tripData.segments.first.status != "returned"))
                                      Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          color: Color(0xffC5CAD1),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(50),
                                            topLeft: Radius.circular(50),
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
                                    if (tripData.segments.first.status ==
                                            'opened' &&
                                        tripData.segments.first.activeProcess ==
                                            "watching" &&
                                        tripData.segments[1].activeProcess !=
                                            "watching")
                                      Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          color: Color(0xffEA9F3F),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(50),
                                            topLeft: Radius.circular(50),
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
                                    if (tripData.segments.first.status ==
                                            'issued' &&
                                        tripData.segments[1].status != 'issued')
                                      Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          color: Color(0xff00B688),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(50),
                                            topLeft: Radius.circular(50),
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
                                    if (tripData.segments.first.status ==
                                            'returned' &&
                                        tripData.segments[1].status != 'returned' &&
                                        tripData.segments[1].status != 'canceled')
                                      Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          color: Color(0xffC5CAD1),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(50),
                                            topLeft: Radius.circular(50),
                                          ),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/svg/Returned.svg",
                                            color: Colors.white,
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                    if ((tripData.segments.first.activeProcess !=
                                                null ||
                                            tripData.segments.first.status ==
                                                'issued' ||
                                            tripData.segments.first.status ==
                                                "returned") &&
                                        tripData.segments[1].status ==
                                            'opened' &&
                                        tripData.segments[1].activeProcess ==
                                            null &&
                                        (tripData.segments[1].status !=
                                                'issued' ||
                                            tripData.segments[1].status !=
                                                "returned"))
                                      Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          color: Color(0xffC5CAD1),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(50),
                                            bottomRight: Radius.circular(50),
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
                                    if (tripData.segments.first.activeProcess !=
                                            "watching" &&
                                        tripData.segments[1].status ==
                                            'opened' &&
                                        tripData.segments[1].activeProcess ==
                                            "watching")
                                      Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          color: Color(0xffEA9F3F),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(50),
                                            bottomRight: Radius.circular(50),
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
                                    if (tripData.segments.first.status !=
                                            'issued' &&
                                        tripData.segments[1].status == 'issued')
                                      Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          color: Color(0xff00B688),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(50),
                                            bottomRight: Radius.circular(50),
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
                                    if (tripData.segments.first.status != 'returned' &&
                                        tripData.segments[1].status == 'returned' &&
                                        tripData.segments.first.status != 'canceled')
                                      Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          color: Color(0xffC5CAD1),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(50),
                                            bottomRight: Radius.circular(50),
                                          ),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/svg/Returned.svg",
                                            color: Colors.white,
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.keys.elementAt(0) == "green" ?
                Text(widget.tripData.endStation != null
                      ? "в ${widget.tripData.endStation[0].toUpperCase()}${widget.tripData.endStation.toLowerCase().substring(1)} + (${getTimeToWork(tripeDate: widget.tripData.date)})"
                      : "",
                  style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 14,
                      color: Color(0xff748595),
                      fontWeight: FontWeight.w500),
                ) : Text(
                  widget.tripData.endStation != null
                      ? "в ${widget.tripData.endStation[0].toUpperCase()}${widget.tripData.endStation.toLowerCase().substring(1)}"
                      : "",
                  style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 14,
                      color: Color(0xff748595),
                      fontWeight: FontWeight.w500),
                )
                /*Text(
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
                ),*/
              ],
            ),
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.tripData.segments.length,
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
                        widget.tripData.segments[index].icon != null &&
                                widget.tripData.segments[index].icon.isNotEmpty
                            ? Image(
                                image: NetworkImage(widget.tripData.segments[index].icon),
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
                            "${widget.tripData.segments[index].train.depStationName[0].toUpperCase()}${widget.tripData.segments[index].train.depStationName.toLowerCase().substring(1)} - ${widget.tripData.segments[index].train.arrStationName[0].toUpperCase()}${widget.tripData.segments[index].train.arrStationName.toLowerCase().substring(1)}",
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 14,
                                decoration: widget.tripData.segments[index].status == "returned" || widget.tripData.segments[index].status == "canceled"
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: widget.tripData.segments[index].status != "issued"
                                        ? Color(0xff1B344F).withOpacity(0.5)
                                        : Color(0xff1B344F),
                                fontWeight: FontWeight.w500,
                            ),
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
                                      DateTime.parse(widget.tripData.segments[index].train.depDateTime),
                                    ).toString().replaceAll('.', ','),
                                style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 14,
                                  decoration: widget.tripData.segments[index].status == "returned" || widget.tripData.segments[index].status == "canceled"
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: widget.tripData.segments[index].status != "issued"
                                      ? Color(0xff1B344F).withOpacity(0.5)
                                      : Color(0xff1B344F),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              new TextSpan(
                                text: ' ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[index].train.depDateTime))} - ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[index].train.arrDateTime))}',
                                style: new TextStyle(
                                    fontSize: 14,
                                    decoration:
                                        widget.tripData.segments[index].status == "returned" || widget.tripData.segments[index].status == "canceled"
                                            ? TextDecoration.lineThrough
                                            : null,
                                    color: widget.tripData.segments[index].status !=
                                            "issued"
                                        ? Color(0xff1B344F).withOpacity(0.5)
                                        : Color(0xff1B344F),
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
          if(widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.containsKey("yellow"))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Container(
                    width: w,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 22,
                          color: Color(0xff2D4461).withOpacity(0.6),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: w * 0.89,
                          child:  RichText(
                            textAlign: TextAlign.start,
                            text: new TextSpan(
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 13,
                                  color: Color(0xffCFD5DC),
                                  fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                new TextSpan(
                                  text:
                                  'Поездка находится в листе ожидания.',
                                  style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff748595).withOpacity(0.6),
                                  ),
                                ),
                                new TextSpan(
                                  text: widget.tripData.segments[0].watcherTimeLimit != null
                                      ? 'Тайм-лимит оформления: до ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[0].watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[0].watcherTimeLimit))}'
                                      : 'Тайм-лимит оформления: *',
                                  style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff748595).withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          if(widget.tripData.applicationStatus.length > 1 && widget.tripData.applicationStatus.containsKey('yellow')&& widget.tripData.applicationStatus.containsKey('green') && !widget.tripData.applicationStatus.containsKey('red'))
            for(int i = 0; i < widget.tripData.segments.length; i++)
              if(widget.tripData.segments[i].watcherTimeLimit != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 22,
                        color: Color(0xff2D4461).withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: w * 0.89,
                        child:  RichText(
                          textAlign: TextAlign.start,
                          text: new TextSpan(
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 13,
                                color: Color(0xffCFD5DC),
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              new TextSpan(
                                text:
                                'Часть билетов оформлены, а другая находится в листе ожидания. ',
                                style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff748595).withOpacity(0.6),
                                ),
                              ),
                              new TextSpan(
                                text: widget.tripData.segments[i].watcherTimeLimit != null
                                    ? 'Тайм-лимит оформления: до ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[i].watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[i].watcherTimeLimit))}'
                                    : 'Тайм-лимит оформления: *',
                                style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff748595).withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (widget.tripData.applicationStatus.length > 1 && widget.tripData.applicationStatus.containsKey("canceled") && !(widget.tripData.applicationStatus.containsKey("yellow") || widget.tripData.applicationStatus.containsKey("green")))
            for(int i = 0; i < widget.tripData.segments.length; i++)
              if(widget.tripData.segments[i].updatedAt != null && widget.tripData.segments[i].status == 'canceled')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 22,
                        color: Color(0xff2D4461).withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: w * 0.89,
                        child:  RichText(
                          textAlign: TextAlign.start,
                          text: new TextSpan(
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 13,
                                color: Color(0xffCFD5DC),
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              new TextSpan(
                                text:
                                'Часть билетов были отменены. ',
                                style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff748595).withOpacity(0.6),
                                ),
                              ),
                              new TextSpan(
                                    text: widget.tripData.segments[i].updatedAt != null
                                        ? 'Поездка была отменена, по причине: ${widget.tripData.segments[i].closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[i].updatedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[i].updatedAt))}'
                                        : 'Поездка была отменена, по причине: *.  Дата отмены: *. ',
                                    style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff748595).withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          /*if ((widget.tripData.segments.first.activeProcess == "watching" &&
                  widget.tripData.segments[1].status == "issued") ||
              (widget.tripData.segments[1].activeProcess == "watching" &&
                  widget.tripData.segments.first.status == "issued"))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 22,
                        color: Color(0xff2D4461).withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: w * 0.89,
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: new TextSpan(
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 13,
                                color: Color(0xffCFD5DC),
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              new TextSpan(
                                text:
                                    'Часть билетов оформлены, а другая находится в листе ожидания. ',
                                style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff748595).withOpacity(0.6),
                                ),
                              ),
                              new TextSpan(
                                text: widget.tripData.segments.first.watcherTimeLimit != null
                                    ? 'Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.watcherTimeLimit))}'
                                    : widget.tripData.segments[1].watcherTimeLimit != null
                                        ? 'Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[1].watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[1].watcherTimeLimit))}'
                                        : 'Тайм-лимит оформления: *',
                                style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff748595).withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),*/
          if ((widget.tripData.segments.first.activeProcess == "watching" &&
              widget.tripData.segments[1].activeProcess == null &&
              widget.tripData.segments[1].status != "issued" &&
               widget.tripData.segments.first.status == "opened" ) ||
              (widget.tripData.segments[1].activeProcess == "watching" &&
                  widget.tripData.segments.first.status != "issued" &&
                  widget.tripData.segments.first.activeProcess == null) &&
                  widget.tripData.segments[1].status == "opened")
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(widget.tripData.segments.first.activeProcess == "watching" && widget.tripData.segments.first.watcherTimeLimit != null ?
                    'Часть билетов находятся в листе ожидания. Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.watcherTimeLimit))}' :
                      widget.tripData.segments[1].activeProcess == "watching" && widget.tripData.segments[1].watcherTimeLimit != null ? 'Часть билетов находятся в листе ожидания. Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[1].watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[1].watcherTimeLimit))}' :
                      'Часть билетов находятся в листе ожидания. Тайм-лимит оформления: *',
                    style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 13,
                      color: Color(0xff748595),
                      fontWeight: FontWeight.w500),)
                ),
              ],
            ),
          if (widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.containsKey("grey"))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                    width: w,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text('Билеты еще не оформлены.', style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 13,
                        color: Color(0xff748595),
                        fontWeight: FontWeight.w500),)
                ),
              ],
            ),
          if ((widget.tripData.segments.first.activeProcess == null &&
              widget.tripData.segments.first.status == 'opened' &&
              widget.tripData.segments[1].status == 'issued') ||
              (widget.tripData.segments[1].activeProcess == null &&
                  widget.tripData.segments[1].status == 'opened' &&
                  widget.tripData.segments.first.status == "issued"))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                    width: w,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text('Поездка оформлена частично.', style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 13,
                        color: Color(0xff748595),
                        fontWeight: FontWeight.w500),)
                ),
              ],
            ),
          if ((widget.tripData.segments.first.status == "returned" &&
              widget.tripData.segments[1].status == 'issued') ||
              (widget.tripData.segments[1].status == 'returned' &&
                  widget.tripData.segments.first.status == 'issued'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                    width: w,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text( widget.tripData.segments.first.closedReason != null && widget.tripData.segments.first.ticket != null && widget.tripData.segments.first.ticket.returnedAt != null ?
                    'Часть билетов были оформлены. Часть билетов были отменены, по причине: ${widget.tripData.segments.first.closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))}' :
                    widget.tripData.segments[1].closedReason != null && widget.tripData.segments[1].ticket != null && widget.tripData.segments[1].ticket.returnedAt != null ? 'Часть билетов были оформлены. Часть билетов были отменены, по причине: ${widget.tripData.segments[1].closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))}' :
                    'Часть билетов были оформлены. Часть билетов были отменены, по причине: *. Дата отмены: *',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 13,
                          color: Color(0xff748595),
                          fontWeight: FontWeight.w500),)
                ),
              ],
            ),
          if ((widget.tripData.segments.first.status == "returned" &&
              widget.tripData.segments[1].status == 'canceled') ||
              (widget.tripData.segments.first.status == "canceled" &&
                  widget.tripData.segments[1].status == 'returned'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                    width: w,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text( widget.tripData.segments.first.closedReason != null && widget.tripData.segments.first.ticket != null && widget.tripData.segments.first.ticket.returnedAt != null ?
                    'Часть билетов были оформлены. Часть билетов были отменены, по причине: ${widget.tripData.segments.first.closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))}' :
                    widget.tripData.segments[1].closedReason != null && widget.tripData.segments[1].ticket != null && widget.tripData.segments[1].ticket.returnedAt != null ? 'Часть билетов были оформлены. Часть билетов были отменены, по причине: ${widget.tripData.segments[1].closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))}' :
                    'Часть билетов были оформлены. Часть билетов были отменены, по причине: *. Дата отмены: *',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 13,
                          color: Color(0xff748595),
                          fontWeight: FontWeight.w500),)
                ),
              ],
            ),
          if (widget.tripData.segments.first.status == "returned" &&
              widget.tripData.segments[1].status == 'returned')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                    width: w,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text( widget.tripData.segments.first.closedReason != null ? 'Поездка была отменена, по причине:  ${widget.tripData.segments.first.closedReason}' : widget.tripData.segments[1].closedReason != null ? 'Поездка была отменена, по причине:  ${widget.tripData.segments[1].closedReason}' : 'Поездка была отменена, по причине: ',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 13,
                          color: Color(0xff748595),
                          fontWeight: FontWeight.w500),)
                ),
              ],
            ),
          if (widget.tripData.status == "partly" && (widget.tripData.segments.first.status == "returned" ||
              widget.tripData.segments[1].status == 'returned'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                    width: w,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(widget.tripData.segments.first.closedReason != null ? 'Поездка была отменена, по причине:  ${widget.tripData.segments.first.closedReason}' : widget.tripData.segments[1].closedReason != null ? 'Поездка была отменена, по причине:  ${widget.tripData.segments[1].closedReason}' : 'Поездка была отменена, по причине: ',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 13,
                          color: Color(0xff748595),
                          fontWeight: FontWeight.w500),
                    ),
                ),
              ],
            ),
          if (widget.tripData.overTime != 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  child: Text(
                    'У вас овертайм +${widget.tripData.overTime} дней,  билеты на новую дату куплены',
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
  int _totalPrice = 0;

  Dio dio = Dio();

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  void _calculateTicketPrice() {
    if (widget.tripData.segments.isNotEmpty) {
      for (int i = 0; i < widget.tripData.segments.length; i++) {
        if (widget.tripData.segments[i].ticket != null) {
          _totalPrice += widget.tripData.segments[i].ticket.sum;
        }
      }
    }
  }
  void statusCode(){
    if(widget.tripData.applicationStatus == null){
      widget.tripData.applicationStatus = LoginProvider().getStatusApplication(widget.tripData);
    }
    if(widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.containsKey("yellow")){
      widget.tripData.segments.sort((b, a) => b.watcherTimeLimit.compareTo(a.watcherTimeLimit));
      widget.tripData.segments.where((element) => element.watcherTimeLimit != null);
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
    super.initState();
    statusCode();
    _calculateTicketPrice();

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");
    FlutterDownloader.registerCallback(downloadingCallback);

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
                      Container(
                        width: w * 0.40,
                        margin: EdgeInsets.only(bottom: 2),
                        child: Text(
                          "Заявка №${widget.tripData.id}",
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 14,
                            color: Color(0xff0C2B4C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
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
                                fontWeight: FontWeight.bold,
                              ),
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
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Text(
                              "В ${widget.tripData.endStation[0].toUpperCase()}${widget.tripData.endStation.toLowerCase().substring(1)}. " + durationToString().toString() + " в пути",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff748595).withOpacity(0.7),
                              ),
                            ),
                          ),
                          if(widget.tripData.shift == 'night')
                          SvgPicture.asset(
                            "assets/svg/Moon.svg",
                          ),
                          if(widget.tripData.shift == 'night')
                            Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child:  Text(
                              'Ночная смена',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xff748595)
                                      .withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(
                      Icons.close,
                      size: 24,
                      color: Color(0xff748595),
                    ),
                  ),
                  /*GestureDetector(
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
                  ),*/
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
                            if((widget.tripData.segments[index].status == "opened" && (widget.tripData.segments[index].activeProcess == null || widget.tripData.segments[index].activeProcess == "booking" )) || widget.tripData.segments[index].status == "canceled")
                              Column(
                              children: [
                                widget.tripData.productKey == "rail"
                                    ? SvgPicture.asset(
                                        "assets/svg/Train.svg",
                                        color: Color(0xff1BBC2CA),
                                        width: 24,
                                        height: 24,
                                      )
                                    : SvgPicture.asset(
                                        "assets/svg/Plane.svg",
                                        color: Color(0xff1BBC2CA),
                                        width: 24,
                                        height: 24,
                                      ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 3),
                                  width: 2,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xff1BBC2CA),
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
                                      color: Color(0xff1BBC2CA),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            if(widget.tripData.segments[index].status == "opened" && widget.tripData.segments[index].activeProcess == "watching")
                              Column(
                                children: [
                                  widget.tripData.productKey == "rail"
                                      ? SvgPicture.asset(
                                    "assets/svg/Train.svg",
                                    color: Color(0xffFFBE6B),
                                    width: 24,
                                    height: 24,
                                  ) : SvgPicture.asset(
                                    "assets/svg/Plane.svg",
                                    color: Color(0xffFFBE6B),
                                    width: 24,
                                    height: 24,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 3),
                                    width: 2,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xffFFBE6B),
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
                                        color: Color(0xffFFBE6B),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            if(widget.tripData.segments[index].status == "returned" )
                              Column(
                                children: [
                                  widget.tripData.productKey == "rail"
                                      ? SvgPicture.asset(
                                    "assets/svg/Train.svg",
                                    color: Color(0xffFF4242),
                                    width: 24,
                                    height: 24,
                                  )
                                      : SvgPicture.asset(
                                    "assets/svg/Plane.svg",
                                    color: Color(0xffFF4242),
                                    width: 24,
                                    height: 24,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 3),
                                    width: 2,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xffFF4242),
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
                                        color: Color(0xffFF4242),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            if(widget.tripData.segments[index].status == "issued")
                              Column(
                                children: [
                                  widget.tripData.productKey == "rail"
                                      ? SvgPicture.asset(
                                    "assets/svg/Train.svg",
                                    color: Color(0xff00B688),
                                    width: 24,
                                    height: 24,
                                  )
                                      : SvgPicture.asset(
                                    "assets/svg/Plane.svg",
                                    color: Color(0xff00B688),
                                    width: 24,
                                    height: 24,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 3),
                                    width: 2,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xff00B688),
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
                                        color: Color(0xff00B688),
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
                                        if(widget.tripData.segments[index].status == "opened" && widget.tripData.segments[index].activeProcess == null)
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.25,
                                                child: Text(
                                                  'вагон',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Root",
                                                      fontSize: 14,
                                                      color: Color(0xff748595).withOpacity(0.7)),
                                                ),
                                              ),
                                              Container(
                                                width: w * 0.55,
                                                child: Text(
                                                  "билеты не куплены",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff1B344F).withOpacity(0.3),),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if(widget.tripData.segments[index].status == "opened" && widget.tripData.segments[index].activeProcess == "watching")
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.25,
                                                child: Text(
                                                  'вагон',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Root",
                                                      fontSize: 14,
                                                      color: Color(0xff748595).withOpacity(0.7)),
                                                ),
                                              ),
                                              Container(
                                                width: w * 0.55,
                                                child: Text(
                                                  "билеты в листе ожидания",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xffEA9F3F),),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if(widget.tripData.segments[index].status == "returned" && widget.tripData.segments.first.ticket != null && widget.tripData.segments.first.ticket.carNumber != null)
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.25,
                                                child: Text(
                                                  'вагон',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Root",
                                                      fontSize: 14,
                                                      color: Color(0xff748595).withOpacity(0.3)),
                                                ),
                                              ),
                                              Container(
                                                width: w * 0.55,
                                                child: Text(
                                                  '№${widget.tripData.segments.first.ticket.carNumber}, ${widget.tripData.segments.first.ticket.carTypeLabel}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff1B344F).withOpacity(0.3),),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if(widget.tripData.segments[index].status == "issued")
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.25,
                                                child: Text(
                                                  'вагон',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Root",
                                                      fontSize: 14,
                                                      color: Color(0xff748595).withOpacity(0.7)),
                                                ),
                                              ),
                                              Container(
                                                width: w * 0.55,
                                                child: Text(
                                                  widget.tripData.segments.first.ticket.carTypeLabel != null && widget.tripData.segments.first.ticket.carNumber != null?
                                                  '№${widget.tripData.segments.first.ticket.carNumber}, ${widget.tripData.segments.first.ticket.carTypeLabel}' :  '*',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff1B344F),),
                                                ),
                                              ),
                                            ],
                                          ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        if(widget.tripData.segments[index].status == "opened" && widget.tripData.segments[index].activeProcess == null)
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.25,
                                                child: Text(
                                                  'место',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Root",
                                                      fontSize: 14,
                                                      color: Color(0xff748595).withOpacity(0.7)),
                                                ),
                                              ),
                                              Container(
                                                width: w * 0.55,
                                                child: Text(
                                                  "билеты не куплены",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff1B344F).withOpacity(0.3),),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if(widget.tripData.segments[index].status == "opened" && widget.tripData.segments[index].activeProcess == "watching")
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.25,
                                                child: Text(
                                                  'место',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Root",
                                                      fontSize: 14,
                                                      color: Color(0xff748595).withOpacity(0.7)),
                                                ),
                                              ),
                                              Container(
                                                width: w * 0.55,
                                                child: Text(
                                                  "билеты в листе ожидания",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xffEA9F3F),),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if(widget.tripData.segments[index].status == "returned" && widget.tripData.segments.first.ticket != null && widget.tripData.segments.first.ticket.places != null)
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.25,
                                                child: Text(
                                                  'место',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Root",
                                                      fontSize: 14,
                                                      color: Color(0xff748595).withOpacity(0.3)),
                                                ),
                                              ),
                                              Container(
                                                width: w * 0.55,
                                                child: Text(
                                                  '№${widget.tripData.segments.first.ticket.places.first.number}, ${widget.tripData.segments.first.ticket.places.first.floor > 1 ? 'верхнее' : 'нижнее'}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff1B344F).withOpacity(0.3),),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if(widget.tripData.segments[index].status == "issued")
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.25,
                                                child: Text(
                                                  'место',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Root",
                                                      fontSize: 14,
                                                      color: Color(0xff748595).withOpacity(0.7)),
                                                ),
                                              ),
                                              Container(
                                                width: w * 0.55,
                                                child: Text(
                                                  widget.tripData.segments.first.ticket.places != null && widget.tripData.segments.first.ticket.places.isNotEmpty ?
                                                  '№${widget.tripData.segments.first.ticket.places.first.number}, ${widget.tripData.segments.first.ticket.places.first.floor > 1 ? 'верхнее' : 'нижнее'}' :  '*',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff1B344F),),
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
            Divider(
              thickness: 1,
              height: 0,
              color: Color(0xffEBEBEB),
            ),
            if (widget.tripData.applicationStatus.length > 1 && widget.tripData.applicationStatus.containsKey("canceled") && !(widget.tripData.applicationStatus.containsKey("yellow") || widget.tripData.applicationStatus.containsKey("green")))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time_rounded, color: Color(0xff1B344F), size: 20,),
                        SizedBox(width: 5,),
                        Text('Часть билетов были отменены!',
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 17,
                              color: Color(0xff1B344F),
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  for(int i = 0; i < widget.tripData.segments.length; i++)
                    if(widget.tripData.segments[i].status == "canceled")
                  Container(
                      width: w,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text( widget.tripData.segments[i].closedReason != null && widget.tripData.segments[i].updatedAt != null ?
                      'Поездка была отменена, по причине: ${widget.tripData.segments[i].closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[i].updatedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[i].updatedAt))}' :
                      'Поездка была отменена, по причине: *. Дата отмены: *',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 13,
                            color: Color(0xff748595),
                            fontWeight: FontWeight.w500),)
                  ),
                ],
              ),
            if(widget.tripData.applicationStatus.length == 2 && widget.tripData.applicationStatus.containsKey('yellow') && widget.tripData.applicationStatus.containsKey('green'))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    alignment: Alignment.center,
                    child: Text('Поездка оформлена частично.',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 17,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    width: w,
                    child: Container(
                      width: w * 0.89,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: new TextSpan(
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 15,
                              color: Color(0xffCFD5DC),
                              fontWeight: FontWeight.w400),
                          children: <TextSpan>[
                            new TextSpan(
                              text:
                              'Часть билетов оформлены, а другая находится в листе ожидания. ',
                              style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff748595).withOpacity(0.6),
                              ),
                            ),
                            new TextSpan(
                              text: widget.tripData.segments.first.watcherTimeLimit != null
                                  ? 'Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.watcherTimeLimit))}'
                                  : widget.tripData.segments[1].watcherTimeLimit != null
                                  ? 'Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[1].watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[1].watcherTimeLimit))}'
                                  : 'Тайм-лимит оформления: *',
                              style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff748595).withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if(widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.containsKey('yellow'))
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    alignment: Alignment.center,
                    child: Text('Билеты еще не куплены!',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 17,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    width: w,
                    child: Container(
                      width: w * 0.89,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: new TextSpan(
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 15,
                              color: Color(0xffCFD5DC),
                              fontWeight: FontWeight.w400),
                          children: <TextSpan>[
                            new TextSpan(
                              text:
                              'Поездка находится в листе ожидания.  ',
                              style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff748595).withOpacity(0.6),
                              ),
                            ),
                            new TextSpan(
                              text: widget.tripData.segments[0].watcherTimeLimit != null
                                  ? 'Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[0].watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[0].watcherTimeLimit))}'
                                  : 'Тайм-лимит оформления: *',
                              style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff748595).withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if ((widget.tripData.segments.first.activeProcess == "watching" &&
                widget.tripData.segments[1].activeProcess == null &&
                widget.tripData.segments[1].status != "issued" &&
                widget.tripData.segments.first.status == "opened" ) ||
                (widget.tripData.segments[1].activeProcess == "watching" &&
                    widget.tripData.segments.first.status != "issued" &&
                    widget.tripData.segments.first.activeProcess == null) &&
                    widget.tripData.segments[1].status == "opened")
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time_rounded, color: Color(0xff1B344F), size: 20,),
                        SizedBox(width: 5,),
                        Text('Билеты еще не куплены!',
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 17,
                              color: Color(0xff1B344F),
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: w,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(widget.tripData.segments.first.activeProcess == "watching" && widget.tripData.segments.first.watcherTimeLimit != null ?
                      'Часть билетов находятся в листе ожидания. Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.watcherTimeLimit))}' :
                      widget.tripData.segments[1].activeProcess == "watching" && widget.tripData.segments[1].watcherTimeLimit != null ? 'Часть билетов находятся в листе ожидания. Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[1].watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[1].watcherTimeLimit))}' :
                      'Часть билетов находятся в листе ожидания. Тайм-лимит оформления: *',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 15,
                            color: Color(0xff1B344F).withOpacity(0.5),
                            fontWeight: FontWeight.w500),)
                  ),
                ],
              ),
            if (widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.containsKey("grey"))
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: w,
                      margin: EdgeInsets.only(top: 20, bottom: 12),
                      alignment: Alignment.center,
                      child: Text('Билеты еще не куплены!',
                        style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 17,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.w800),
                      ),
                  ),
                  Container(
                    width: w * 0.9,
                    child: Text(
                      'Когда координатор закупит и оформит билеты на данную поездку, отобразится вся необходимая информация.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 15,
                        color: Color(0xff1B344F).withOpacity(0.5),
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
            if ((widget.tripData.segments.first.activeProcess == null &&
                widget.tripData.segments.first.status == 'opened' &&
                widget.tripData.segments[1].status == 'issued') ||
                (widget.tripData.segments[1].activeProcess == null &&
                    widget.tripData.segments[1].status == 'opened' &&
                    widget.tripData.segments.first.status == "issued"))
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    alignment: Alignment.center,
                    child: Text('Поездка оформлена частично.',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 17,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  if(widget.tripData.segments.first.status == "issued")
                    Container(
                    width: w * 0.9,
                    child: Text(
                      'Билеты оформлены по направлению: ${widget.tripData.segments[0].train.depStation} - ${widget.tripData.segments[0].train.arrStation}.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 15,
                          color: Color(0xff1B344F).withOpacity(0.5),
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  if(widget.tripData.segments[1].status == "issued")
                    Container(
                      width: w * 0.9,
                      child: Text(
                        'Билеты оформлены по направлению: ${widget.tripData.segments[1].train.depStation} - ${widget.tripData.segments[1].train.arrStation}.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 15,
                            color: Color(0xff1B344F).withOpacity(0.5),
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                ],
              ),
            if ((widget.tripData.segments.first.status == "returned" &&
                widget.tripData.segments[1].status == 'issued') ||
                (widget.tripData.segments[1].status == 'returned' &&
                    widget.tripData.segments.first.status == 'issued'))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    alignment: Alignment.center,
                    child: Text('Часть билетов были оформлены,  часть билетов были отменены!',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 17,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  if(widget.tripData.segments.first.status == "returned")
                    Container(
                      width: w,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text( widget.tripData.segments.first.closedReason != null && widget.tripData.segments.first.ticket != null && widget.tripData.segments.first.ticket.returnedAt != null ?
                      'Билеты по направлению ${widget.tripData.segments[0].train.depStation} - ${widget.tripData.segments[0].train.arrStation} были отменены, по причине: ${widget.tripData.segments.first.closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))}' :
                      'Часть билетов были оформлены. Часть билетов были отменены, по причине: *. Дата отмены: *',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 13,
                            color: Color(0xff748595),
                            fontWeight: FontWeight.w500),)
                  ),
                  if(widget.tripData.segments[1].status == "returned")
                    Container(
                        width: w,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text( widget.tripData.segments[1].closedReason != null && widget.tripData.segments[1].ticket != null && widget.tripData.segments[1].ticket.returnedAt != null ?
                        'Билеты по направлению ${widget.tripData.segments[1].train.depStation} - ${widget.tripData.segments[1].train.arrStation} были отменены, по причине: ${widget.tripData.segments[1].closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))}' :
                        'Билеты по направлению * были оформлены. Часть билетов были отменены, по причине: *. Дата отмены: *',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500),)
                    ),
                ],
              ),
            if (widget.tripData.segments.first.status == "returned" &&
                widget.tripData.segments[1].status == 'returned')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time_rounded, color: Color(0xff1B344F), size: 20,),
                        SizedBox(width: 5,),
                        Text('Поездка отменена!',
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 17,
                              color: Color(0xff1B344F),
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),

                  Container(
                      width: w,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text( widget.tripData.segments.first.closedReason != null && widget.tripData.segments.first.ticket != null && widget.tripData.segments.first.ticket.returnedAt != null ?
                      'Часть билетов были оформлены. Часть билетов были отменены, по причине: ${widget.tripData.segments.first.closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))}' :
                      widget.tripData.segments[1].closedReason != null && widget.tripData.segments[1].ticket != null && widget.tripData.segments[1].ticket.returnedAt != null ? 'Часть билетов были оформлены. Часть билетов были отменены, по причине: ${widget.tripData.segments[1].closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))}' :
                      'Часть билетов были оформлены. Часть билетов были отменены, по причине: *. Дата отмены: *',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 13,
                            color: Color(0xff748595),
                            fontWeight: FontWeight.w500),)
                  ),
                ],
              ),
            if ((widget.tripData.segments.first.status == "returned" &&
                widget.tripData.segments[1].status == 'canceled') ||
                (widget.tripData.segments.first.status == "canceled" &&
                    widget.tripData.segments[1].status == 'returned'))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time_rounded, color: Color(0xff1B344F), size: 20,),
                        SizedBox(width: 5,),
                        Text('Поездка отменена!',
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 17,
                              color: Color(0xff1B344F),
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),

                  if(widget.tripData.segments.first.status == "returned")
                    Container(
                        width: w,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text( widget.tripData.segments.first.closedReason != null && widget.tripData.segments.first.ticket != null && widget.tripData.segments.first.ticket.returnedAt != null ?
                        'Билеты по направлению ${widget.tripData.segments[0].train.depStation} - ${widget.tripData.segments[0].train.arrStation} были отменены, по причине: ${widget.tripData.segments.first.closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))}' :
                        'Часть билетов были оформлены. Часть билетов были отменены, по причине: *. Дата отмены: *',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500),)
                    ),
                  if(widget.tripData.segments[1].status == "returned")
                    Container(
                        width: w,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text( widget.tripData.segments[1].closedReason != null && widget.tripData.segments[1].ticket != null && widget.tripData.segments[1].ticket.returnedAt != null ?
                        'Билеты по направлению ${widget.tripData.segments[1].train.depStation} - ${widget.tripData.segments[1].train.arrStation} были отменены, по причине: ${widget.tripData.segments[1].closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))}' :
                        'Билеты по направлению * были оформлены. Часть билетов были отменены, по причине: *. Дата отмены: *',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500),)
                    ),
                ],
              ),
            if (widget.tripData.applicationStatus.length > 1 && widget.tripData.applicationStatus.containsKey("red"))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    alignment: Alignment.center,
                    child: Text('Часть билетов были отменены!',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 17,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  for(int i = 0; i < widget.tripData.segments.length; i++)
                  if(widget.tripData.segments[i].status == "returned" || widget.tripData.segments[i].status == "canceled")
                    Container(
                        width: w,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text( widget.tripData.segments[i].closedReason != null && widget.tripData.segments[i].ticket != null && widget.tripData.segments[i].ticket.returnedAt != null ?
                        'Билеты по направлению ${widget.tripData.segments[i].train.depStation} - ${widget.tripData.segments[i].train.arrStation} были отменены, по причине: ${widget.tripData.segments[i].closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[i].ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[i].ticket.returnedAt))}' :
                        'Часть билетов были отменены, по причине: *. Дата отмены: *',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500),)
                    ),
                ],
              ),
            if (widget.tripData.status == "opened" && (widget.tripData.segments.first.status == "returned" ||
                widget.tripData.segments[1].status == 'returned'))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    alignment: Alignment.center,
                    child: Text('Часть билетов были отменены!',
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 17,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  if(widget.tripData.segments.first.status == "returned")
                    Container(
                        width: w,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text( widget.tripData.segments.first.closedReason != null && widget.tripData.segments.first.ticket != null && widget.tripData.segments.first.ticket.returnedAt != null ?
                        'Билеты по направлению ${widget.tripData.segments[0].train.depStation} - ${widget.tripData.segments[0].train.arrStation} были отменены, по причине: ${widget.tripData.segments.first.closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.ticket.returnedAt))}' :
                        'Часть билетов были оформлены. Часть билетов были отменены, по причине: *. Дата отмены: *',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500),)
                    ),
                  if(widget.tripData.segments[1].status == "returned")
                    Container(
                        width: w,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text( widget.tripData.segments[1].closedReason != null && widget.tripData.segments[1].ticket != null && widget.tripData.segments[1].ticket.returnedAt != null ?
                        'Билеты по направлению ${widget.tripData.segments[1].train.depStation} - ${widget.tripData.segments[1].train.arrStation} были отменены, по причине: ${widget.tripData.segments[1].closedReason}. Дата отмены: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[1].ticket.returnedAt))}' :
                        'Билеты по направлению * были оформлены. Часть билетов были отменены, по причине: *. Дата отмены: *',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 13,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500),)
                    ),
                ],
              ),

            widget.tripData.segments.first.status == "issued" && widget.tripData.segments[1].status == "issued" ?
            Column(
              children: [
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
                            'Билет 1',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Root",
                              fontSize: 16,
                              color: Color(0xff1B344F),
                            ),
                          ),
                          Text(
                            //'${widget.tripData.segments[index].train} тг',
                            widget.tripData.segments[0].ticket != null ? '${widget.tripData.segments[0].ticket.sum} тг' : '* тг',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Билет 2',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Root",
                              fontSize: 16,
                              color: Color(0xff1B344F),
                            ),
                          ),
                          Text(
                            //'${widget.tripData.segments[index].train} тг',
                            widget.tripData.segments[1].ticket != null ? '${widget.tripData.segments[1].ticket.sum} тг' : '* тг',
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
                    gradient: RadialGradient(radius: 4,
                      colors: [
                        Color(0xff1989DD),
                        Color(0xff1262CB),
                      ],
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      if(widget.tripData.segments.first.ticket != null && widget.tripData.segments.first.ticket.ticketUrl != null){
                        final status = await Permission.storage.request();

                        if (status.isGranted) {
                          final externalDir = await getExternalStorageDirectory();
                          FlutterDownloader.enqueue(
                            url: widget.tripData.segments.first.ticket.ticketUrl,
                            savedDir: externalDir.path,
                            fileName: "Билет ${widget.tripData.segments[0].train.depStation} - ${widget.tripData.segments[0].train.arrStation} ${DateFormat.MMMEd('ru').format(DateTime.parse(widget.tripData.segments[0].train.depDateTime),
                            ).toString().replaceAll('.', ',')}",
                            showNotification: true,
                            openFileFromNotification: true,
                          ).then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFScreen(path: externalDir.path, title: "Билет ${widget.tripData.segments[0].train.depStation} - ${widget.tripData.segments[0].train.arrStation} ${DateFormat.MMMEd('ru').format(DateTime.parse(widget.tripData.segments[0].train.depDateTime),
                                ).toString().replaceAll('.', ',')}",),
                              ),
                            );
                          });
                        } else {
                          print("Permission deined");
                        }
                      }else{
                        print("Ticket not found");
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
            ) :
            (widget.tripData.segments.first.status == "issued" && widget.tripData.segments[1].status != "issued") || (widget.tripData.segments[1].status == "issued" && widget.tripData.segments.first.status != "issued" ) ?
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
                  if (widget.tripData.segments.first.ticket != null &&
                      widget.tripData.segments.first.ticket.ticketUrl != null) {
                    final status = await Permission.storage.request();

                    if (status.isGranted) {
                      var tempDir = await getTemporaryDirectory();
                      String fullPath = tempDir.path + "/boo2.pdf'";
                      print('full path ${fullPath}');

                      download2(dio, widget.tripData.segments.first.ticket.ticketUrl, fullPath).whenComplete(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFScreen(
                              path: fullPath,
                              title:
                              "Билет ${widget.tripData.segments[0].train.depStation} - ${widget.tripData.segments[0].train.arrStation} ${DateFormat.MMMEd('ru').format(
                                DateTime.parse(widget.tripData.segments[0]
                                    .train.depDateTime),
                              ).toString()}",
                            ),
                          ),
                        );
                      });
                    }
                  }
                },
                child: widget.tripData.segments.first.status == "issued" ?
                Center(
                  child: Text(
                    'Скачать билет: ${widget.tripData.segments[0].train.depStation} - ${widget.tripData.segments[0].train.arrStation}',
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ) : widget.tripData.segments[1].status == "issued" ? Center(
                  child: Text(
                    'Скачать билет: ${widget.tripData.segments[1].train.depStation} - ${widget.tripData.segments[1].train.arrStation}',
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ) : Center(
                  child: Text(
                    'Скачать билеты',
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ) : Container(),
            /*Container(
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
                        '${widget.tripData.segments.first.ticket != null ? widget.tripData.segments.first.ticket.sum : ''} тг',
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
                  *//*Row(
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
                  ),*//*
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
            ),*/

          ],
        ),
      ),
    );
  }
}

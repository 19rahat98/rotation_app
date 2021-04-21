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
                                      widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? "assets/svg/Returned.svg" : widget.tripData.applicationStatus.values.elementAt(i) > 1 ? "assets/svg/Trains.svg" : "assets/svg/Train.svg",
                                      color: Colors.white,
                                      width: widget.tripData.applicationStatus.keys.elementAt(i) == "red" ? 18 : 22,
                                      height: widget.tripData.applicationStatus.keys.elementAt(i) == "red" ? 18 : 22,
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
                                      width: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? 18 : 22,
                                      height: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? 18 : 22,
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
                                        width: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled"  ? 18 : 22,
                                        height: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? 18 : 22,
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
                                        width: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? 18 : 22,
                                        height: widget.tripData.applicationStatus.keys.elementAt(i) == "red" || widget.tripData.applicationStatus.keys.elementAt(i) == "canceled" ? 18 : 22,
                                      ),
                                    ),
                                  ),
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
                            ? widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ?
                                Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        widget.tripData.segments[index].icon,
                                        colorBlendMode: BlendMode.lighten,
                                        color: Color(0xffCFD5DC),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                : Image(
                                    image: NetworkImage(
                                        widget.tripData.segments[index].icon),
                                    width: 22,
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
                            overflow: TextOverflow.ellipsis,
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
                        child: Row(
                          children: [
                            Expanded(
                              child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                text: new TextSpan(
                                  children: <TextSpan>[
                                    new TextSpan(
                                      text: DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[index].train.depDateTime),).toString().replaceAll('.', ','),
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
                            if(widget.tripData.segments[index].status == "yellow")
                            Icon(
                              Icons.access_time_rounded,
                              size: 12,
                              color: Color(0xff2D4461).withOpacity(0.6),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          if(widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.containsKey('green'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Поездка оформлена.',
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 14,
                        color: Color(0xff748595),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          if(!widget.tripData.applicationStatus.containsKey('yellow') && !widget.tripData.applicationStatus.containsKey('red') && !widget.tripData.applicationStatus.containsKey('all') && !widget.tripData.applicationStatus.containsKey('grey'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Поездка оформлена.',
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 14,
                        color: Color(0xff748595),
                        fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          if(!widget.tripData.applicationStatus.containsKey('yellow') && !widget.tripData.applicationStatus.containsKey('green') && !widget.tripData.applicationStatus.containsKey('all') && !widget.tripData.applicationStatus.containsKey('grey'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Поездка отменена.',
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 14,
                        color: Color(0xff748595),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          if(widget.tripData.applicationStatus.containsKey('green') && !widget.tripData.applicationStatus.containsKey('yellow'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Поездка оформлена не полностью.',
                    style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 14,
                      color: Color(0xff748595),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          if(widget.tripData.applicationStatus.containsKey('green') && widget.tripData.applicationStatus.containsKey('yellow'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w * 0.89,
                  child:  RichText(
                    textAlign: TextAlign.start,
                    text: new TextSpan(
                      style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 12,
                        color: Color(0xff748595),
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                          text:
                          'Поездка оформлена не полностью. ',
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 12,
                            color: Color(0xff748595),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: widget.tripData.watcherTimeLimit != null
                              ? 'Тайм-лимит оформления: до ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.watcherTimeLimit))}'
                              : '',
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 12,
                            color: Color(0xff748595),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          if(!widget.tripData.applicationStatus.containsKey('green') && widget.tripData.applicationStatus.containsKey('yellow'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w * 0.89,
                  child:  RichText(
                    textAlign: TextAlign.start,
                    text: new TextSpan(
                      style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 12,
                        color: Color(0xff748595),
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                          text:
                          'Поездка не оформлена. ',
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 12,
                            color: Color(0xff748595),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: widget.tripData.watcherTimeLimit != null
                              ? 'Тайм-лимит оформления: до ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.watcherTimeLimit))}'
                              : '',
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 12,
                            color: Color(0xff748595),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          if(!widget.tripData.applicationStatus.containsKey('green') && !widget.tripData.applicationStatus.containsKey('yellow') && !(!widget.tripData.applicationStatus.containsKey('yellow') && !widget.tripData.applicationStatus.containsKey('green') && !widget.tripData.applicationStatus.containsKey('all') && !widget.tripData.applicationStatus.containsKey('grey')))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  width: w * 0.89,
                  child:  RichText(
                    textAlign: TextAlign.start,
                    text: new TextSpan(
                      style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 12,
                        color: Color(0xff748595),
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                          text:
                          'Поездка не оформлена. ',
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 12,
                            color: Color(0xff748595),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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
    _calculateTicketPrice();
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
                            if(widget.tripData.segments[index].status == "opened" && (widget.tripData.segments[index].activeProcess == null || widget.tripData.segments[index].activeProcess == "booking" ))
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
                            if(widget.tripData.segments[index].status == "returned" || widget.tripData.segments[index].status == "canceled")
                              Column(
                                children: [
                                  widget.tripData.productKey == "rail"
                                      ? SvgPicture.asset(
                                    "assets/svg/Train.svg",
                                    color: Color(0xff2D4461).withOpacity(0.4),
                                    width: 24,
                                    height: 24,
                                  )
                                      : SvgPicture.asset(
                                    "assets/svg/Plane.svg",
                                    color: Color(0xff2D4461).withOpacity(0.4),
                                    width: 24,
                                    height: 24,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 3),
                                    width: 2,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xff2D4461).withOpacity(0.4),
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
                                        color: Color(0xff2D4461).withOpacity(0.4),
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
                                        widget.tripData.segments[index].icon != null && widget.tripData.segments[index].icon.isNotEmpty
                                            ? widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ?
                                                Container(
                                                    width: 33,
                                                    height: 33,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(100),
                                                      child: Image.network(
                                                        widget
                                                            .tripData
                                                            .segments[index]
                                                            .icon,
                                                        colorBlendMode: BlendMode.lighten,
                                                        color: Color(0xffCFD5DC),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )
                                                : Image(
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
                                          margin: EdgeInsets.only(left: 10, bottom: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateFormat.MMMEd('ru').format(
                                                      DateTime.parse(widget
                                                          .tripData
                                                          .segments[index]
                                                          .train
                                                          .depDateTime),
                                                    ).toString().replaceAll('.', ','),
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 16,
                                                    color: widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ? Color(0xff1B344F).withOpacity(0.3) : Color(0xff1B344F),
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
                                                      color: widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ? Color(0xff1B344F).withOpacity(0.3) : Color(0xff1B344F),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                "${widget.tripData.segments[index].train.depStationName[0].toUpperCase()}${widget.tripData.segments[index].train.depStationName.toLowerCase().substring(1)}, ${widget.tripData.segments[index].depStationName[0].toUpperCase()}${widget.tripData.segments[index].depStationName.toLowerCase().substring(1)}",
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ? Color(0xff1B344F).withOpacity(0.3) : Color(0xff1B344F).withOpacity(0.7),
                                                    fontWeight: FontWeight.bold),
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
                                                    color: widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ? Color(0xff1B344F).withOpacity(0.3) : Color(0xff1B344F).withOpacity(0.7).withOpacity(0.7),
                                                ),
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
                                                    color: widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ? Color(0xff1B344F).withOpacity(0.3) : Color(0xff1B344F).withOpacity(0.7).withOpacity(0.7),
                                                ),
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
                                                    color: widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ? Color(0xff1B344F).withOpacity(0.3) : Color(0xff1B344F).withOpacity(0.7).withOpacity(0.7),
                                                ),
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
                                                    color: widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ? Color(0xff1B344F).withOpacity(0.3) : Color(0xff1B344F).withOpacity(0.7).withOpacity(0.7),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        if(widget.tripData.segments[index].status == "opened" && (widget.tripData.segments[index].activeProcess == null || widget.tripData.segments[index].activeProcess == "booking"))
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
                                        /*if(widget.tripData.segments[index].status == "returned" && widget.tripData.segments[index].status == "canceled" )
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
                                          ),*/
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
                                        if(widget.tripData.segments[index].status == "opened" && (widget.tripData.segments[index].activeProcess == null || widget.tripData.segments[index].activeProcess == "booking"))
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
                                        /*if(widget.tripData.segments[index].status == "returned" && widget.tripData.segments[index].status == "canceled" )
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
                                          ),*/
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
                                        widget.tripData.segments[index].icon != null && widget.tripData.segments[index].icon.isNotEmpty
                                            ? widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ?
                                        Container(
                                          width: 33,
                                          height: 33,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                100),
                                            child: Image.network(
                                              widget
                                                  .tripData
                                                  .segments[index]
                                                  .icon,
                                              colorBlendMode: BlendMode.lighten,
                                              color: Color(0xffCFD5DC),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                            : Image(
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
                                                    color: widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ? Color(0xff1B344F).withOpacity(0.3) : Color(0xff1B344F),
                                                    fontWeight: FontWeight.bold),
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
                                                      color: widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ? Color(0xff1B344F).withOpacity(0.3) : Color(0xff1B344F),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                "${widget.tripData.segments[index].train.arrStationName[0].toUpperCase()}${widget.tripData.segments[index].train.arrStationName.toLowerCase().substring(1)}, ${widget.tripData.segments[index].arrStationName[0].toUpperCase()}${widget.tripData.segments[index].arrStationName.toLowerCase().substring(1)}",
                                                style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: widget.tripData.segments[index].status == 'returned' || widget.tripData.segments[index].status == 'canceled' ? Color(0xff1B344F).withOpacity(0.3) : Color(0xff1B344F).withOpacity(0.7),
                                                    fontWeight: FontWeight.bold,
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
           /*Divider(
              thickness: 1,
              height: 0,
              color: Color(0xffEBEBEB),
            ),*/
            //Icon(Icons.access_time_rounded, color: Color(0xff1B344F), size: 20,),
            /*if(widget.tripData.applicationStatus.containsKey('green'))
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
                      for(int i = 0; i < widget.tripData.segments.length; i++)
                        if(widget.tripData.segments[i].status == 'issued')
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ЖД билет №${i}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Root",
                                    fontSize: 16,
                                    color: Color(0xff1B344F),
                                  ),
                                ),
                                Text(
                                  //'${widget.tripData.segments[index].train} тг',
                                  widget.tripData.segments[i].ticket != null ? '${widget.tripData.segments[i].ticket.sum} тг' : '* тг',
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
                          ],
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
            ),*/

            //-------------------------------------//

            if(widget.tripData.applicationStatus.length == 1 && widget.tripData.applicationStatus.containsKey('green'))
              Column(
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 16,),
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
                        for(int i = 0; i < widget.tripData.segments.length; i++)
                          if(widget.tripData.segments[i].status == 'issued')
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ЖД билет №${i}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Root",
                                        fontSize: 16,
                                        color: Color(0xff1B344F),
                                      ),
                                    ),
                                    Text(
                                      //'${widget.tripData.segments[index].train} тг',
                                      widget.tripData.segments[i].ticket != null ? '${widget.tripData.segments[i].ticket.sum} тг' : '* тг',
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
                              ],
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
              ),
            if(!widget.tripData.applicationStatus.containsKey('yellow') && !widget.tripData.applicationStatus.containsKey('red') && !widget.tripData.applicationStatus.containsKey('all') && !widget.tripData.applicationStatus.containsKey('grey'))
              Column(
                children: [
                  Container(
                    width: w,
                    margin: EdgeInsets.only(top: 12,),
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
                        for(int i = 0; i < widget.tripData.segments.length; i++)
                          if(widget.tripData.segments[i].status == 'issued')
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ЖД билет №${i}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Root",
                                        fontSize: 16,
                                        color: Color(0xff1B344F),
                                      ),
                                    ),
                                    Text(
                                      //'${widget.tripData.segments[index].train} тг',
                                      widget.tripData.segments[i].ticket != null ? '${widget.tripData.segments[i].ticket.sum} тг' : '* тг',
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
                              ],
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
              ),
            if(!widget.tripData.applicationStatus.containsKey('yellow') && !widget.tripData.applicationStatus.containsKey('green') && !widget.tripData.applicationStatus.containsKey('all') && !widget.tripData.applicationStatus.containsKey('grey'))
              Container(
                width: w,
                margin: EdgeInsets.only(top: 12),
                alignment: Alignment.center,
                child: Text(
                  'Поездка отменена!',
                  style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 17,
                      color: Color(0xff1B344F),
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if(widget.tripData.applicationStatus.containsKey('green') && !widget.tripData.applicationStatus.containsKey('yellow'))
              Container(
                width: w,
                margin: EdgeInsets.only(top: 12),
                alignment: Alignment.center,
                child: Text(
                  'Поездка оформлена не полностью',
                  style: TextStyle(
                    fontFamily: "Root",
                    fontSize: 17,
                    color: Color(0xff1B344F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if(widget.tripData.applicationStatus.containsKey('green') && widget.tripData.applicationStatus.containsKey('yellow'))
              Container(
                width: w,
                margin: EdgeInsets.only(top: 12,),
                alignment: Alignment.center,
                child: Text(
                  'Поездка оформлена не полностью',
                  style: TextStyle(
                    fontFamily: "Root",
                    fontSize: 17,
                    color: Color(0xff1B344F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if(!widget.tripData.applicationStatus.containsKey('green') && widget.tripData.applicationStatus.containsKey('yellow'))
              Container(
                width: w,
                margin: EdgeInsets.only(top: 12),
                alignment: Alignment.center,
                child: Text(
                  'Поездка не оформлена',
                  style: TextStyle(
                    fontFamily: "Root",
                    fontSize: 17,
                    color: Color(0xff1B344F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if(!widget.tripData.applicationStatus.containsKey('green') && !widget.tripData.applicationStatus.containsKey('yellow') && !(!widget.tripData.applicationStatus.containsKey('yellow') && !widget.tripData.applicationStatus.containsKey('green') && !widget.tripData.applicationStatus.containsKey('all') && !widget.tripData.applicationStatus.containsKey('grey')))
              Container(
                width: w,
                margin: EdgeInsets.only(top: 12),
                alignment: Alignment.center,
                child: Text(
                  'Поездка не оформлена',
                  style: TextStyle(
                    fontFamily: "Root",
                    fontSize: 17,
                    color: Color(0xff1B344F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),


            for(int i = 0; i < widget.tripData.segments.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if(widget.tripData.segments[i].status == 'issued')
                    Container(
                      width: w,
                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.only(top: 10, bottom: 8),
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
                            offset: Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              child: SvgPicture.asset("assets/svg/download.svg", color: Colors.white,),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2, right: 8),
                              child: VerticalDivider(
                                indent: 0.0,
                                endIndent: 0.0,
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.tripData.segments[i].train.arrStationName[0].toUpperCase()}${widget.tripData.segments[i].train.arrStationName.toLowerCase().substring(1)} - ${widget.tripData.segments[i].depStationName[0].toUpperCase()}${widget.tripData.segments[i].depStationName.toLowerCase().substring(1)} ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'скачать билет',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if(widget.tripData.segments[i].status == 'returned')
                    Container(
                      width: w,
                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.only(top: 10, bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffF5C7C7), width: 1)
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              child: SvgPicture.asset("assets/svg/Returned.svg", color: Color(0xffFF4242),),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2, right: 8),
                              child: VerticalDivider(
                                indent: 0.0,
                                endIndent: 0.0,
                                width: 1.5,
                                color: Color(0xff748595).withOpacity(0.5),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.tripData.segments[i].train.arrStationName[0].toUpperCase()}${widget.tripData.segments[i].train.arrStationName.toLowerCase().substring(1)} - ${widget.tripData.segments[i].depStationName[0].toUpperCase()}${widget.tripData.segments[i].depStationName.toLowerCase().substring(1)} ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffFF4242),
                                      ),
                                    ),
                                    Text(
                                      widget.tripData.segments[i].closedReason != null ? widget.tripData.segments[i].closedReason : '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff748595).withOpacity(0.5),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if(widget.tripData.segments[i].status == 'canceled')
                    Container(
                      width: w,
                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.only(top: 10, bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffEBEBEB), width: 1)
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              child: SvgPicture.asset("assets/svg/Returned.svg", color: Color(0xffDADDE0),),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2, right: 8),
                              child: VerticalDivider(
                                indent: 0.0,
                                endIndent: 0.0,
                                width: 1.5,
                                color: Color(0xff748595).withOpacity(0.5),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.tripData.segments[i].train.arrStationName[0].toUpperCase()}${widget.tripData.segments[i].train.arrStationName.toLowerCase().substring(1)} - ${widget.tripData.segments[i].depStationName[0].toUpperCase()}${widget.tripData.segments[i].depStationName.toLowerCase().substring(1)} ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff748595).withOpacity(0.5),
                                      ),
                                    ),
                                    Text(
                                      widget.tripData.segments[i].closedReason != null ? widget.tripData.segments[i].closedReason : '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff748595).withOpacity(0.5),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if(widget.tripData.segments[i].status == 'opened' && (widget.tripData.segments[i].activeProcess == null || widget.tripData.segments[i].activeProcess == "booking"))
                    Container(
                        width: w,
                        margin: EdgeInsets.only(top: 12),
                        padding: EdgeInsets.only(top: 10, bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xffEBEBEB), width: 1)
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                child: SvgPicture.asset("assets/svg/download.svg", color: Color(0xff748595),),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 2, right: 8),
                                child: VerticalDivider(
                                  indent: 0.0,
                                  endIndent: 0.0,
                                  width: 1.5,
                                  color: Color(0xff748595).withOpacity(0.5),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${widget.tripData.segments[i].train.arrStationName[0].toUpperCase()}${widget.tripData.segments[i].train.arrStationName.toLowerCase().substring(1)} - ${widget.tripData.segments[i].depStationName[0].toUpperCase()}${widget.tripData.segments[i].depStationName.toLowerCase().substring(1)} ',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff748595).withOpacity(0.8),
                                        ),
                                      ),
                                      Text(
                                        'билет отменен',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff748595).withOpacity(0.5),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  if(widget.tripData.segments[i].status == 'opened' && widget.tripData.segments[i].activeProcess == 'watching')
                    Container(
                      width: w,
                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.only(top: 10, bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffEBEBEB), width: 1)
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              child: SvgPicture.asset("assets/svg/clock.svg", color: Color(0xffEA9F3F),),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2, right: 8),
                              child: VerticalDivider(
                                indent: 0.0,
                                endIndent: 0.0,
                                width: 1.5,
                                color: Color(0xff748595).withOpacity(0.5),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.tripData.segments[i].train.arrStationName[0].toUpperCase()}${widget.tripData.segments[i].train.arrStationName.toLowerCase().substring(1)} - ${widget.tripData.segments[i].depStationName[0].toUpperCase()}${widget.tripData.segments[i].depStationName.toLowerCase().substring(1)} ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffEA9F3F),
                                      ),
                                    ),
                                    Text(
                                      widget.tripData.segments[i].watcherTimeLimit != null ? 'билет на листе ожидания: до ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments[i].watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments[i].watcherTimeLimit))}' : 'билет на листе ожидания: до *',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff748595).withOpacity(0.5),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                ],
              )



            /*Container(
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
            ) */
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'dart:ui';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rotation_app/config/app+theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
import 'package:rotation_app/ui/pdf_viewer.dart';

class SingleCustomDetailsTripWidget extends StatelessWidget {
  final Application tripData;

  SingleCustomDetailsTripWidget({Key key, this.tripData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 56;
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
                            tripData.shift == 'night'
                                ? Container(
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
                                  )
                                : Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: SvgPicture.asset(
                                      'assets/svg/Moon.svg',
                                      width: 24,
                                      height: 24,
                                      color: AppTheme.nearlyWhite,
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
                                color: tripData.segments.first.activeProcess == "watching"
                                    ? Color(0xffEA9F3F)
                                    : Color(0xffC5CAD1),
                              ),
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
                  tripData.endStation != null
                      ? "в ${tripData.endStation[0].toUpperCase()}${tripData.endStation.toLowerCase().substring(1)}"
                      : "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                            ? Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    tripData.segments[index].icon,
                                    colorBlendMode: BlendMode.color,
                                    color: Colors.grey,
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
                                color: Color(0xff1B344F).withOpacity(0.5),
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
                                  color: Color(0xff1B344F).withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              new TextSpan(
                                text:
                                    ' ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments[index].train.depDateTime))} - ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments[index].train.arrDateTime))}',
                                style: new TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F).withOpacity(0.5),
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
          tripData.segments.first.activeProcess == "watching"
              ? Column(
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
                            width: w * 0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Поездка находится в листе ожидания.',
                                  style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff748595).withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  'Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(tripData.segments.first.watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments.first.watcherTimeLimit))}',
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
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Container(
                      width: w * 0.9,
                      //margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Билеты еще не оформлены.',
                        style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff748595).withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
          /*if (tripData.overTime != 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Divider(),
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
            )*/
        ],
      ),
    );
  }
}

class WithDetailsTripSheet extends StatefulWidget {
  final Application tripData;

  const WithDetailsTripSheet({Key key, this.tripData}) : super(key: key);

  @override
  _WithDetailsTripSheetState createState() => _WithDetailsTripSheetState();
}

class _WithDetailsTripSheetState extends State<WithDetailsTripSheet> {

  Dio dio = Dio();

  Future<bool> download2(Dio dio, String url, String savePath) async {
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
      ).whenComplete(() {
        return true;
      });
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
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
      if (parts[0].padLeft(2, '0') == "00")
        return '${parts[1].padLeft(2, '0')} мин';
      if (parts[0].padLeft(2, '0') != "00")
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
            InkWell(
              onTap: ()async{
                Directory documents = await getApplicationDocumentsDirectory();
                final status = await Permission.storage.request();
                if (status.isGranted) {
                  var tempDir = await getTemporaryDirectory();
                  String fullPath = tempDir.path + "/test44.pdf";
                  print('full path: ${fullPath}');

                  download2(dio, "https://tmp.ptravels.kz/download-print/32460/issue", fullPath).then((value) {
                    if(value){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(
                            path: '/data/user/0/kz.iitu.rotation_app/cache/test44.pdf',
                            title:
                            "Билет",
                          ),
                        ),
                      );
                    }else{
                      print('error');
                    }
                  });
                }
              },
              child: Container(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: w * 0.45,
                              child: Text(
                                "В ${widget.tripData.endStation[0].toUpperCase()}${widget.tripData.endStation.toLowerCase().substring(1)}. " +
                                    durationToString().toString() +
                                    " в пути",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff748595).withOpacity(0.7)),
                              ),
                            ),
                            widget.tripData.shift == 'night'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/Moon.svg",
                                      ),
                                      Container(
                                        width: w * 0.3,
                                        child: Text(
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
                        width: w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                widget.tripData.productKey == "rail"
                                    ? SvgPicture.asset(
                                        "assets/svg/Train.svg",
                                        color: widget.tripData.segments.first.activeProcess != null ? Color(0xffFFBE6B) : Color(0xff1BBC2CA),
                                        width: 24,
                                        height: 24,
                                      )
                                    : SvgPicture.asset(
                                        "assets/svg/Plane.svg",
                                        color: widget.tripData.segments.first.activeProcess != null ? Color(0xffFFBE6B) :Color(0xff1BBC2CA),
                                        width: 24,
                                        height: 24,
                                      ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 3),
                                  width: 2,
                                  constraints: BoxConstraints(
                                    minHeight: 140.0,
                                    maxHeight: 240.0,
                                  ),
                                  //height: 240,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: widget.tripData.segments.first.activeProcess != null ? Color(0xffFFBE6B) :Color(0xff1BBC2CA),
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
                                      color: widget.tripData.segments.first.activeProcess != null ? Color(0xffFFBE6B) :Color(0xff1BBC2CA),
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
                                        widget.tripData.segments[index].icon != null &&
                                        widget.tripData.segments[index].icon.isNotEmpty
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
                                                'КТЖ*',
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
                                                    color: Color(0xff748595)
                                                        .withOpacity(0.7)),
                                              ),
                                            ),
                                            widget.tripData.segments.first.activeProcess == null ?
                                            Container(
                                              width: w * 0.55,
                                              child: Text(
                                                'билеты не куплены',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Root",
                                                  fontSize: 14,
                                                  color: Color(0xff1B344F)
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ) : Container(
                                              width: w * 0.55,
                                              child: Text(
                                                'билеты в листе ожидания',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Root",
                                                  fontSize: 14,
                                                  color: Color(0xffFFBE6B),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
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
                                                    color: Color(0xff748595)
                                                        .withOpacity(0.7)),
                                              ),
                                            ),
                                            widget.tripData.segments.first.activeProcess == null ?
                                            Container(
                                              width: w * 0.55,
                                              child: Text(
                                                'билеты не куплены',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Root",
                                                  fontSize: 14,
                                                  color: Color(0xff1B344F)
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ) : Container(
                                              width: w * 0.55,
                                              child: Text(
                                                'билеты в листе ожидания',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Root",
                                                  fontSize: 14,
                                                  color: Color(0xffEA9F3F),
                                                ),
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
                      /*if (widget.tripData.segments.length > 1 &&
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
                        ),*/
                    ],
                  );
                }),
            widget.tripData.segments.first.activeProcess != null ?
            Column(
              children: [
                Divider(
                  thickness: 1,
                  height: 0,
                  color: Color(0xffEBEBEB),
                ),
                Container(
                  width: w,
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time_rounded, color: Color(0xff1B344F), size: 20,),
                          SizedBox(width: 5,),
                          Text(
                            'Билеты еще не куплены!',
                            style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff1B344F),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Root"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.tripData.segments.first.watcherTimeLimit != null ?
                        "Поездка находится в листе ожидания.  Тайм-лимит оформления: ${DateFormat.MMMd('ru').format(DateTime.parse(widget.tripData.segments.first.watcherTimeLimit))} ${DateFormat.Hm('ru').format(DateTime.parse(widget.tripData.segments.first.watcherTimeLimit))}" : "Поездка находится в листе ожидания.  Тайм-лимит оформления: *",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff1B344F).withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Root"),
                      )
                    ],
                  ),
                ),
              ],
            )
             : Column(
              children: [
                Divider(
                  thickness: 1,
                  height: 0,
                  color: Color(0xffEBEBEB),
                ),
                Container(
                  width: w,
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Билеты еще не куплены!',
                            style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff1B344F),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Root"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Когда координатор закупит и оформит билеты на данную поездку, отобразится вся необходимая информация.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff1B344F).withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Root"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

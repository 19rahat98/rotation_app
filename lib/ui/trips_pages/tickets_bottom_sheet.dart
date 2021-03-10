import 'dart:ui';
import 'dart:isolate';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:rotation_app/logic_block/models/application_model.dart';

class TicketsBottomSheet extends StatefulWidget {
  final Application tripData;

  const TicketsBottomSheet({Key key, this.tripData}) : super(key: key);

  @override
  _TicketsBottomSheetState createState() => _TicketsBottomSheetState();
}

class _TicketsBottomSheetState extends State<TicketsBottomSheet> {
  int _totalPrice = 0;

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
    print(widget.tripData.id);
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
                          Container(
                            width: w * 0.45,
                            child: Text(
                              "В ${widget.tripData.endStation[0].toUpperCase()}${widget.tripData.endStation.toLowerCase().substring(1)}. " + durationToString().toString() + " в пути",
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
                                  height: 180,
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
                                                    color: Color(0xff748595)),
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
                                                    color: Color(0xff748595)),
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
                  if(widget.tripData.segments.first.ticket != null && widget.tripData.segments.first.ticket.ticketUrl != null){
                    final status = await Permission.storage.request();

                    if (status.isGranted) {
                      final externalDir = await getExternalStorageDirectory();

                      final id = await FlutterDownloader.enqueue(
                        url: widget.tripData.segments.first.ticket.ticketUrl,
                        savedDir: externalDir.path,
                        fileName: "Билет ${widget.tripData.segments[0].train.depStation} - ${widget.tripData.segments[0].train.arrStation} ${DateFormat.MMMEd('ru').format(DateTime.parse(widget.tripData.segments[0].train.depDateTime),
                        ).toString().replaceAll('.', ',')}",
                        showNotification: true,
                        openFileFromNotification: true,
                      );
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
      ),
    );
  }
}

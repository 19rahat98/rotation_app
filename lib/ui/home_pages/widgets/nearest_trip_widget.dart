import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
import 'package:rotation_app/ui/trips_pages/active_widget.dart';
import 'package:rotation_app/ui/trips_pages/inactive_trip_widget.dart';
import 'package:rotation_app/ui/trips_pages/tickets_bottom_sheet.dart';

class NearestTripWidget extends StatefulWidget {
  final List<Application> tripsList;

  const NearestTripWidget({Key key, this.tripsList}) : super(key: key);

  @override
  _NearestTripWidgetState createState() => _NearestTripWidgetState();
}

class _NearestTripWidgetState extends State<NearestTripWidget> {
  Application nearestTrip;

  void _onOpenMore(BuildContext context, Application nearestTrip) {
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
            maxHeight: h * 0.9,
          ),
          //height: h * 0.90,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: TicketsBottomSheet(tripData: nearestTrip),
        );
      },
    );
  }

  @override
  void initState() {
    if(widget.tripsList != null && widget.tripsList.isNotEmpty) nearestTrip = getAllTrips();
    super.initState();
  }

  Application getAllTrips() {
    for (var x in widget.tripsList) {
      if (DateTime.now().isBefore(DateTime.parse(x.date))) {
        return x;
      }
    }
    return widget.tripsList.last;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 56;
    return nearestTrip.segments.isNotEmpty && nearestTrip != null ? InkWell(
      onTap: (){
        _onOpenMore(context, nearestTrip);
      },
      child: Container(
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
                                nearestTrip.direction == "to-work"
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
                                    .format(DateTime.parse(nearestTrip.date))
                                    .toString()
                                    .replaceAll('.', ''),
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 19,
                                    color: nearestTrip.overTime > 0 && nearestTrip.overTime != null ? AppTheme.dangerousColor : Color(0xff0C2B4C),
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
                              nearestTrip.shift == 'day' ?
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
                              nearestTrip.overTime > 0 && nearestTrip.overTime != null ? Container(
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
                                      'РВД +${nearestTrip.overTime}',
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
                              nearestTrip.segments.isEmpty ?
                              SvgPicture.asset(
                                  'assets/svg/Ticket.svg',
                                  width: 24,
                                  height: 24,
                                  color: AppTheme.nearlyWhite
                              ) : nearestTrip.segments.length > 1 && nearestTrip.productKey == 'rail'
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
                                  : nearestTrip.productKey == 'rail' ?  Container(
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
                    "В ${nearestTrip.endStation[0].toUpperCase()}${nearestTrip.endStation.toLowerCase().substring(1)}",
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
              itemCount: nearestTrip.segments.length,
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
                          nearestTrip.segments[index].icon != null && nearestTrip.segments[index].icon.isNotEmpty ?
                          Image(image: NetworkImage(nearestTrip.segments[index].icon), width: 31, height: 22,):
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
                              "${nearestTrip.segments[index].train.depStationName[0].toUpperCase()}${nearestTrip.segments[index].train.depStationName.toLowerCase().substring(1)} - ${nearestTrip.segments[index].train.arrStationName[0].toUpperCase()}${nearestTrip.segments[index].train.arrStationName.toLowerCase().substring(1)}",
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 14,
                                  color: Color(0xff1B344F),
                                  fontWeight: FontWeight.w400),
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
                                    DateTime.parse(nearestTrip
                                        .segments[index].train.depDateTime),
                                  ).toString().replaceAll('.', ','),
                                  style: TextStyle(fontFamily: "Root",
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                new TextSpan(
                                  text:
                                  ' ${DateFormat.Hm('ru').format(DateTime.parse(nearestTrip.segments[index].train.depDateTime))} - ${DateFormat.Hm('ru').format(DateTime.parse(nearestTrip.segments[index].train.arrDateTime))}',
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
            if(nearestTrip.overTime != 0 && nearestTrip.overTime != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Container(
                    width: 250,
                    child: Text(
                      'У вас овертайм +${nearestTrip.overTime} дней,  билеты на новую дату куплены',
                      style: TextStyle(fontFamily: "Root",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff748595).withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),) : InkWell(
      onTap: (){
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => InactiveTripActionSheet(tripData: nearestTrip));
      },
      child: Container(
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
                                nearestTrip.direction == "to-work"
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
                                    .format(DateTime.parse(nearestTrip.date))
                                    .toString()
                                    .replaceAll('.', ''),
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 19,
                                    color: nearestTrip.overTime > 0 && nearestTrip.overTime != null ? AppTheme.dangerousColor : Color(0xff0C2B4C),
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
                              nearestTrip.shift == 'day' ?
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
                              nearestTrip.overTime > 0 && nearestTrip.overTime != null ? Container(
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
                                      'РВД +${nearestTrip.overTime}',
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
                              nearestTrip.segments.isEmpty ?
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
                    "В ${nearestTrip.endStation[0].toUpperCase()}${nearestTrip.endStation.toLowerCase().substring(1)}",
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
      ),
    );
  }
}

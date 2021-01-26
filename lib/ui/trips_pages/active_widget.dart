import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/logic_block/models/application.dart';

class ActiveWidget extends StatelessWidget {
  final Application tripData;

  const ActiveWidget({Key key, this.tripData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(boxShadow: [
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
      ], borderRadius: BorderRadius.circular(6), color: Colors.white),
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
                    Row(
                      children: [
                        Text(
                          tripData.direction == "to-work"
                              ? 'На вахту, '
                              : 'Домой, ',
                          style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff0C2B4C),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat.MMMd('ru')
                              .format(DateTime.parse(tripData.date)).toString().replaceAll('.', ''),
                          style: TextStyle(
                              fontSize: 19,
                              color: Color(0xffFF4242),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        tripData.shift != 'day' ?
                        Container(
                          width: 32,
                          height: 32,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppTheme.mainDarkColor,),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svg/moon.svg",
                              color: Colors.white,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ) : Container(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffFF4242)),
                          child: Row(
                            children: [
                              Text(
                                'РВД +5',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        tripData.segments.length > 1
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
                            : Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xff00B688)),
                          child: Center(
                            child: Icon(
                              Icons.train,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'В ' + tripData.endStation,
                  style: TextStyle(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                        tripData.startStation +
                            ' — ' +
                            tripData.endStation,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff1B344F),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: w * 0.40,
                    margin: EdgeInsets.only(top: 16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: new TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                            text: DateFormat.MMMd('ru').format(
                              DateTime.parse(tripData
                                  .segments.last.train.arrDateTime),
                            ).toString().replaceAll('.', ','),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff1B344F),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          new TextSpan(
                            text:
                            ' ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments.last.train.arrDateTime))} - ${DateFormat.Hm('ru').format(DateTime.parse(tripData.segments.last.train.depDateTime))}',
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
          ),
          Divider(),
          Container(
            width: 250,
            child: Text(
              'У вас овертайм +5 дней,  билеты на новую дату куплены',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff748595).withOpacity(0.6),
              ),
            ),
          )
        ],
      ),
    );
  }
}

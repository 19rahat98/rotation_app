import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rotation_app/logic_block/models/application.dart';

class InactiveTripWidget extends StatelessWidget {
  final Application tripData;

  const InactiveTripWidget({Key key, this.tripData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.white),
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
                          tripData.direction == "to-work" ? 'На вахту, ' : 'Домой, ',
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
                              color: Color(0xff0C2B4C),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
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
            child: Text(
              'Билеты еще не оформлены',
              style: TextStyle(
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
                            fontSize: 22,
                            color: Color(0xff0C2B4C),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.MMMd('ru')
                            .format(DateTime.parse(tripData.date)).toString().replaceAll('.', ''),
                        style: TextStyle(
                            fontSize: 22,
                            color: Color(0xff0C2B4C),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                tripData.shift == 'night' ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /*Text(
                      '8 ч 45 мин в пути',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff748595).withOpacity(0.7)),
                    ),*/
                    SvgPicture.asset(
                      "assets/svg/moon.svg",
                    ),
                    Text(
                      'Ночная смена',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff748595).withOpacity(0.7)),
                    ),
                  ],
                ) : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /*Text(
                      '8 ч 45 мин в пути',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff748595).withOpacity(0.7)),
                    ),*/
                    Icon(Icons.hourglass_empty),
                    Text(
                      'Дневная смена',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff748595).withOpacity(0.7)),
                    ),
                  ],
                ),
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
                      fontSize: 15,
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

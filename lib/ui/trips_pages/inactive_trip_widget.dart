import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InactiveTripWidget extends StatelessWidget {
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
                    child: Text(
                      'На вахту, 16 авг',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '8 ч 45 мин в пути',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff748595).withOpacity(0.7)),
                      ),
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
        ));
  }
}

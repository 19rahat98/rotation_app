import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallSupportWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      'Если у вас возникли сложности с приложением либо с поездкой, вы поможете позвонить нам в удобное для вас время:',
                      style: TextStyle(fontFamily: "Root",
                          fontSize: 15,
                          color: Color(0xff1B3652).withOpacity(0.5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 5),
                    child: Text(
                      '+7(701)705-16-16',
                      style: TextStyle(fontFamily: "Root",
                        fontSize: 15,
                        color: Color(0xff1B3652).withOpacity(0.5),
                      ),
                    ),
                  ),
                  /*Text(
                    '+7 727 355 37 37',
                    style: TextStyle(fontFamily: "Root",
                      fontSize: 15,
                      color: Color(0xff1B3652).withOpacity(0.5),
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 5),
                    child: Text(
                      'Также, мы рекомендуем обратится в круглосуточный онлайн чат.',
                      style: TextStyle(fontFamily: "Root",
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
          CupertinoActionSheetAction(
            child: Text(
              'Позвонить в поддержку',
              style: TextStyle(fontFamily: "Root",
                  fontSize: 17,
                  color: Color(0xff1262CB),
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              launch("tel://+7(701)7051616");
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Отмена',
            style: TextStyle(fontFamily: "Root",
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

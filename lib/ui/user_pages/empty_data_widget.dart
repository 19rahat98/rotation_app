import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'Будьте внимательны, при заполнении.  Данные должны соответсвовать документу.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff1B3652).withOpacity(0.5),
                  ),
                ),
              ),
            ),
            onPressed: () {
              print('pressed');
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Заполнить данные',
              style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff1262CB),
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Отмена',
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

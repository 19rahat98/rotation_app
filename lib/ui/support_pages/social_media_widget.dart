import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                "Наши онлайн-консультанты работают круглосуточно. Пишите по любым вопросам.",
                style: TextStyle(fontFamily: "Root",
                  fontSize: 15,
                  color: Color(0xff1B3652).withOpacity(0.5),
                ),
              ),
            ),
            onPressed: () {},
          ),
          CupertinoActionSheetAction(
            child: Container(
              margin: EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/icon-send-wa.svg',
                    height: 40,
                    width: 40,
                    excludeFromSemantics: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Написать в WhatsApp',
                          style: TextStyle(fontFamily: "Root",
                              fontSize: 18,
                              color: Color(0xff2D4461),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'оператор онлайн',
                          style: TextStyle(fontFamily: "Root",
                              fontSize: 15,
                              color: Color(0xff2D4461).withOpacity(0.5),
                              fontWeight: FontWeight.w400),
                        )
                      ],
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
            child: Container(
              margin: EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/telegram.svg',
                    height: 40,
                    width: 40,
                    excludeFromSemantics: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Написать в Telegram',
                          style: TextStyle(fontFamily: "Root",
                              fontSize: 18,
                              color: Color(0xff2D4461),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'оператор онлайн',
                          style: TextStyle(fontFamily: "Root",
                              fontSize: 15,
                              color: Color(0xff2D4461).withOpacity(0.5),
                              fontWeight: FontWeight.w400),
                        )
                      ],
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

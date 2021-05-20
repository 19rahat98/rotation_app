import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
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
                style: TextStyle(
                  fontFamily: "Root",
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
                  Image.asset(
                    'assets/svg/icon-send-wa.png',
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
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 18,
                              color: Color(0xff2D4461),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'оператор онлайн',
                          style: TextStyle(
                              fontFamily: "Root",
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
              if (Platform.isAndroid) {
                print('pressed');
                launch("https://wa.me/+77017051616/?text=");
                //return "https://wa.me/+77017051616/?text="; // new line
              } else {
                launch("https://api.whatsapp.com/send?phone=+77017051616=");
              }
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
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 18,
                              color: Color(0xff2D4461),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'оператор онлайн',
                          style: TextStyle(
                              fontFamily: "Root",
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
            style: TextStyle(
                fontFamily: "Root",
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

class NotificationBottomSheet extends StatelessWidget {
  final String contentAvailable;
  final String isImportant;
  final String type;
  final int segmentId;
  final String orderId;
  final String priority;
  final String content;
  final String title;
  final Function() onPressed;

  const NotificationBottomSheet({Key key, this.contentAvailable, this.isImportant, this.type, this.segmentId, this.orderId, this.priority, this.content, this.title, this.onPressed,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Padding(
              padding: EdgeInsets.only(bottom: 12, left: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Image.asset(
                          "assets/images/notification.png",
                          width: 28,
                          height: 28,
                        ),
                      ),
                      isImportant != null && isImportant == "true" ?
                      Container(
                        width: w * 0.5,
                        child: Text(
                          "Важное уведомление",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1B3652).withOpacity(0.5),
                          ),
                        ),
                      ) :
                      Container(
                        width: w * 0.5,
                        child: Text(
                          "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1B3652).withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  title != null && title.isNotEmpty ?
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1B344F),
                      ),
                    ),
                  ) :
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      "Наши онлайн-консультанты работают круглосуточно. Пишите по любым вопросам.*",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1B344F),
                      ),
                    ),
                  ),
                  content != null && content.isNotEmpty ?
                  Container(
                    margin: EdgeInsets.only(top: 12, right: 12),
                    child: Text(
                      content,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1B344F).withOpacity(0.5),
                      ),
                    ),
                  ) :
                  Container(
                    margin: EdgeInsets.only(top: 12, right: 12),
                    child: Text(
                      'Content*',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1B344F).withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ),
          if(isImportant != null && isImportant == "true")
          CupertinoActionSheetAction(
            child: Container(
              child: Center(
                child: Text(
                  'Узнать подробнее',
                  style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 17,
                      color: Color(0xff1262CB),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onPressed: () {
              onPressed();
              print('pressed');
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Спасибо, я ознакомлен',
            style: TextStyle(
                fontFamily: "Root",
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

import 'package:flutter/material.dart';

class NotificationsListScreen extends StatefulWidget {
  final String itemId;
  final String matchteam;
  final String score;

  const NotificationsListScreen({Key key, this.itemId, this.matchteam, this.score}) : super(key: key);
  @override
  _NotificationsListScreenState createState() =>
      _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {

  @override
  void initState() {
    print(widget.itemId);
    print(widget.matchteam);
    print(widget.score);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF3F6FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          'Уведомления',
          style: TextStyle(fontFamily: "Root",
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2D4461),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.score != null ? widget.score : 'score'),
              Text(widget.matchteam != null ? widget.matchteam : 'matchteam'),
              Text(widget.itemId != null ? widget.itemId : 'itemId'),
              Container(
                child: Text(
                  'Уведомления',
                  style: TextStyle(fontFamily: "Root",
                    fontSize: 24,
                    color: Color(0xff1B344F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: w,
                margin: EdgeInsets.only(top: 16),
                padding:
                    EdgeInsets.only(top: 12, left: 9, right: 12, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffD0DAE7)),
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0xffF5F8FC),
                      Color(0xffE3EDFF),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: Color(0xff4A8ADF),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff5EA3FF).withOpacity(0.4),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: w * 0.7,
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Билеты куплены',
                                style: TextStyle(fontFamily: "Root",
                                    fontSize: 18,
                                    color: Color(0xff1262CB),
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'На вахту, в Актогай 5 авг, вторник',
                                  style: TextStyle(fontFamily: "Root",
                                      fontSize: 14,
                                      color: Color(0xff385780).withOpacity(0.7),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                'только что',
                                style: TextStyle(fontFamily: "Root",
                                    fontSize: 11,
                                    color: Color(0xff1B344F).withOpacity(0.5),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.check_circle_outline,
                      size: 22,
                      color: Color(0xff2B5198),
                    ),
                  ],
                ),
              ),
              Container(
                width: w,
                margin: EdgeInsets.only(top: 16),
                padding:
                EdgeInsets.only(top: 12, left: 9, right: 12, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffD0DAE7)),
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0xffF5F8FC),
                      Color(0xffE3EDFF),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: Color(0xff4A8ADF),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff5EA3FF).withOpacity(0.4),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset:
                                Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: w * 0.7,
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Назначена вахта',
                                style: TextStyle(fontFamily: "Root",
                                    fontSize: 18,
                                    color: Color(0xff1262CB),
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'Ваш график смещен, нажмите, чтобы просмотреть подробнее',
                                  style: TextStyle(fontFamily: "Root",
                                      fontSize: 14,
                                      color: Color(0xff385780).withOpacity(0.7),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                'вчера, 10:30',
                                style: TextStyle(fontFamily: "Root",
                                    fontSize: 11,
                                    color: Color(0xff1B344F).withOpacity(0.5),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.shopping_bag,
                      size: 22,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                width: w,
                margin: EdgeInsets.only(top: 16),
                padding:
                EdgeInsets.only(top: 12, left: 9, right: 12, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffD0DAE7)),
                  color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: Color(0xff4A8ADF),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff5EA3FF).withOpacity(0.4),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset:
                                Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: w * 0.7,
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Свежие новости COVID-19',
                                style: TextStyle(fontFamily: "Root",
                                    fontSize: 18,
                                    color: Color(0xff1262CB),
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'Нажмите, чтобы читать статью ',
                                  style: TextStyle(fontFamily: "Root",
                                      fontSize: 14,
                                      color: Color(0xff385780).withOpacity(0.7),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                'вчера, 10:30',
                                style: TextStyle(fontFamily: "Root",
                                    fontSize: 11,
                                    color: Color(0xff1B344F).withOpacity(0.5),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.library_books_sharp,
                      size: 22,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                width: w,
                margin: EdgeInsets.only(top: 16),
                padding:
                EdgeInsets.only(top: 12, left: 9, right: 12, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffD0DAE7)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: Color(0xff4A8ADF),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff5EA3FF).withOpacity(0.4),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset:
                                Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: w * 0.7,
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Свежие новости COVID-19',
                                style: TextStyle(fontFamily: "Root",
                                    fontSize: 18,
                                    color: Color(0xff1262CB),
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'Нажмите, чтобы читать статью ',
                                  style: TextStyle(fontFamily: "Root",
                                      fontSize: 14,
                                      color: Color(0xff385780).withOpacity(0.7),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                'вчера, 10:30',
                                style: TextStyle(fontFamily: "Root",
                                    fontSize: 11,
                                    color: Color(0xff1B344F).withOpacity(0.5),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.library_books_sharp,
                      size: 22,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

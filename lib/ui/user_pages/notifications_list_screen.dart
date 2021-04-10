import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
import 'package:rotation_app/logic_block/models/articles_model.dart';
import 'package:rotation_app/logic_block/providers/articles_provider.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/ui/nav_bar/app.dart';
import 'package:rotation_app/ui/support_pages/more_article_info_widget.dart';
import 'package:rotation_app/ui/trips_pages/custom_trip_widget.dart';

import 'package:rotation_app/ui/widgets/emptyPage.dart';
import 'package:rotation_app/ui/support_pages/social_media_widget.dart';
import 'package:rotation_app/logic_block/models/notification_model.dart';
import 'package:rotation_app/logic_block/providers/notification_provider.dart';

class NotificationsListScreen extends StatefulWidget {
  final String contentAvailable;
  final String isImportant;
  final String type;
  final int segmentId;
  final String orderId;
  final String priority;
  final String content;
  final String title;
  final bool itsAction;

  const NotificationsListScreen(
      {Key key,
      this.itsAction = false,
      this.contentAvailable,
      this.isImportant,
      this.type,
      this.segmentId,
      this.priority,
      this.content,
      this.title,
      this.orderId})
      : super(key: key);

  @override
  _NotificationsListScreenState createState() =>
      _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.itsAction) {
        return showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => NotificationBottomSheet(
                  contentAvailable: widget.contentAvailable,
                  isImportant: widget.isImportant,
                  type: widget.type,
                  orderId: widget.orderId,
                  segmentId: widget.segmentId,
                  content: widget.content,
                  title: widget.title,
                  priority: widget.priority,
                ));
      }
    });
    super.initState();
  }

  void _onOpenMore(BuildContext context, String id, String type) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    LoginProvider lp = Provider.of<LoginProvider>(context, listen: false);
    ArticlesProvider ap = Provider.of<ArticlesProvider>(context, listen: false);
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        if(type == "application" || type == "ticket" ){
          return FutureBuilder<Application>(
              future: lp.findApplicationById(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none)
                  return Container(
                    width: w,
                    constraints: new BoxConstraints(
                      maxHeight: h * 0.9,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(child: CircularProgressIndicator()),
                  );
                else if (snapshot.hasError){
                  Navigator.pop(context);
                  return Container();
                }
                else if(snapshot.data != null){
                  if(snapshot.data == null){
                    Navigator.pop(context);
                    print('findApplicationById');
                  }
                  return Container(
                    width: w,
                    constraints: new BoxConstraints(
                      maxHeight: h * 0.90,
                      minHeight: h * 0.80,
                    ),
                    //height: h * 0.90,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: CustomTripSheet(tripData: snapshot.data,),
                  );
                }
                else return Container(
                    width: w,
                    constraints: new BoxConstraints(
                      maxHeight: h * 0.9,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(child: CircularProgressIndicator()),
                  );
              }
          );
        }
        else if(type == 'article'){
          return FutureBuilder<MoreAboutArticle>(
              future: ap.aboutMoreArticle(articleId: id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none)
                  return Container(
                    width: w,
                    constraints: new BoxConstraints(
                      maxHeight: h * 0.9,
                      minHeight: h * 0.80,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(child: CircularProgressIndicator()),
                  );
                else if(snapshot.data != null){
                  return Container(
                    width: w,
                    constraints: new BoxConstraints(
                      maxHeight: h * 0.9,
                      minHeight: h * 0.80,
                    ),
                    //height: h * 0.90,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: MoreArticleWidget(
                      title: snapshot.data.title,
                      articleText: snapshot.data.content,
                      informationDate: snapshot.data.publishedOn,),
                  );
                }
                else if (snapshot.hasError){
                  Navigator.pop(context);
                  return Container();
                }
                else return Container(
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
                    child: Center(child: CircularProgressIndicator()),
                  );
              }
          );
        }
        else return Container();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF3F6FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }else{
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => App()),  ModalRoute.withName('/'),);
            }
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          'Уведомления',
          style: TextStyle(
              fontFamily: "Root",
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2D4461),
      ),
      body: FutureBuilder<List<NotificationData>>(
          future: notificationProvider.getNotificationsFromDB(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.hasError)
              return Center(
                  child: emptyPage(Icons.error_outline, 'Something is wrong'));
            else if (snapshot.data != null && snapshot.data.isNotEmpty) {
              return Container(
                margin: EdgeInsets.symmetric(
                  //vertical: 24,
                  horizontal: 16,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      Container(
                        child: Text(
                          'Уведомления',
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 24,
                            color: Color(0xff1B344F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: snapshot.data.map((NotificationData item) {
                          return Container(
                            width: w,
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.only(
                                top: 12, left: 16, right: 12, bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xffD0DAE7)),
                              color: Color(0xffFAFCFF),
                              /*gradient: LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Color(0xffF5F8FC),
                                    Color(0xffE3EDFF),
                                  ],
                                ),*/
                            ),
                            child: InkWell(
                              onTap: (){
                                if(item.data.body.type == "application" || item.data.body.type == "ticket" ){
                                  showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) => NotificationBottomSheet(onPressed:() { Navigator.pop(context); _onOpenMore(context, item.data.body.applicationId.toString(), item.data.body.type);}, contentAvailable: item.data.body.contentAvailable.toString(), isImportant: item.data.body.isImportant.toString(), type: item.data.body.type, title: item.data.body.title, content: item.data.body.content,));
                                  //_onOpenMore(context, item._applicationId);
                                }
                                else if(item.data.body.type == 'article'){
                                  showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) => NotificationBottomSheet(onPressed:() { Navigator.pop(context); _onOpenMore(context, item.data.body.id.toString(), item.data.body.type);}, contentAvailable: item.data.body.contentAvailable.toString(), isImportant: item.data.body.isImportant.toString(), type: item.data.body.type, title: item.data.body.title, content: item.data.body.content,));
                                }
                                else{
                                  showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) => NotificationBottomSheet(onPressed:() { Navigator.pop(context);}));
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: w * 0.7,
                                    margin: EdgeInsets.only(left: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.data.body.title,
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 18,
                                              color: Color(0xff385780),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 6),
                                          child: Text(
                                            item.data.body.content,
                                            style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff385780).withOpacity(0.7),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          item.createdAt,
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 11,
                                              color: Color(0xff1B344F)
                                                  .withOpacity(0.5),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if(item.data.body.type == 'application' || item.data.body.type == 'ticket')
                                    SvgPicture.asset(
                                      'assets/svg/icon-notify-success.svg',
                                      width: 19,
                                      height: 19,
                                      color: AppTheme.mainColor,
                                    ),
                                  if(item.data.body.type == 'doc_info')
                                    SvgPicture.asset(
                                      'assets/svg/News.svg',
                                      width: 19,
                                      height: 19,
                                      color: AppTheme.mainColor,
                                    ),
                                  if(item.data.body.type == 'message')
                                    SvgPicture.asset(
                                      'assets/svg/Zap.svg',
                                      width: 17,
                                      height: 19,
                                      color: Colors.white,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      /*Container(
                        width: w,
                        margin: EdgeInsets.only(top: 16),
                        padding: EdgeInsets.only(
                            top: 12, left: 9, right: 12, bottom: 8),
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
                                        offset: Offset(
                                            0, 0), // changes position of shadow
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
                                        style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 18,
                                            color: Color(0xff1262CB),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                          'На вахту, в Актогай 5 авг, вторник',
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff385780)
                                                  .withOpacity(0.7),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        'только что',
                                        style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 11,
                                            color: Color(0xff1B344F)
                                                .withOpacity(0.5),
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
                        padding: EdgeInsets.only(
                            top: 12, left: 9, right: 12, bottom: 8),
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
                                        offset: Offset(
                                            0, 0), // changes position of shadow
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
                                        style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 18,
                                            color: Color(0xff1262CB),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                          'Ваш график смещен, нажмите, чтобы просмотреть подробнее',
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff385780)
                                                  .withOpacity(0.7),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        'вчера, 10:30',
                                        style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 11,
                                            color: Color(0xff1B344F)
                                                .withOpacity(0.5),
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
                        padding: EdgeInsets.only(
                            top: 12, left: 9, right: 12, bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Color(0xffD0DAE7)),
                            color: Colors.white),
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
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: w * 0.7,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Свежие новости COVID-19',
                                        style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 18,
                                            color: Color(0xff1262CB),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                          'Нажмите, чтобы читать статью ',
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff385780)
                                                  .withOpacity(0.7),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        'вчера, 10:30',
                                        style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 11,
                                            color: Color(0xff1B344F)
                                                .withOpacity(0.5),
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
                        padding: EdgeInsets.only(
                            top: 12, left: 9, right: 12, bottom: 8),
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
                                        offset: Offset(
                                            0, 0), // changes position of shadow
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
                                        style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 18,
                                            color: Color(0xff1262CB),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                          'Нажмите, чтобы читать статью ',
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff385780)
                                                  .withOpacity(0.7),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        'вчера, 10:30',
                                        style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 11,
                                            color: Color(0xff1B344F)
                                                .withOpacity(0.5),
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
                      ),*/
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            }
            else if(snapshot.data != null && snapshot.data.isEmpty){
              return Container(
                margin: EdgeInsets.symmetric(
                  //vertical: 24,
                  horizontal: 16,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      Container(
                        child: Text(
                          'Уведомления',
                          style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 24,
                            color: Color(0xff1B344F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: w,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
                          child: Text(
                            'Нет результатов',
                            style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 17,
                              color: Color(0xff15304D),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

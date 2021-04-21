import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
import 'package:rotation_app/logic_block/models/articles_model.dart';
import 'package:rotation_app/logic_block/models/notification_model.dart';
import 'package:rotation_app/logic_block/providers/articles_provider.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/providers/notification_provider.dart';
import 'package:rotation_app/ui/support_pages/more_article_info_widget.dart';
import 'package:rotation_app/ui/support_pages/social_media_widget.dart';
import 'package:rotation_app/ui/trips_pages/custom_trip_widget.dart';
import 'package:rotation_app/ui/widgets/emptyPage.dart';

class PushNotificationListWidget extends StatefulWidget {
  @override
  _PushNotificationListWidgetState createState() => _PushNotificationListWidgetState();
}

class _PushNotificationListWidgetState extends State<PushNotificationListWidget> {


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
    double w = MediaQuery.of(context).size.width;
    ArticlesProvider ap = Provider.of<ArticlesProvider>(context, listen: false);
    NotificationProvider notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
    return Container(
      width: w,
      height: 110,
      padding: EdgeInsets.only(top: 8),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(width: 16),
          FutureBuilder<NotificationData>(
              future: notificationProvider.getFirstNotificationFromDB(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none)
                  return Container(
                    width: 200,
                    padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 10,
                        bottom: 5),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Color(0xffD0DAE7)),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                else if (snapshot.hasError){
                  return Container(
                    width: 200,
                    padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 10,
                        bottom: 5),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Color(0xffD0DAE7)),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                else if (snapshot.data != null) {
                  return Container(
                    width: 200,
                    padding: EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 5),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xffD0DAE7)),
                    ),
                    child: InkWell(
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              NotificationBottomSheet(
                            onPressed: () {
                              Navigator.pop(context);
                              _onOpenMore(
                                context,
                                snapshot.data.data.body.applicationId.toString(),
                                snapshot.data.data.body.type,
                              );
                            },
                            contentAvailable: snapshot.data.data.body.contentAvailable.toString(),
                            isImportant: snapshot.data.data.body.isImportant.toString(),
                            type: snapshot.data.data.body.type,
                            title: snapshot.data.data.body.title,
                            content: snapshot.data.data.body.content,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(
                                    snapshot.data.data.body.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: "Root",
                                        fontSize: 17,
                                        color: Color(0xff385780),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/svg/icon-notify-success.svg',
                                  width: 17,
                                  height: 17,
                                  color: AppTheme.mainColor,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 150,
                            child: Text(
                              snapshot.data.data.body.content,
                              maxLines: 2,
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 14,
                                  color: Color(0xff385780),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 150,
                            child: Text(
                              snapshot.data.createdAt,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 11,
                                  color: Color(0xff385780),
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else if (snapshot.data == null) {
                  return Container(
                    width: 200,
                    padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 10,
                        bottom: 5),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Color(0xffD0DAE7)),
                    ),
                    child: Center(
                      child: Icon(Icons.description, color: Color(0xff748595)),
                    )
                  );
                } else {
                  return Container(
                    width: 200,
                    padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 10,
                        bottom: 5),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Color(0xffD0DAE7)),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },),
          Container(
            width: 200,
            padding: EdgeInsets.only(
                left: 12, right: 12, top: 10),
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Color(0xffD0DAE7)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xffC81D5E),
                      Color(0xffFF4963),
                    ])),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'РВД +3 дня',
                        style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold),
                      ),
                      SvgPicture.asset(
                        'assets/svg/Zap.svg',
                        width: 17,
                        height: 19,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 150,
                  child: Text(
                    'Текущая вахта, до 8 авг, вт',
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 150,
                  child: Text(
                    '3 часа назад',
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 11,
                        color: Colors.white
                            .withOpacity(0.5),
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
          /*Container(
            width: 200,
            padding: EdgeInsets.only(
                left: 12, right: 12, top: 10),
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:
              Border.all(color: Color(0xffD0DAE7)),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Важная новость',
                        style: TextStyle(
                            fontFamily: "Root",
                            fontSize: 16,
                            color: Color(0xff385780),
                            fontWeight:
                            FontWeight.bold),
                      ),
                      SvgPicture.asset(
                        'assets/svg/News.svg',
                        width: 19,
                        height: 19,
                        color: AppTheme.mainColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 150,
                  child: Text(
                    'Домой, в Алматы на 8 авг, вторник',
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 14,
                        color: Color(0xff385780),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 150,
                  child: Text(
                    'только что',
                    style: TextStyle(
                        fontFamily: "Root",
                        fontSize: 11,
                        color: Color(0xff385780),
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),*/
          FutureBuilder<Articles>(
            future: ap.getFirstArticle(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none)
                return Container(
                  width: 200,
                  padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 10,
                      bottom: 5),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Color(0xffD0DAE7)),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              else if (snapshot.hasError)
                return Container(
                  width: 200,
                  padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 10,
                      bottom: 5),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Color(0xffD0DAE7)),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              else if (snapshot.data != null) {
                return Container(
                  width: 200,
                  padding: EdgeInsets.only(
                      left: 12, right: 12, top: 10, bottom: 5),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xffD0DAE7)),
                  ),
                  child: InkWell(
                    onTap: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) =>
                            NotificationBottomSheet(
                              onPressed: () {
                                Navigator.pop(context);
                                _onOpenMore(
                                  context,
                                  snapshot.data.id.toString(),
                                  "article",
                                );
                              },
                              isImportant: "true",
                              type: "article",
                              title: snapshot.data.title,
                              content: snapshot.data.shortContent,
                            ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150,
                                child: Text(
                                  snapshot.data.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: "Root",
                                      fontSize: 17,
                                      color: Color(0xff385780),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svg/icon-notify-success.svg',
                                width: 17,
                                height: 17,
                                color: AppTheme.mainColor,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 150,
                          child: Text(
                            snapshot.data.shortContent,
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 14,
                                color: Color(0xff385780),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 150,
                          child: Text(
                            snapshot.data.publishedOn,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 11,
                                color: Color(0xff385780),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.data != null) {
                return Container(
                  width: 200,
                  padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 10,
                      bottom: 5),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Color(0xffD0DAE7)),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Text(
                              'Билеты куплены',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 17,
                                  color: Color(0xff385780),
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                            SvgPicture.asset(
                              'assets/svg/icon-notify-success.svg',
                              width: 17,
                              height: 17,
                              color: AppTheme.mainColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 150,
                        child: Text(
                          'Домой, в Алматы на 8 авг, вторник',
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 14,
                              color: Color(0xff385780),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 150,
                        child: Text(
                          'только что',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 11,
                              color: Color(0xff385780),
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  width: 200,
                  padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 10,
                      bottom: 5),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Color(0xffD0DAE7)),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },),
        ],
      ),
    );


      FutureBuilder<List<NotificationData>>(
        future: notificationProvider.getNotificationsFromDB(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Center(
                child: emptyPage(Icons.error_outline, 'Something is wrong'));
          else if(snapshot.data != null && snapshot.data.isNotEmpty){
            return Container(
              width: w,
              height: 110,
              padding: EdgeInsets.only(top: 8),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: snapshot.data.take(3).map((NotificationData item) {
                  if(item.data.body.type == 'article')
                    return Container(
                      width: 200,
                      padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xffD0DAE7)),
                      ),
                      child: InkWell(
                        onTap: (){
                            showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) => NotificationBottomSheet(onPressed:() { Navigator.pop(context); _onOpenMore(context, item.data.body.id.toString(), item.data.body.type);}, contentAvailable: item.data.body.contentAvailable.toString(), isImportant: item.data.body.isImportant.toString(), type: item.data.body.type, title: item.data.body.title, content: item.data.body.content,));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.data.head.title,
                                    style: TextStyle(
                                        fontFamily: "Root",
                                        fontSize: 16,
                                        color: Color(0xff385780),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/News.svg',
                                    width: 19,
                                    height: 19,
                                    color: AppTheme.mainColor,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: 150,
                              child: Text(
                                item.data.head.body,
                                maxLines: 2,
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 14,
                                    color: Color(0xff385780),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: 150,
                              child: Text(
                                item.createdAt,
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 11,
                                    color: Color(0xff385780),
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  else if(item.data.body.type == 'application' || item.data.body.type == 'ticket')
                    return Container(
                      width: 200,
                      padding: EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 10,
                          bottom: 5),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color(0xffD0DAE7)),
                      ),
                      child: InkWell(
                        onTap: (){
                          showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) => NotificationBottomSheet(onPressed:() { Navigator.pop(context); _onOpenMore(context, item.data.body.applicationId.toString(), item.data.body.type);}, contentAvailable: item.data.body.contentAvailable.toString(), isImportant: item.data.body.isImportant.toString(), type: item.data.body.type, title: item.data.body.title, content: item.data.body.content,));
                        },
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    'Билеты куплены',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: "Root",
                                        fontSize: 17,
                                        color: Color(0xff385780),
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/icon-notify-success.svg',
                                    width: 17,
                                    height: 17,
                                    color: AppTheme.mainColor,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: 150,
                              child: Text(
                                'Домой, в Алматы на 8 авг, вторник',
                                maxLines: 2,
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 14,
                                    color: Color(0xff385780),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: 150,
                              child: Text(
                                'только что',
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 11,
                                    color: Color(0xff385780),
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  return Container(
                    width: 200,
                    height: 50,
                    color: Colors.red,
                    margin: EdgeInsets.only(left: 10),
                  );
                  /* SizedBox(width: 16),
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 10,
                        bottom: 5),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Color(0xffD0DAE7)),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                'Билеты куплены',
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 17,
                                    color: Color(0xff385780),
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                              SvgPicture.asset(
                                'assets/svg/icon-notify-success.svg',
                                width: 17,
                                height: 17,
                                color: AppTheme.mainColor,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 150,
                          child: Text(
                            'Домой, в Алматы на 8 авг, вторник',
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 14,
                                color: Color(0xff385780),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 150,
                          child: Text(
                            'только что',
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 11,
                                color: Color(0xff385780),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(
                        left: 12, right: 12, top: 10),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color(0xffD0DAE7)),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xffC81D5E),
                              Color(0xffFF4963),
                            ])),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'РВД +3 дня',
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                              SvgPicture.asset(
                                'assets/svg/Zap.svg',
                                width: 17,
                                height: 19,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 150,
                          child: Text(
                            'Текущая вахта, до 8 авг, вт',
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 150,
                          child: Text(
                            '3 часа назад',
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 11,
                                color: Colors.white
                                    .withOpacity(0.5),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(
                        left: 12, right: 12, top: 10),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border:
                      Border.all(color: Color(0xffD0DAE7)),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Важная новость',
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 16,
                                    color: Color(0xff385780),
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                              SvgPicture.asset(
                                'assets/svg/News.svg',
                                width: 19,
                                height: 19,
                                color: AppTheme.mainColor,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 150,
                          child: Text(
                            'Домой, в Алматы на 8 авг, вторник',
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 14,
                                color: Color(0xff385780),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 150,
                          child: Text(
                            'только что',
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 11,
                                color: Color(0xff385780),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                }).toList(),
              ),
            );
          }
          else if(snapshot.data != null && snapshot.data.isEmpty){
            return Container(
              width: w,
              height: 48,
              margin: EdgeInsets.only(top: 8, left: 16, right: 16),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
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
              ),
              alignment: Alignment.centerLeft,
              child: Text('Нет результатов',
                style: TextStyle(
                  fontFamily: "Root",
                  fontSize: 15,
                  color: Color(0xff748595).withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }

      }
    );
  }
}

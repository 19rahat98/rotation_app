import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
import 'package:rotation_app/logic_block/models/articles_model.dart';
import 'package:rotation_app/logic_block/models/notification_item.dart';
import 'package:rotation_app/logic_block/providers/articles_provider.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/ui/home_pages/widgets/push_notification_list_widget.dart';


import 'package:rotation_app/ui/nav_bar/tab_item.dart';
import 'package:rotation_app/ui/nav_bar/bottom_nav.dart';
import 'package:rotation_app/ui/home_pages/home_page.dart';
import 'package:rotation_app/ui/support_pages/more_article_info_widget.dart';
import 'package:rotation_app/ui/support_pages/press_service_screen.dart';
import 'package:rotation_app/ui/support_pages/social_media_widget.dart';
import 'package:rotation_app/ui/trips_pages/custom_trip_widget.dart';
import 'package:rotation_app/ui/trips_pages/trips_screen.dart';
import 'package:rotation_app/ui/support_pages/support_screen.dart';
import 'package:rotation_app/ui/user_pages/user_profile_screen.dart';
import 'package:rotation_app/ui/user_pages/notifications_list_screen.dart';
import 'package:rotation_app/ui/widgets/emptyPage.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  static int currentTab = 0;
  final _firebaseMessaging = FirebaseMessaging();



  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {

    print('myBackgroundMessageHandler');
    /*if (message.containsKey('data')) {
      print(message);
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      print(message);
      print(message['notification']);
      print(message['data']);
      final dynamic notification = message['notification'];
    }*/
    return null;
    // Or do other work.
  }

  void _fcmHandle() async {
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    }
    //_firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.configure(
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _navigateToItemDetail(message);
      },

    );
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
                else if(snapshot.data != null){
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
                else if (snapshot.hasError){
                  Navigator.pop(context);
                  return Container();
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

  final Map<String, Item> _items = <String, Item>{};
  Item _itemForMessage(Map<String, dynamic> message, BuildContext context) {
    final dynamic data = message['data'] ?? message;
    final String itemId = data['id'];
    if(data['type'] == 'article'){
      final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
        .._contentAvailable = data['content_available']
        .._priority = data['priority']
        .._type = data['type']
        .._id = data['id']
        .._isImportant = data['is_important']
        .._content = data['content']
        .._title = data['title'];
      return item;
    }
    else if(data['type'] == "application" || data['type'] == "ticket" ){}
    final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
      .._contentAvailable = data['content_available']
      .._priority = data['priority']
      .._type = data['type']
      .._applicationId = data['application_id']
      //.._segmentId = data['application_id']
      .._isImportant = data['is_important']
      .._content = data['content']
      .._title = data['title'];
    return item;
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message, context);
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if(item._type == "application" || item._type == "ticket" ){
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => NotificationBottomSheet(onPressed:() { Navigator.pop(context); _onOpenMore(context, item._applicationId, item._type);}, contentAvailable: item._contentAvailable, isImportant: item._isImportant, type: item._type, orderId: item._applicationId, title: item._title, content: item._content,));
      //_onOpenMore(context, item._applicationId);
    }
    else if(item._type == 'article'){
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => NotificationBottomSheet(onPressed:() { Navigator.pop(context); _onOpenMore(context, item._id, item._type);}, contentAvailable: item._contentAvailable, isImportant: item._isImportant, type: item._type, orderId: item._applicationId, title: item._title, content: item._content,));
    }
    else if(Navigator.canPop(context)){
      Navigator.pop(context);
      Navigator.push(context, item.route);
    }
    else if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
    else{
      Navigator.push(context, item.route);
      //Navigator.of(context, rootNavigator: false).push(item.route);
    }
  }

  @override
  void initState() {
    _fcmHandle();
    super.initState();
  }

  // list tabs here
  final List<TabItem> tabs = [
    TabItem(
      tabName: "Главная",
      icon: 'assets/svg/Home.svg',
      page: HomePage(),
    ),
    TabItem(
      tabName: "Поездки",
      icon: 'assets/svg/Calendar.svg',
      page: TripsPage(),
    ),
    TabItem(
      tabName: "Помощь",
      icon: 'assets/svg/Help.svg',
      page: SupportScreen(),
    ),
    TabItem(
      tabName: "Профиль",
      icon: 'assets/svg/Profile.svg',
      page: UserProfileScreen(),
    ),
  ];

  AppState() {
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  // sets current tab index
  // and update state
  void _selectTab(int index) {
    if (index == currentTab) {
      // pop to first route
      // if the user taps on the active tab
      tabs[index].key.currentState.popUntil((route) => route.isFirst);
    } else {
      // update the state
      // in order to repaint
      setState(() => currentTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // WillPopScope handle android back btn
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await tabs[currentTab].key.currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          print('isFirstRouteInCurrentTab');

          if (currentTab != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
          else{_selectTab(0);}
        }
        else if(!isFirstRouteInCurrentTab){
          return false;
        }
        // let system handle back button if we're on the first route
        _selectTab(0);
        return false;
      },
      // this is the base scaffold
      // don't put appbar in here otherwise you might end up
      // with multiple appbars on one screen
      // eventually breaking the app
      child: Scaffold(
        // indexed stack shows only one child
        body: IndexedStack(
          index: currentTab,
          children: tabs.map((e) => e.page).toList(),
        ),
        // Bottom navigation
        bottomNavigationBar: BottomNavigation(
          onSelectTab: _selectTab,
          tabs: tabs,
        ),
      ),
    );
  }
}


class Item {
  Item({this.itemId});
  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _contentAvailable;
  String get contentAvailable => _contentAvailable;
  set contentAvailable(String value) {
    _contentAvailable = value;
    _controller.add(this);
  }

  String _id;
  String get id => _contentAvailable;
  set id(String value) {
    _id = value;
    _controller.add(this);
  }

  String _priority;
  String get priority => _priority;
  set priority(String value) {
    _priority = value;
    _controller.add(this);
  }

  String _type;
  String get type => _type;
  set type(String value) {
    _type = value;
    _controller.add(this);
  }

  String _applicationId;
  String get applicationId => _applicationId;
  set applicationId(String value) {
    _applicationId = value;
    _controller.add(this);
  }


  int _segmentId;
  int get segmentId => _segmentId;
  set segmentId(int value) {
    _segmentId = value;
    _controller.add(this);
  }

  String _isImportant;
  String get isImportant => _isImportant;
  set isImportant(String value) {
    _isImportant = value;
    _controller.add(this);
  }

  String _content;
  String get content => _content;
  set content(String value) {
    _content = value;
    _controller.add(this);
  }


  String _title;
  String get title => _title;
  set title(String value) {
    _title = value;
    _controller.add(this);
  }


  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    print('try open page');
    final String routeName = '/detail/$itemId';
    print(routes);
    routes.clear();
    if(_type == "ticket" || _type == "application"){
      print('ticket test');
      print(_applicationId);
      /*return routes.putIfAbsent(
        routeName, () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => HomePage(pushMessage: true, applicationId: _applicationId,),
        //builder: (BuildContext context) => NotificationsListScreen(),
        ),
      );*/
    }
    else if(_type == "article"){
      return routes.putIfAbsent(routeName, () => MaterialPageRoute<void>(
          settings: RouteSettings(name: routeName),
          builder: (BuildContext context) => PressServiceScreen(
            pushMessage: true,
            articleId: _id,
          ),
        ),
      );
    }
    else{
      return routes.putIfAbsent(routeName, () => MaterialPageRoute<void>(
          settings: RouteSettings(name: routeName),
          builder: (BuildContext context) => NotificationsListScreen(
            itsAction: true,
            contentAvailable: _contentAvailable,
            priority: _priority,
            type: _type,
            orderId: itemId,
            segmentId: _segmentId,
            isImportant: _isImportant,
            content: _content,
            title: _title,
          ),
          //builder: (BuildContext context) => NotificationsListScreen(),
        ),
      );
    }

  }
}
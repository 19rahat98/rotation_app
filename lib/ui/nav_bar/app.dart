import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'package:rotation_app/ui/nav_bar/tab_item.dart';
import 'package:rotation_app/ui/nav_bar/bottom_nav.dart';
import 'package:rotation_app/ui/home_pages/home_page.dart';
import 'package:rotation_app/ui/trips_pages/trips_screen.dart';
import 'package:rotation_app/ui/support_pages/support_screen.dart';
import 'package:rotation_app/ui/user_pages/user_profile_screen.dart';
import 'package:rotation_app/ui/user_pages/notifications_list_screen.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  static int currentTab = 0;
  final _firebaseMessaging = FirebaseMessaging();

  void _fcmHandle() async {
    print('testtest');

    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _navigateToItemDetail(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
  }


  final Map<String, Item> _items = <String, Item>{};
  Item _itemForMessage(Map<String, dynamic> message) {
    final dynamic data = message['data'] ?? message;
    final String itemId = data['id'];
    final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
      .._contentAvailable = data['content_available']
      .._priority = data['priority']
      .._type = data['type']
      //.._segmentId = data['segment_id']
      //.._isImportant = data['is_important']
      .._content = data['content']
      .._title = data['title'];
    return item;
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if(Navigator.canPop(context)){
      Navigator.pop(context);
      Navigator.push(context, item.route);
    }
    else if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
    else{
      Navigator.push(context, item.route);
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
            print('currentTab');

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

  int _segmentId;
  int get segmentId => _segmentId;
  set segmentId(int value) {
    _segmentId = value;
    _controller.add(this);
  }

  bool _isImportant;
  bool get isImportant => _isImportant;
  set isImportant(bool value) {
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
    return routes.putIfAbsent(
      routeName,
          () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => NotificationsListScreen(itsAction: true, contentAvailable: _contentAvailable, priority: _priority, type: _type, orderId: itemId, segmentId: _segmentId, isImportant: _isImportant, content: _content, title: _title,),
        //builder: (BuildContext context) => NotificationsListScreen(),
      ),
    );
  }
}
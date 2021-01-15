import 'package:flutter/material.dart';

import 'package:rotation_app/ui/home_pages/home_page.dart';
import 'package:rotation_app/ui/support_pages/support_screen.dart';
import 'package:rotation_app/ui/trips_pages/trips_screen.dart';
import 'package:rotation_app/ui/user_pages/user_profile_screen.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.calendar_today_outlined),
          title: Text("Главная"),
        ),
        TabNavigationItem(
          page: TripsPage(),
          icon: Icon(Icons.calendar_today_outlined),
          title: Text("Поездки"),
        ),
        TabNavigationItem(
          page: SupportScreen(),
          icon: Icon(Icons.calendar_today_outlined),
          title: Text("Помощь"),
        ),
        TabNavigationItem(
          page: UserProfileScreen(),
          icon: Icon(Icons.calendar_today_outlined),
          title: Text("Профиль"),
        ),
      ];
}

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 22,
        elevation: 10,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff1C7BD7),
        selectedLabelStyle: TextStyle(
          color: Color(0xff1C7BD7),
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        unselectedItemColor: Color(0xff748595),
        unselectedLabelStyle: TextStyle(
          color: Color(0xff748595),
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.white.withOpacity(0.97),
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 5),
                child: tabItem.icon,
              ),
              title: tabItem.title,
            )
        ],
      ),
    );
  }
}

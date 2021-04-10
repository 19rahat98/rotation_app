import 'package:rotation_app/ui/nav_bar/tab_item.dart';

import 'app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    this.onSelectTab,
    this.tabs,
  });

  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 22,
      elevation: 10,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white.withOpacity(0.97),
      selectedLabelStyle: TextStyle(
        color: Color(0xff1C7BD7),
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      items: tabs.map((e) => _buildItem(
          index: e.getIndex(),
          icon: e.icon,
          tabName: e.tabName,
        ),
      ).toList(),
      onTap: (index) => onSelectTab(
        index,
      ),
    );
  }

  BottomNavigationBarItem _buildItem(
      {int index, String icon, String tabName}) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          color: _tabColor(index: index),
        ),
      ),
      title: Text(
        tabName,
        style: TextStyle(fontFamily: "Root",
          color: _tabColor(index: index),
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _tabColor({int index}) {
    return AppState.currentTab == index ? Color(0xff1C7BD7) : Color(0xff748595);
  }
}
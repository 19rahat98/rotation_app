import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'active_trips_widget.dart';

class TripsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffF3F6FB),
        appBar: AppBar(
          title: Text(
            'Мои поездки',
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff2D4461),
        ),
        body: Container(
          width: w,
          height: h,
          child: Column(
            children: [
              Container(
                height: 56,
                color: Colors.white,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    TabBar(
                      unselectedLabelColor: Color(0xff748595),
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      labelColor: Color(0xff1262CB),
                      indicator: MD2Indicator(
                        indicatorHeight: 3.0,
                        indicatorColor: Color(0xff1262CB),
                        indicatorSize: MD2IndicatorSize.full,
                      ),
                      tabs: [
                        Tab(text: 'Активные поездки'),
                        Tab(
                          text: 'Архив поездок',
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: w,
                        height: 2,
                        color: Color(0xff748595).withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    children: [
                      ReviewsWidget(),
                      ReviewsWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

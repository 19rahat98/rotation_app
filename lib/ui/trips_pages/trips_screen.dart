import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import 'package:rotation_app/ui/widgets/emptyPage.dart';
import 'package:rotation_app/ui/trips_pages/active_trips_widget.dart';
import 'package:rotation_app/ui/trips_pages/archive_trips_widget.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';

class TripsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    LoginProvider lp = Provider.of<LoginProvider>(context, listen: false);
    return FutureBuilder<List<Application>>(
      future: lp.getEmployeeApplication(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.hasError)
          return Center(
              child: emptyPage(Icons.error_outline, 'Something is wrong'));
        else {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Color(0xffF3F6FB),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'Мои поездки',
                  style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
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
                            labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            labelColor: Color(0xff1262CB),
                            indicator: MD2Indicator(
                              indicatorHeight: 3.0,
                              indicatorColor: Color(0xff1262CB),
                              indicatorSize: MD2IndicatorSize.full,
                            ),
                            tabs: [
                              Tab(
                                text: 'Активные поездки',
                              ),
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
                            lp.data != null && lp.data.isNotEmpty
                                ? ActiveTripsWidget(
                                  tripsList: lp.data,
                                )
                                : Container(),
                            lp.data != null && lp.data.isNotEmpty
                                ? ArchiveTrips(
                                  tripsList: lp.data,
                                )
                                : Container(),
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
      },
    );
  }
}


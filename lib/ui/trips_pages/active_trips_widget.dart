import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'inactive_trip_widget.dart';
import 'tickets_bottom_sheet.dart';
import 'package:rotation_app/ui/trips_pages/active_widget.dart';
import 'package:rotation_app/logic_block/models/application.dart';

class ActiveTripsWidget extends StatefulWidget {
  final List<Application> tripsList;

  const ActiveTripsWidget({Key key, this.tripsList}) : super(key: key);

  @override
  _ActiveTripsWidgetState createState() => _ActiveTripsWidgetState();
}

class _ActiveTripsWidgetState extends State<ActiveTripsWidget> {
  List<Application> _activeTrip = List<Application>();

  @override
  void initState() {
    super.initState();
    getActiveTrips();
  }

  void getActiveTrips(){
    for (var x in widget.tripsList) {
      print(new DateFormat.yMMMd('ru').format(DateTime.parse(x.date)));
      if (DateTime.now().isBefore(DateTime.parse(x.date))) {
        _activeTrip.add(x);
      }
    }
    print(_activeTrip);
  }

  void _onOpenMore(BuildContext context, Application tripData) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: w,
          constraints: new BoxConstraints(
            maxHeight: h * 0.85,
          ),
          //height: h * 0.90,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: TicketsBottomSheet(tripData: tripData),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: _activeTrip.map((item) {
          if(item.segments.isNotEmpty){
            return InkWell(
              onTap: () {
                _onOpenMore(context, item);
              },
              child: ActiveWidget(tripData: item),
            );
          }else{
            return InkWell(
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => InactiveTripActionSheet(tripData: item));
              },
              child: InactiveTripWidget(tripData: item),
            );
          }
          },
        ).toList(),
      )
    );
  }
}

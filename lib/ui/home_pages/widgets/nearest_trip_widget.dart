import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
import 'package:rotation_app/ui/trips_pages/active_widget.dart';
import 'package:rotation_app/ui/trips_pages/custom_trip_widget.dart';
import 'package:rotation_app/ui/trips_pages/inactive_trip_widget.dart';
import 'package:rotation_app/ui/trips_pages/returned_ticket.dart';
import 'package:rotation_app/ui/trips_pages/tickets_bottom_sheet.dart';
import 'package:rotation_app/ui/trips_pages/with_datailes_trip_widget.dart';

class NearestTripWidget extends StatefulWidget {
  final List<Application> tripsList;

  const NearestTripWidget({Key key, this.tripsList}) : super(key: key);

  @override
  _NearestTripWidgetState createState() => _NearestTripWidgetState();
}

class _NearestTripWidgetState extends State<NearestTripWidget> {

  Application nearestTrip;

  void _onOpenMore(BuildContext context, {routName}) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
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
          child: routName,
        );
      },
    );
  }

  @override
  void initState() {
    if(widget.tripsList != null && widget.tripsList.isNotEmpty) nearestTrip = getAllTrips();
    super.initState();
  }

  Application getAllTrips() {
    for (var x in widget.tripsList) {
      if (DateTime.now().isBefore(DateTime.parse(x.date))) {
        return x;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    if(nearestTrip.segments.isEmpty && nearestTrip.status == "opened"){
      return InkWell(
        onTap: () {
          showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) =>
                  InactiveTripActionSheet(tripData: nearestTrip));
        },
        child: InactiveTripWidget(tripData: nearestTrip),
      );
    }
    else if(nearestTrip.segments.length == 1 && nearestTrip.status == "opened"){
      return InkWell(
        onTap: () {
          _onOpenMore(context,
              routName: WithDetailsTripSheet(
                tripData: nearestTrip,
              ));
        },
        child: SingleCustomDetailsTripWidget(tripData: nearestTrip),
      );
    }
    else if(nearestTrip.segments.length == 1 && nearestTrip.status == "returned"){
      return InkWell(
        onTap: () {
          _onOpenMore(context,
              routName: ReturnedTicketBottomSheet(
                tripData: nearestTrip,
              ));
        },
        child: ReturnedTicketWidget(tripData: nearestTrip),
      );
    }
    else if(nearestTrip.segments.length == 1 && nearestTrip.status == "issued"){
      return InkWell(
        onTap: () {
          _onOpenMore(context,
              routName: TicketsBottomSheet(
                tripData: nearestTrip,
              ));
        },
        child: SingleActiveWidget(tripData: nearestTrip),
      );
    }
    else if(nearestTrip.segments.length > 1 ){
      return InkWell(
        onTap: () {
          print(nearestTrip.id);

          _onOpenMore(context,
              routName: CustomTripSheet(
                tripData: nearestTrip,
              ));
        },
        child: CustomTripPage(tripData: nearestTrip),
      );
    }
    else{
      print(nearestTrip.id);
      return Container(
        width: w,
        height: 50,
      );
    }
  }
}

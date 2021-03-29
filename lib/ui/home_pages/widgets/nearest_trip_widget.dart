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

class NearestTripWidget extends StatelessWidget {
  final List<Application> tripsList;

  const NearestTripWidget({Key key, this.tripsList}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    if(tripsList != null && tripsList.isNotEmpty){
      print(tripsList.length);
      for(int i = 0; i < tripsList.length; i++){
        if (DateTime.now().isBefore(DateTime.parse(tripsList[i].date))) {
          print(tripsList[i].date);
          /*if(tripsList[i].segments.isEmpty && tripsList[i].status == "opened"){
            return InkWell(
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) =>
                        InactiveTripActionSheet(tripData: tripsList[i]));
              },
              child: InactiveTripWidget(tripData: tripsList[i]),
            );
          }*/
          /*if(tripsList[i].segments.length == 1 && tripsList[i].status == "opened"){
            print('sdsdsdsd');
            return InkWell(
              onTap: () {
                _onOpenMore(context,
                    routName: WithDetailsTripSheet(
                      tripData: tripsList[i],
                    ));
              },
              child: SingleCustomDetailsTripWidget(tripData: tripsList[i]),
            );
          }*/
          if(tripsList[i].segments.length == 1 && tripsList[i].status == "issued"){
            return InkWell(
              onTap: () {
                _onOpenMore(context,
                    routName: TicketsBottomSheet(
                      tripData: tripsList[i],
                    ));
              },
              child: SingleActiveWidget(tripData: tripsList[i]),
            );
          }
          else if(tripsList[i].segments.length == 1 && tripsList[i].status == "opened" && tripsList[i].segments.first.activeProcess == "watching"){
            return InkWell(
              onTap: () {
                _onOpenMore(context,
                    routName: WithDetailsTripSheet(
                      tripData: tripsList[i],
                    ));
              },
              child: SingleCustomDetailsTripWidget(tripData: tripsList[i]),
            );
          }
          else if(tripsList[i].segments.length > 1 && (tripsList[i].status == 'issued' || (tripsList[i].status == 'opened' && (tripsList[i].segments.first.activeProcess == "watching" || tripsList[i].segments[1].activeProcess == "watching")) || tripsList[i].status == 'partly')){
            return InkWell(
              onTap: () {
                print(tripsList[i].id);
                _onOpenMore(context,
                    routName: CustomTripSheet(
                      tripData: tripsList[i],
                    ));
              },
              child: CustomTripPage(tripData: tripsList[i]),
            );
          }
        }
      }
      return Container(
        width: w,
        height: 48,
        margin: EdgeInsets.only(top: 8),
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
        child: Text('У вас нет активных поездок.',
          style: TextStyle(
            fontFamily: "Root",
            fontSize: 15,
            color: Color(0xff748595).withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    else{
      return Container(
        width: w,
        height: 48,
        margin: EdgeInsets.only(top: 8),
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
        child: Text('У вас нет активных поездок.',
          style: TextStyle(
            fontFamily: "Root",
            fontSize: 15,
            color: Color(0xff748595).withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }



  }
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

}

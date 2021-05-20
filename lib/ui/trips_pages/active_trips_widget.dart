import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:rotation_app/ui/trips_pages/custom_trip_widget.dart';
import 'package:rotation_app/ui/trips_pages/inactive_trip_widget.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';

class ActiveTripsWidget extends StatelessWidget {
  final Application tripsList;
  final ScrollController scrollController;
  const ActiveTripsWidget({Key key, this.tripsList, this.scrollController}) : super(key: key);

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
  Widget build(BuildContext context) {
    Map applicationStatus = Map();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    //lp.getStatusApplication(tripsList.where((element) => DateTime.now().isBefore(DateTime.parse(element))));
    var temp = DateTime.now().toUtc();
    var d1 = DateTime.utc(temp.year,temp.month,temp.day);
    var d2 = DateTime.utc(DateTime.parse(tripsList.date).year, DateTime.parse(tripsList.date).month, DateTime.parse(tripsList.date).day);
    if (DateTime.now().isBefore(DateTime.parse(tripsList.date)) || d2.compareTo(d1)==0){

      if(tripsList.segments.isEmpty && tripsList.status == "opened"){
        return InkWell(
          onTap: () {
            print(tripsList.id);
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) =>
                    InactiveTripActionSheet(tripData: tripsList));
          },
          child: InactiveTripWidget(tripData: tripsList),
        );
      }
      /*else if(item.segments.length == 1 && item.status == "opened"){
                  return InkWell(
                    onTap: () {
                      _onOpenMore(context,
                          routName: WithDetailsTripSheet(
                            tripData: item,
                          ));
                    },
                    child: SingleCustomDetailsTripWidget(tripData: item),
                  );
                }
                else if(item.segments.length == 1 && item.status == "issued"){
                  return InkWell(
                    onTap: () {
                      _onOpenMore(context,
                          routName: TicketsBottomSheet(
                            tripData: item,
                          ));
                    },
                    child: SingleActiveWidget(tripData: item),
                  );
                }*/
    else if(tripsList.applicationStatus.length == 1 && (tripsList.applicationStatus.containsKey('red') || tripsList.applicationStatus.containsKey('canceled')))
      return Container();
    else if(tripsList.segments.isNotEmpty && !(tripsList.applicationStatus.length == 1 && tripsList.applicationStatus.containsKey('red'))){
        return InkWell(
          onTap: () {
            print(tripsList.applicationStatus);
            _onOpenMore(
              context,
              routName: CustomTripSheet(
                tripData: tripsList,
              ),
            );
          },
          child: CustomTripPage(tripData: tripsList),
        );
      }
      else{
        return Container();
      }
    }
    else{
      return Container();
    }
  }
}

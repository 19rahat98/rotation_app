import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';


import 'inactive_trip_widget.dart';
import 'tickets_bottom_sheet.dart';
import 'package:rotation_app/ui/trips_pages/active_widget.dart';
import 'package:rotation_app/ui/trips_pages/returned_ticket.dart';
import 'package:rotation_app/ui/trips_pages/custom_trip_widget.dart';
import 'package:rotation_app/logic_block/models/application_model.dart';
import 'package:rotation_app/ui/trips_pages/with_datailes_trip_widget.dart';

class ArchiveTrips extends StatelessWidget{
  final List<Application> tripsList;
  final ScrollController scrollController;
  const ArchiveTrips({Key key, this.tripsList, this.scrollController}) : super(key: key);


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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    LoginProvider lp = Provider.of<LoginProvider>(context, listen: false);
    Map applicationStatus = Map();
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: tripsList.map((item) {
            if (DateTime.now().isAfter(DateTime.parse(item.date)) || (!item.applicationStatus.containsKey('all') && !item.applicationStatus.containsKey('grey') && !item.applicationStatus.containsKey('green') && !item.applicationStatus.containsKey('yellow'))) {
              if(item.segments.isEmpty && item.status == "opened" ){
                return InkWell(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) =>
                            InactiveTripActionSheet(tripData: item));
                  },
                  child: InactiveTripWidget(tripData: item),
                );
              }
              else if(item.segments.length == 1 && item.status == "opened"){
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
              else if(item.segments.length == 1 && item.status == "returned" || item.segments.length == 1 && item.status == "canceled"){
                return InkWell(
                  onTap: () {
                    _onOpenMore(context,
                        routName: ReturnedTicketBottomSheet(
                          tripData: item,
                        ));
                  },
                  child: ReturnedTicketWidget(tripData: item),
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
              }
              else if(item.segments.length > 1 && item.applicationStatus != null ){
                return InkWell(
                  onTap: () {
                    _onOpenMore(context,
                      routName: CustomTripSheet(
                        tripData: item,
                      ),
                    );
                  },
                  child: CustomTripPage(tripData: item),
                );
              }
              else{
                return Container();
              }
            }
            else{
              return Container();
            }
              /*if (item.status == "opened" && item.segments.isEmpty) {
                return InkWell(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) =>
                            InactiveTripActionSheet(tripData: item));
                  },
                  child: InactiveTripWidget(tripData: item),
                );
              }
              else if (*//*item.status == "opened" && *//*item.segments.length == 1) {
                if (item.segments.first.activeProcess == 'watching' &&
                    item.segments.first.status == "opened") {
                  return InkWell(
                    onTap: () {
                      _onOpenMore(context,
                          routName: OnWaitingListTripSheet(
                            tripData: item,
                          ));
                    },
                    child: OnWaitingListWidget(tripData: item),
                  );
                }
                else if (item.segments.first.status == "opened") {
                  return InkWell(
                    onTap: () {
                      _onOpenMore(context,
                          routName: WithDetailsTripSheet(
                            tripData: item,
                          ));
                    },
                    child: WithDetailsTripWidget(tripData: item),
                  );
                }
                else if (item.segments.first.status == "returned") {
                  return InkWell(
                    onTap: () {
                      _onOpenMore(context,
                          routName: ReturnedTicketBottomSheet(
                            tripData: item,
                          ));
                    },
                    child: ReturnedTicketWidget(tripData: item),
                  );
                }
                else {
                  return InkWell(
                    onTap: () {
                      _onOpenMore(context,
                          routName: ReturnedTicketBottomSheet(
                            tripData: item,
                          ));
                    },
                    child: ReturnedTicketWidget(tripData: item),
                  );
                }
              } else if (item.segments.length > 1) {
                return InkWell(
                  onTap: () {
                    _onOpenMore(context,
                        routName: CustomTripSheet(
                          tripData: item,
                        ));
                  },
                  child: CustomTripPage(tripData: item),
                );
              } else {
                return InkWell(
                  onTap: () {
                    _onOpenMore(context,
                        routName: TicketsBottomSheet(
                          tripData: item,
                        ));
                  },
                  child: ActiveWidget(tripData: item),
                );
              }*/
              /*else if(item.status == "opened" &&  item.segments.isNotEmpty){
            print(item.id);
            bool _isOpened = false;
            for(int i = 0; i < item.segments.length; i++){
              print(item.segments[i].status);
              if(item.segments[i].status == "opened" && _isOpened || item.segments[i].status == "opened" && i == 0 ){
               _isOpened = true;
              }else _isOpened = false;
            }
            */ /* Вид заявки "C деталями" запланированная, application status": "opened", segments  "status": "opened"*/ /*
            if(_isOpened && item.segments.first.activeProcess == null){
              return InkWell(
                onTap: () {
                  _onOpenMore(context, routName: WithDetailsTripSheet(tripData: item,));
                },
                child: WithDetailsTripWidget(tripData: item),
              );
            }
            else if(_isOpened && item.segments.first.activeProcess == 'watching'){
              return InkWell(
                onTap: () {
                  _onOpenMore(context, routName: OnWaitingListTripSheet(tripData: item,));
                },
                child: OnWaitingListWidget(tripData: item),
              );
            }
            else return Container(width: w, height: 10, color: Colors.red,);

          }
          else{
            return InkWell(
              onTap: () {
                _onOpenMore(context, routName: TicketsBottomSheet(tripData: item,));
              },
              child: ActiveWidget(tripData: item),
            );
          }*/
            },
          ).toList(),
        ));
  }
}

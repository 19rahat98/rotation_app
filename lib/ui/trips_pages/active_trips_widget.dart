import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'inactive_trip_widget.dart';
import 'tickets_bottom_sheet.dart';

class ReviewsWidget extends StatelessWidget {
  void _onOpenMore(BuildContext context) {
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
            maxHeight: h * 0.90,
          ),
          //height: h * 0.90,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: TicketsBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Container(
              width: w,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.white),
              child: InkWell(
                onTap: () {
                  _onOpenMore(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Домой, ',
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Color(0xff0C2B4C),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '8 авг',
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Color(0xffFF4242),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(0xffFF4242)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.train,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'РВД +5',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(0xff00B688)),
                                    child: Icon(
                                      Icons.train,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            'В Алматы',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff748595),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/avia-bekair.svg",
                                width: 31,
                                height: 22,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Актогай — Алматы-2',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '16 авг, ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '10:40 - 16:20',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      width: 250,
                      child: Text(
                        'У вас овертайм +5 дней,  билеты на новую дату куплены',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff748595).withOpacity(0.6),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.white),
              child: InkWell(
                onTap: (){
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => InactiveTripWidget());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'На вахту, ',
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Color(0xff0C2B4C),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '25 авг',
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Color(0xff0C2B4C),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    margin: EdgeInsets.only(right: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(0xff2D4461)),
                                    child: Icon(
                                      Icons.train,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(0xff00B688)),
                                    child: Icon(
                                      Icons.train,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            'на 10 дней, в Актогай',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff748595),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/avia-bekair.svg",
                                width: 31,
                                height: 22,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Актогай — Алматы-2',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '16 авг, ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '10:40 - 16:20',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/avia-bekair.svg",
                                width: 31,
                                height: 22,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Балхаш  – Актогай',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '16 авг, ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '10:40 - 16:20',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff1B344F),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Домой, ',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color(0xff0C2B4C),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '25 авг',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color(0xff0C2B4C),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xff00B688)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.train,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.airplanemode_active,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'на 10 дней, в Актогай',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/avia-bekair.svg",
                              width: 31,
                              height: 22,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Актогай — Алматы-2',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff1B344F),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '16 авг, ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff1B344F),
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '10:40 - 16:20',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff1B344F),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/avia-bekair.svg",
                              width: 31,
                              height: 22,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Балхаш  – Актогай',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff1B344F),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '16 авг, ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff1B344F),
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '10:40 - 16:20',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff1B344F),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'На вахту, ',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color(0xff0C2B4C),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '25 авг',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color(0xff0C2B4C),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'на 10 дней, в Актогай',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'Билеты еще не оформлены',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff748595),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Домой, ',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color(0xff0C2B4C),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '25 авг',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color(0xff0C2B4C),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'В Алматы',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff748595),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'Билеты еще не оформлены',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff748595),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

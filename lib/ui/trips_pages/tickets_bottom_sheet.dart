import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TicketsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                          'На вахту, 16 авг',
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff1B344F),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '8 ч 45 мин в пути',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff748595).withOpacity(0.7)),
                          ),
                          SvgPicture.asset(
                            "assets/svg/moon.svg",
                          ),
                          Text(
                            'Ночная смена',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff748595).withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: Color(0xff748595),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 0,
              color: Color(0xffEBEBEB),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.train,
                        color: Color(0xff1B344F),
                        size: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 3),
                        width: 2,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xff1B344F),
                        ),
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        margin: EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 3,
                            color: Color(0xff1B344F),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/avia-bekair.svg",
                                width: 33,
                                height: 33,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '16 авг, вт',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff1B344F),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 4, bottom: 4),
                                      child: Text(
                                        '10:40',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff1B344F),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      'Алматы-2, Алматы',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff748595)
                                              .withOpacity(0.7),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Divider(
                            thickness: 1,
                            height: 0,
                            color: Color(0xffEBEBEB),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 16, left: 10, bottom: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.3,
                                    child: Text(
                                      'перевозчик',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff748595)
                                              .withOpacity(0.7)),
                                    ),
                                  ),
                                  Container(
                                    width: w * 0.3,
                                    child: Text(
                                      'КТЖ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff1B344F)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.3,
                                    child: Text(
                                      'поезд',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff748595)
                                              .withOpacity(0.7)),
                                    ),
                                  ),
                                  Container(
                                    width: w * 0.5,
                                    child: Text(
                                      '№31Т (Шымкент - Семей)',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff1B344F)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.3,
                                    child: Text(
                                      'вагон',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff748595)
                                              .withOpacity(0.7)),
                                    ),
                                  ),
                                  Container(
                                    width: w * 0.3,
                                    child: Text(
                                      'Купе №17',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff1B344F)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Divider(
                            thickness: 1,
                            height: 0,
                            color: Color(0xffEBEBEB),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/avia-bekair.svg",
                                width: 33,
                                height: 33,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '16 авг, вт',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff1B344F),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 4, bottom: 4),
                                      child: Text(
                                        '10:40',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff1B344F),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      'Алматы-2, Алматы',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff748595)
                                              .withOpacity(0.7),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffF5F8FB),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 14),
                    child: Text(
                      'Стоимость',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Билеты',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff1B344F),
                        ),
                      ),
                      Text(
                        '32 670 тг',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff748595),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xffEBEBEB),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Тариф «Комфорт"',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff1B344F),
                        ),
                      ),
                      Text(
                        '+4 800 тг',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff748595),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xffEBEBEB),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Итого',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff1B344F),
                        ),
                      ),
                      Text(
                        '36 670 тг',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff2D4461),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              width: w,
              height: 52,
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: RadialGradient(
                    radius: 4, colors: [Color(0xff1989DD), Color(0xff1262CB),]),
              ),
              child: Center(child: Text('Скачать билеты', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:rotation_app/ui/support_pages/call_support_widget.dart';
import 'package:rotation_app/ui/support_pages/press_service_screen.dart';
import 'package:rotation_app/ui/support_pages/questions_answers_screen.dart';
import 'package:rotation_app/ui/support_pages/social_media_widget.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF3F6FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Помощь',
          style: TextStyle(fontFamily: "Root",
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2D4461),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: w,
          //margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, top: 24, right: 16),
                child: Text(
                  'Помощь',
                  style: TextStyle(fontFamily: "Root",
                      fontSize: 24,
                      color: Color(0xff1B344F),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16),
                child: Text(
                  'Поддержка клиентов работает круглосуточно, без выходных дней, без перерывов.',
                  style: TextStyle(fontFamily: "Root",
                      fontSize: 15,
                      color: Color(0xff1B344F).withOpacity(0.5),
                      fontWeight: FontWeight.w400),
                ),
              ),
              InkWell(
                onTap: () {
                    showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CallSupportWidget());
                },
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 24),
                  width: w,
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 22,
                        color: Color(0xff748595),
                      ),
                      Container(
                        width: w - 100,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Позвонить в поддержку',
                          style: TextStyle(fontFamily: "Root",
                              fontSize: 17,
                              color: Color(0xff1B344F),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, color: Color(0xffA2A9B3), size: 14,),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 1.2,
                endIndent: 16,
                indent: 16,
                color: Color(0xffEBEBEB),
              ),
              InkWell(
                onTap: (){
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => SocialMediaBottomSheet());
                },
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 24),
                  width: w,
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 22,
                        color: Color(0xff748595),
                      ),
                      Container(
                        width: w - 100,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Написать в поддержку',
                          style: TextStyle(fontFamily: "Root",
                              fontSize: 17,
                              color: Color(0xff1B344F),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, color: Color(0xffA2A9B3), size: 14,),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 1.2,
                endIndent: 16,
                indent: 16,
                color: Color(0xffEBEBEB),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionsAnswers()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 24),
                  width: w,
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 22,
                        color: Color(0xff748595),
                      ),
                      Container(
                        width: w - 100,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Вопросы и ответы',
                          style: TextStyle(fontFamily: "Root",
                              fontSize: 17,
                              color: Color(0xff1B344F),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, color: Color(0xffA2A9B3), size: 14,),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 1.2,
                endIndent: 16,
                indent: 16,
                color: Color(0xffEBEBEB),
              ),
              InkWell(

                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PressServiceScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 24),
                  width: w,
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 22,
                        color: Color(0xff748595),
                      ),
                      Container(
                        width: w - 100,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Пресс-служба',
                          style: TextStyle(fontFamily: "Root",
                              fontSize: 17,
                              color: Color(0xff1B344F),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, color: Color(0xffA2A9B3), size: 14,),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 1.2,
                endIndent: 16,
                indent: 16,
                color: Color(0xffEBEBEB),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

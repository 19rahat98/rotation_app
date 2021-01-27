import 'dart:async';
import 'package:rotation_app/ui/support_pages/more_article_info_widget.dart';
import 'package:rotation_app/ui/trips_pages/tickets_bottom_sheet.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PressServiceScreen extends StatefulWidget {
  @override
  _PressServiceScreenState createState() => _PressServiceScreenState();
}

class _PressServiceScreenState extends State<PressServiceScreen> {
  final TextEditingController _searchQuestionTextController =
      TextEditingController();



  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF3F6FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          'Пресс-служба',
          style: TextStyle(fontFamily: "Root",
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2D4461),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  'Пресс-служба',
                  style: TextStyle(fontFamily: "Root",
                      fontSize: 24,
                      color: Color(0xff1B344F),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                height: 48,
                width: w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    width: 1,
                    color: Color(0xffD9DBDF),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: SvgPicture.asset(
                        "assets/svg/search.svg",
                        width: 16,
                        height: 16,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        autofocus: false,
                        controller: _searchQuestionTextController,
                        style: TextStyle(fontFamily: "Root",
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff748595),
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: "Найти…",
                          hintStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff748595)),
                        ),
                        validator: (value) {
                          if (value.length == 0)
                            return ("Comments can't be empty!");

                          return value = null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        _onOpenMore(context, 'Смертность на железной дороге в Московской области снижается на 10%', '''Губернатор Московской области Андрей Воробьев в рамках «Транспортной недели – 2020» отметил, что смертность на железной дороге в Московской области снижается на 10% в год.
                        
«Снижение смертности на дорогах – это приоритет транспортной политики. И на железной дороге у нас есть задача, чтобы с 450 человек в год мы стремились к нулю. У нас есть не просто абстрактное соглашение, а план мероприятий, подкрепленный деньгами», – добавил он.

Смертность на автомобильных дорогах области в 2 раза больше: «У нас 6–7 лет назад было порядка 2 тыс. человек, погибших на дорогах, в этом году эта цифра должна быть на уровне 750–800 человек», – сказал А. Воробьев. Он отметил, что для этого в регионе разводят транспортные потоки, ремонтируют дороги, устанавливают освещение, камеры видеофиксации, лежачих полицейских. «Этот комплекс мер позволяет людям передвигаться с большей безопасностью и комфортом», – добавил он.''');
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/news_paper.svg",
                              width: 20,
                              height: 19,
                            ),
                            SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: w - 70,
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Расписание за 10 декабря 2020 года',
                                    style: TextStyle(fontFamily: "Root",fontSize: 18, color: Color(0xff15304D), fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: w - 70,
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Опубликованно расписание маршрутов в условиях «2-ой волны» COVID-19',
                                    style: TextStyle(fontFamily: "Root",fontSize: 15, color: Color(0xff15304D).withOpacity(0.5)),
                                  ),
                                ),
                                Container(
                                  width: w - 70,
                                  margin: EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    'вчера, в 13:40',
                                    style: TextStyle(fontFamily: "Root",fontSize: 12, color: Color(0xff15304D).withOpacity(0.3)),
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: Color(0xffDEE1E6),
                      thickness: 1.2,
                    ),
                    GestureDetector(
                      onTap: (){
                        _onOpenMore(context, 'Смертность на железной дороге в Московской области снижается на 10%', '''Губернатор Московской области Андрей Воробьев в рамках «Транспортной недели – 2020» отметил, что смертность на железной дороге в Московской области снижается на 10% в год.
                        
«Снижение смертности на дорогах – это приоритет транспортной политики. И на железной дороге у нас есть задача, чтобы с 450 человек в год мы стремились к нулю. У нас есть не просто абстрактное соглашение, а план мероприятий, подкрепленный деньгами», – добавил он.

Смертность на автомобильных дорогах области в 2 раза больше: «У нас 6–7 лет назад было порядка 2 тыс. человек, погибших на дорогах, в этом году эта цифра должна быть на уровне 750–800 человек», – сказал А. Воробьев. Он отметил, что для этого в регионе разводят транспортные потоки, ремонтируют дороги, устанавливают освещение, камеры видеофиксации, лежачих полицейских. «Этот комплекс мер позволяет людям передвигаться с большей безопасностью и комфортом», – добавил он.''');
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/news_paper.svg",
                              width: 20,
                              height: 19,
                            ),
                            SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: w - 70,
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'РЖД запускает 300 поездов «Сапсан» в Казахстаан',
                                    style: TextStyle(fontFamily: "Root",fontSize: 18, color: Color(0xff15304D), fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: w - 70,
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Новые скоростные поезда будут доступны для пассажирских перевозок в Алматы',
                                    style: TextStyle(fontFamily: "Root",fontSize: 15, color: Color(0xff15304D).withOpacity(0.5)),
                                  ),
                                ),
                                Container(
                                  width: w - 70,
                                  margin: EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    'вчера, в 13:40',
                                    style: TextStyle(fontFamily: "Root",fontSize: 12, color: Color(0xff15304D).withOpacity(0.3)),
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: Color(0xffDEE1E6),
                      thickness: 1.2,
                    ),
                    GestureDetector(
                      onTap: (){
                        _onOpenMore(context, 'Смертность на железной дороге в Московской области снижается на 10%', '''Губернатор Московской области Андрей Воробьев в рамках «Транспортной недели – 2020» отметил, что смертность на железной дороге в Московской области снижается на 10% в год.
                        
«Снижение смертности на дорогах – это приоритет транспортной политики. И на железной дороге у нас есть задача, чтобы с 450 человек в год мы стремились к нулю. У нас есть не просто абстрактное соглашение, а план мероприятий, подкрепленный деньгами», – добавил он.

Смертность на автомобильных дорогах области в 2 раза больше: «У нас 6–7 лет назад было порядка 2 тыс. человек, погибших на дорогах, в этом году эта цифра должна быть на уровне 750–800 человек», – сказал А. Воробьев. Он отметил, что для этого в регионе разводят транспортные потоки, ремонтируют дороги, устанавливают освещение, камеры видеофиксации, лежачих полицейских. «Этот комплекс мер позволяет людям передвигаться с большей безопасностью и комфортом», – добавил он.''');
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/news_paper.svg",
                              width: 20,
                              height: 19,
                            ),
                            SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: w - 70,
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'ВКО и ЗКО закрыты для любых пассажирских перевозок',
                                    style: TextStyle(fontFamily: "Root",fontSize: 18, color: Color(0xff15304D), fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: w - 70,
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Постановление КТЖ вступит в силу  с 5 декабря 2020 года',
                                    style: TextStyle(fontFamily: "Root",fontSize: 15, color: Color(0xff15304D).withOpacity(0.5)),
                                  ),
                                ),
                                Container(
                                  width: w - 70,
                                  margin: EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    'вчера, в 13:40',
                                    style: TextStyle(fontFamily: "Root",fontSize: 12, color: Color(0xff15304D).withOpacity(0.3)),
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: Color(0xffDEE1E6),
                      thickness: 1.2,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/news_paper.svg",
                            width: 20,
                            height: 19,
                          ),
                          SizedBox(width: 8,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: w - 70,
                                margin: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Как защитить себя во время пандемии? 10 лучших советов.',
                                  style: TextStyle(fontFamily: "Root",fontSize: 18, color: Color(0xff15304D), fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: w - 70,
                                margin: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Наши специалисты, расскажут как обезопасить себя в это непростое время.',
                                  style: TextStyle(fontFamily: "Root",fontSize: 15, color: Color(0xff15304D).withOpacity(0.5)),
                                ),
                              ),
                              Container(
                                width: w - 70,
                                margin: EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'вчера, в 13:40',
                                  style: TextStyle(fontFamily: "Root",fontSize: 12, color: Color(0xff15304D).withOpacity(0.3)),
                                ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _onOpenMore(BuildContext context, String title, String text) {
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
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: MoreArticleWidget(title: title, articleText: text,),
        );
      },
    );
  }

}

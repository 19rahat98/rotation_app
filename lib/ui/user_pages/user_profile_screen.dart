import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/ui/widgets/emptyPage.dart';
import 'package:rotation_app/ui/login_pages/login_page.dart';
import 'package:rotation_app/logic_block/models/user_model.dart';
import 'package:rotation_app/ui/user_pages/personal_data_screen.dart';
import 'package:rotation_app/ui/user_pages/user_documents_screen.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/ui/user_pages/notifications_list_screen.dart';
import 'package:rotation_app/ui/support_pages/more_article_info_widget.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    LoginProvider lp = Provider.of<LoginProvider>(context, listen: false);
    lp.getEmployeeData();
    lp.getEmployeePhoneNumber();
    return Scaffold(
      backgroundColor: Color(0xffF3F6FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Мой профиль',
          style: TextStyle(
              fontFamily: "Root",
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2D4461),
      ),
      body: FutureBuilder<Employee>(
          future: lp.getEmployeeData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.hasError)
              return Center(
                  child: emptyPage(Icons.error_outline, 'Something is wrong'));
            else if (snapshot.data != null) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      Container(
                        width: w,
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        padding: EdgeInsets.only(top: 16, bottom: 15, left: 5),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset:
                                    Offset(0, 4), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text(
                                  'Odyssey ID'.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 13,
                                    letterSpacing: 4,
                                    color: Color(0xffC7D0DB),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 18),
                                child: VerticalDivider(
                                  indent: 0.0,
                                  endIndent: 0,
                                  width: 0,
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: lp.employee != null
                                          ? Text(
                                              lp.employee.firstName +
                                                  " " +
                                                  lp.employee.lastName +
                                                  " " +
                                                  lp.employee.patronymic,
                                              style: TextStyle(
                                                  fontFamily: "Root",
                                                  fontSize: 20,
                                                  color: Color(0xff1B344F),
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              'Баталгазиев Руслан Владимирович',
                                              style: TextStyle(
                                                  fontFamily: "Root",
                                                  fontSize: 20,
                                                  color: Color(0xff1B344F),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: w * 0.7,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: w * 0.7,
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text(
                                                  '№ табеля',
                                                  style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff748595)
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                width: w * 0.3,
                                              ),
                                              Container(
                                                child: lp.employee != null
                                                    ? Text(
                                                        '№ ' +
                                                            lp.employee
                                                                .docNumber,
                                                        style: TextStyle(
                                                            fontFamily: "Root",
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xff1B344F),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    : Text(
                                                        '№00011',
                                                        style: TextStyle(
                                                            fontFamily: "Root",
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xff1B344F),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                width: w * 0.4,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text(
                                                  'Компания',
                                                  style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff748595)
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                width: w * 0.3,
                                              ),
                                              Container(
                                                child: Text(
                                                  lp.employee.orgName != null
                                                      ? lp.employee.orgName
                                                      : 'ТОО',
                                                  style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff1B344F),
                                                  ),
                                                ),
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                width: w * 0.4,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text(
                                                  'Должность',
                                                  style: TextStyle(
                                                    fontFamily: "Root",
                                                    fontSize: 14,
                                                    color: Color(0xff748595)
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                                width: w * 0.3,
                                              ),
                                              Container(
                                                child: lp.employee != null
                                                    ? Text(
                                                        lp.employee.position,
                                                        style: TextStyle(
                                                          fontFamily: "Root",
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff1B344F),
                                                        ),
                                                      )
                                                    : Text(
                                                        'Старший бригадир',
                                                        style: TextStyle(
                                                          fontFamily: "Root",
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff1B344F),
                                                        ),
                                                      ),
                                                width: w * 0.4,
                                              ),
                                            ],
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
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonalDataScreen()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 24),
                          width: w,
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/Profile.svg",
                                width: 24,
                                height: 24,
                                color: AppTheme.mainColor,
                              ),
                              Container(
                                width: w - 100,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Личные данные',
                                  style: TextStyle(
                                      fontFamily: "Root",
                                      fontSize: 17,
                                      color: Color(0xff1B344F),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xffA2A9B3),
                                size: 14,
                              ),
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
                        onTap: () {
                          lp.getEmployeePhoneNumber().then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDocumentsScreen(
                                        currentIndex: 3,
                                      )),
                            );
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 24),
                          width: w,
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/Docs.svg",
                                width: 24,
                                height: 24,
                                color: AppTheme.mainColor,
                              ),
                              Container(
                                width: w - 100,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Документы',
                                  style: TextStyle(
                                      fontFamily: "Root",
                                      fontSize: 17,
                                      color: Color(0xff1B344F),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xffA2A9B3),
                                size: 14,
                              ),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NotificationsListScreen()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 24),
                          width: w,
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/Notify.svg",
                                width: 24,
                                height: 24,
                                color: AppTheme.mainColor,
                              ),
                              Container(
                                width: w - 100,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Уведомления',
                                  style: TextStyle(
                                      fontFamily: "Root",
                                      fontSize: 17,
                                      color: Color(0xff1B344F),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xffA2A9B3),
                                size: 14,
                              ),
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
                        onTap: () {
                          _onOpenMore(context, 'Пользовательское соглашение',
                              '''К основным стандартам можно отнести: стандарты чистоты (чистота зала, рабочих зон персонала, входной группы и т.д.), стандарты внешнего вида (форма персонала, обувь, прически, украшения, маникюр, макияж и т.п.), стандарты обслуживания гостей (сценарий обслуживание, конфликтные ситуации, комплименты и лояльность, встреча гостей с детьми, продажи, работа с возражениями, обратная связь с гостем и т.д.), стандарты подачи блюд и напитков (правила выноса блюд и напитков, комплиментов и угощений, время подачи), стандарты сервировки (до прихода гостя, во время его пребывания, после прощания с гостям, в перерывах между подачей блюд и т.д.)

Несмотря на то, что стандарты работы заведения, казалось бы, первостепенная вещь в ресторане, далеко не все украинские рестораторы их соблюдают.

Стандартизация сервиса и конкурентное преимущество заведения — тесно связанные вещи. Для начала нужно получить обратную связь от клиентов, чтобы понять, что и как стандартизировать.''');
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 24),
                          width: w,
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/Rules.svg",
                                width: 24,
                                height: 24,
                                color: AppTheme.mainColor,
                              ),
                              Container(
                                width: w - 100,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Пользовательское соглашение',
                                  style: TextStyle(
                                      fontFamily: "Root",
                                      fontSize: 17,
                                      color: Color(0xff1B344F),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xffA2A9B3),
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: w,
                        height: 52,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            print(await lp.getEmployeeToken());
                            final _result = await lp.deleteEmployeeData();
                            if (_result) {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage()));
                            }
                          },
                          child: Center(
                            child: Text(
                              'Выйти из приложения',
                              style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 17,
                                  color: Color(0xff748595),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  void _onOpenMore(BuildContext context, String title, String text) {
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
          child: MoreArticleWidget(
            title: title,
            articleText: text,
          ),
        );
      },
    );
  }
}

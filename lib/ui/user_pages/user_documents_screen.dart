import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rotation_app/ui/user_pages/residence_permit_widget.dart';


import 'more_about_passport_widget.dart';
import 'package:rotation_app/ui/nav_bar/app.dart';
import 'package:rotation_app/ui/widgets/emptyPage.dart';
import 'package:rotation_app/ui/user_pages/empty_data_widget.dart';
import 'package:rotation_app/logic_block/models/user_documents.dart';
import 'package:rotation_app/ui/user_pages/work_permission_widget.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/ui/user_pages/more_about_document_widget.dart';


class UserDocumentsScreen extends StatefulWidget {
  final int currentIndex;

  const UserDocumentsScreen({Key key, this.currentIndex}) : super(key: key);
  @override
  _UserDocumentsScreenState createState() => _UserDocumentsScreenState();
}

class _UserDocumentsScreenState extends State<UserDocumentsScreen> {

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    LoginProvider lp = Provider.of<LoginProvider>(context, listen: false);
    lp.getEmployeeData();
    return FutureBuilder<List<Documents>>(
      future: lp.getEmployeeDocuments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.hasError)
          return Center(
              child: emptyPage(Icons.error_outline, 'Something is wrong'));
        else if (snapshot.data != null) {
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
                'Документы',
                style: TextStyle(fontFamily: "Root",
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Color(0xff2D4461),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Документы',
                        style: TextStyle(fontFamily: "Root",
                          fontSize: 24,
                          color: Color(0xff1B344F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if(snapshot.data[index].type == "id-card"){
                          return Container(
                            width: w,
                            margin: EdgeInsets.only(top: 16),
                            padding:
                            EdgeInsets.only(left: 16, right: 16, top: 22, bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: Offset(0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () =>
                                  _onOpenMore(context, MoreAboutDocumentWidget(userDocument: snapshot.data[index],)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          'Удостоверение личности',
                                          style: TextStyle(fontFamily: "Root",
                                            fontSize: 19,
                                            color: Color(0xff1B344F),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xff1262CB),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.3,
                                        child: Text(
                                          '№',
                                          style: TextStyle(fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff748595).withOpacity(
                                                  0.5)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.5,
                                        child: Text(
                                          'Срок до',
                                          style: TextStyle(fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff748595).withOpacity(
                                                  0.5)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.3,
                                        child: Text(
                                          snapshot.data[index].number != null ? snapshot.data[index].number : '0000000',
                                          style: TextStyle(fontFamily: "Root",
                                            fontSize: 14,
                                            color: Color(0xff15304D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.5,
                                        child: Text(
                                          '${DateFormat.yMd('ru').format(DateTime.parse(snapshot.data[index].issueDate)).toString()} - ${DateFormat.yMd('ru').format(DateTime.parse(snapshot.data[index].expireDate)).toString()}, ${snapshot.data[index].issueBy}',
                                          style: TextStyle(fontFamily: "Root",
                                            fontSize: 14,
                                            color: Color(0xff15304D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        else if(snapshot.data[index].type == "passport"){
                          return Container(
                            width: w,
                            margin: EdgeInsets.only(top: 16),
                            padding:
                            EdgeInsets.only(left: 16, right: 16, top: 22, bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: Offset(0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () => _onOpenMore(context, MoreAboutPassport(userDocument: snapshot.data[index],)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          'Паспорт',
                                          style: TextStyle(fontFamily: "Root",
                                            fontSize: 19,
                                            color: Color(0xff1B344F),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xff1262CB),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.3,
                                        child: Text(
                                          '№',
                                          style: TextStyle(fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff748595).withOpacity(
                                                  0.5)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.5,
                                        child: Text(
                                          'Срок до',
                                          style: TextStyle(fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff748595).withOpacity(
                                                  0.5)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.3,
                                        child: Text(
                                          snapshot.data[index].number != null ? snapshot.data[index].number : '0000000',
                                          style: TextStyle(fontFamily: "Root",
                                            fontSize: 14,
                                            color: Color(0xff15304D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.5,
                                        child: Text(
                                          '${DateFormat.yMd('ru').format(DateTime.parse(snapshot.data[index].issueDate)).toString()} - ${DateFormat.yMd('ru').format(DateTime.parse(snapshot.data[index].expireDate)).toString()}, ${snapshot.data[index].issueBy}',
                                          style: TextStyle(fontFamily: "Root",
                                            fontSize: 14,
                                            color: Color(0xff15304D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        else if (snapshot.data[index].type == "foreign") {
                          return Container(
                            width: w,
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 22, bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset:
                                  Offset(0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () => _onOpenMore(context, WorkPermission(userDocument: snapshot.data[index],)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Разрешение на работу',
                                          style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 19,
                                            color: Color(0xff1B344F),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xff1262CB),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.3,
                                        child: Text(
                                          '№',
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff748595)
                                                  .withOpacity(0.5)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.5,
                                        child: Text(
                                          'Срок до',
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff748595)
                                                  .withOpacity(0.5)),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.3,
                                        child: Text(
                                          snapshot.data[index].number != null ? snapshot.data[index].number : '0000000',
                                          style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 14,
                                            color: Color(0xff15304D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.5,
                                        child: Text(
                                          '${DateFormat.yMd('ru').format(DateTime.parse(snapshot.data[index].issueDate)).toString()} - ${DateFormat.yMd('ru').format(DateTime.parse(snapshot.data[index].expireDate)).toString()}',
                                          style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 14,
                                            color: Color(0xff15304D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        else if (snapshot.data[index].type == "residence") {
                          return Container(
                            width: w,
                            margin: EdgeInsets.only(top: 16),
                            padding:
                            EdgeInsets.only(left: 16, right: 16, top: 22, bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: Offset(0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () => _onOpenMore(context, MoreAboutResidencePermitWidget(userDocument: snapshot.data[index],)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Вид на жительство',
                                          style: TextStyle(fontFamily: "Root",
                                            fontSize: 19,
                                            color: Color(0xff1B344F),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xff1262CB),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.3,
                                        child: Text(
                                          '№',
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff748595)
                                                  .withOpacity(0.5)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.5,
                                        child: Text(
                                          'Срок до',
                                          style: TextStyle(
                                              fontFamily: "Root",
                                              fontSize: 14,
                                              color: Color(0xff748595)
                                                  .withOpacity(0.5)),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.3,
                                        child: Text(
                                          snapshot.data[index].number != null ? snapshot.data[index].number : '0000000',
                                          style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 14,
                                            color: Color(0xff15304D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: w * 0.5,
                                        child: Text(
                                          '${DateFormat.yMd('ru').format(DateTime.parse(snapshot.data[index].issueDate)).toString()} - ${DateFormat.yMd('ru').format(DateTime.parse(snapshot.data[index].expireDate)).toString()}',
                                          style: TextStyle(
                                            fontFamily: "Root",
                                            fontSize: 14,
                                            color: Color(0xff15304D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  /*Container(
                                    margin: EdgeInsets.only(top: 13),
                                    width: w * 0.8,
                                    child: Text(
                                      'Вы еще не указали данные вашего паспорта. Нажмите, чтобы добавить.',
                                      style: TextStyle(fontFamily: "Root",
                                          fontSize: 14,
                                          color: Color(0xff748595).withOpacity(0.5), fontWeight: FontWeight.w500),
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                          );
                        }
                        else
                            return Container();
                        },
                    ),
                      ///TODO get user documents!!!



                  ],
                ),
              ),
            ),
          );
        }
        else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  void _onOpenMore(BuildContext context, Widget widgetName) {
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
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: widgetName,
        );
      },
    );
  }
}

import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotation_app/logic_block/models/articles_model.dart';

import 'package:rotation_app/logic_block/providers/articles_provider.dart';
import 'package:rotation_app/ui/support_pages/more_article_info_widget.dart';
import 'package:rotation_app/ui/widgets/emptyPage.dart';

class PressServiceScreen extends StatefulWidget {
  @override
  _PressServiceScreenState createState() => _PressServiceScreenState();
}

class _PressServiceScreenState extends State<PressServiceScreen> {
  final TextEditingController _searchQuestionTextController =
      TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _searchQuestionTextController.addListener(() {});
    super.initState();
  }

  Widget afterSearchUI() {
    final ArticlesProvider ap =
        Provider.of<ArticlesProvider>(context, listen: false);
    double w = MediaQuery.of(context).size.width;
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: ap.filteredData.map((item) {
        if (ap.filteredData.isNotEmpty) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    ap.aboutMoreArticle(articleId: item.id).then((value) {
                      print('+++++++');
                      print(value.title);
                      print(value.content);
                    });
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
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: w - 70,
                              margin: EdgeInsets.only(bottom: 8),
                              child: Text(
                                item.title,
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 18,
                                    color: Color(0xff15304D),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: w - 70,
                              margin: EdgeInsets.only(bottom: 8),
                              child: Text(
                                item.shortContent,
                                style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 15,
                                  color: Color(0xff15304D).withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              width: w - 70,
                              margin: EdgeInsets.only(bottom: 12),
                              child: Text(
                                'вчера, в 13:40',
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 12,
                                    color: Color(0xff15304D).withOpacity(0.3)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              item.id == ap.filteredData.last.id
                  ? Container()
                  : Divider(
                      height: 0,
                      color: Color(0xffDEE1E6),
                      thickness: 1.2,
                    ),
            ],
          );
        } else {
          return Container();
        }
      }).toList(),
    );
  }

  Widget beforeSearchUI() {
    final ArticlesProvider ap =
        Provider.of<ArticlesProvider>(context, listen: false);
    double w = MediaQuery.of(context).size.width;
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: ap.articlesList.map((item) {
        if (ap.articlesList.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {
                ap.aboutMoreArticle(articleId: item.id).then((value) {
                  _onOpenMore(context, content: value.content, title: value.title);
                  print('+++++++');
                  print(value.title);
                  print(value.content);
                });
                print(ap.article.title);
              },
              child: Column(
                children: [
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
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: w - 70,
                              margin: EdgeInsets.only(bottom: 8),
                              child: Text(
                                item.title,
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 18,
                                    color: Color(0xff15304D),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: w - 70,
                              margin: EdgeInsets.only(bottom: 8),
                              child: Text(
                                item.shortContent,
                                style: TextStyle(
                                  fontFamily: "Root",
                                  fontSize: 15,
                                  color: Color(0xff15304D).withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              width: w - 70,
                              margin: EdgeInsets.only(bottom: 12),
                              child: Text(
                                'вчера, в 13:40',
                                style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 12,
                                    color: Color(0xff15304D).withOpacity(0.3)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  item.id == ap.articlesList.last.id
                      ? Container()
                      : Divider(
                          height: 0,
                          color: Color(0xffDEE1E6),
                          thickness: 1.2,
                        ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    ArticlesProvider ap = Provider.of<ArticlesProvider>(context, listen: false);
    ap.getArticles();
    return FutureBuilder<List<Articles>>(
        future: ap.getArticles(),
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
                  'Пресс-служба',
                  style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontFamily: "Root",
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
                              margin: EdgeInsets.only(right: 8, left: 6),
                              child: Image.asset(
                                "assets/images/search.png",
                                width: 22,
                                height: 22,
                              ),
                            ),
                            Expanded(
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  autofocus: false,
                                  controller: _searchQuestionTextController,
                                  style: TextStyle(
                                    fontFamily: "Root",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff748595),
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    hintText: "Что вас интересует?",
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
                                  onChanged: (String value) {
                                    setState(() {
                                      ap.afterSearch(value);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ap.filteredData.isEmpty
                          ? beforeSearchUI()
                          : afterSearchUI(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  void _onOpenMore(BuildContext context, {String content, String title}) {
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
              minHeight: h * 0.80,
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
              articleText: content,
            ),
          );
        });
  }
  @override
  void dispose() {
    ArticlesProvider().filteredData = [];
    ArticlesProvider().dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

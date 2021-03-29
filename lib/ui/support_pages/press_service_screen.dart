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
  final TextEditingController _searchQuestionTextController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String _query;

  @override
  void initState() {
    _searchQuestionTextController.addListener(() {});
    new Stream.periodic(const Duration(seconds: 5), (v) => v)
        .listen((count) {
      setState(() {
        _onRefresh();
      });
    });
    super.initState();
  }

  Future<void> _onRefresh() async {
    setState(() {
      print('asd');
      Provider.of<ArticlesProvider>(context, listen: false).getArticles();
    });
  }

/*  _updateData() {
    if (mounted) {
      new Stream.periodic(const Duration(seconds: 1), (v) => v).listen((count) {
        _onRefresh();
      });
    }
    if (!mounted) return;
  }*/

  Widget afterSearchUI() {
    final ArticlesProvider ap =
        Provider.of<ArticlesProvider>(context, listen: false);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return ap.filteredData.isNotEmpty && ap.filteredData != null ? ListView(
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
                                item.publishedOn,
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
    ) :
    Container(
      width: w,
      height: h / 2,
      child: Center(
        child: Text('Нет результатов',style: TextStyle(fontFamily: "Root",fontSize: 17, color: Color(0xff15304D), fontWeight: FontWeight.w500), ),
      ),
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
                  if(value != null){
                    print(value.title);
                    _onOpenMore(context,
                        content: value.content, title: value.title, publishDate: value.publishedOn);
                  }
                });
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
                                item.publishedOn,
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
    return FutureBuilder<List<Articles>>(
        future: ap.getArticles(),
        builder: (context, snapshot) {
          print(snapshot.data);
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
                  'Новости',
                  style: TextStyle(
                      fontFamily: "Root",
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Color(0xff2D4461),
              ),
              body: RefreshIndicator(
                onRefresh: _onRefresh,
                displacement: 40.0,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Новости',
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 24,
                                color: Color(0xff1B344F),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          padding: EdgeInsets.only(left: 8),
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
                                suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
                                suffixIcon: _query != null && _query.isNotEmpty
                                    ? InkWell(
                                      onTap: (){
                                        setState(() {
                                          _query = null;
                                          _searchQuestionTextController.clear();
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: SvgPicture.asset(
                                  'assets/svg/Close.svg',
                                  color: Color(0xff1262CB),
                                ),
                                      ),
                                    ) : null,
                                prefixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
                                prefixIcon: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: Image.asset(
                                    "assets/images/search.png",
                                    width: 22,
                                    height: 22,
                                  ),
                                ),
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
                                  _query = value;
                                  ap.afterSearch(value);
                                });
                              },
                            ),
                          ),
                        ),
                        _query == null ? beforeSearchUI() : afterSearchUI(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  void _onOpenMore(BuildContext context, {String content, String title, String publishDate}) {
    print(publishDate);
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
              informationDate: publishDate,
            ),
          );
        });
  }
  @override
  void dispose() {
    ArticlesProvider().dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MoreArticleWidget extends StatelessWidget {
  final String title;
  final String articleText;
  final String informationDate;

  const MoreArticleWidget(
      {Key key, this.title, this.articleText, this.informationDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
        child: informationDate != null
            ? Column(
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          informationDate != null ? informationDate : 'вчера, в 13:40*',
                          style: TextStyle(
                              fontFamily: "Root",
                              fontSize: 12,
                              color: Color(0xff1B344F).withOpacity(0.3),
                              fontWeight: FontWeight.w400),
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
                  Container(
                    width: w * 0.9,
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontFamily: "Root",
                          fontSize: 24,
                          color: Color(0xff15304D),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: w * 0.9,
                    margin: EdgeInsets.only(top: 30),
                    child: Html(
                      data: articleText,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w * 0.8,
                          child: Text(
                            title,
                            style: TextStyle(
                                fontFamily: "Root",
                                fontSize: 24,
                                color: Color(0xff15304D),
                                fontWeight: FontWeight.bold),
                          ),
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
                  Container(
                    width: w * 0.9,
                    margin: EdgeInsets.only(top: 24),
                    child: Html(
                      data: articleText,
                      defaultTextStyle: TextStyle(
                        height: 1.65,
                        fontFamily: "Root",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff748595),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

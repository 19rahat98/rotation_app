import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rotation_app/ui/widgets/emptyPage.dart';
import 'package:rotation_app/ui/support_pages/more_info_widget.dart';
import 'package:rotation_app/logic_block/models/questions_model.dart';
import 'package:rotation_app/logic_block/providers/question_provider.dart';

class QuestionsAnswers extends StatefulWidget {
  @override
  _QuestionsAnswersState createState() => _QuestionsAnswersState();
}

class _QuestionsAnswersState extends State<QuestionsAnswers> {
  final TextEditingController _searchQuestionTextController =
      TextEditingController();
  var formKey = GlobalKey<FormState>();
  StreamController<int> _controller = new BehaviorSubject();
  int _chosenId;

  @override
  void initState() {
    _searchQuestionTextController.addListener(() {});
    super.initState();
  }

  Widget afterSearchUI() {
    final QuestionProvider qp = Provider.of<QuestionProvider>(context, listen: false);
    double w = MediaQuery.of(context).size.width;
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: qp.filteredData.map((item) {
        if(qp.filteredData.isNotEmpty){
          return Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {
                print(item.id);
                if (item.id == _chosenId) {
                  _chosenId = null;
                  _controller.add(null);
                } else {
                  _chosenId = item.id;
                  print(item.question);
                  _controller.add(item.id);
                }
              },
              child: MoreInfoWidget(
                stream: _controller.stream,
                title: item.question,
                moreText: item.answer,
                questionId: item.id,
              ),
            ),
          );
        }
        else{
          return Container();
        }
      }).toList(),
    );
  }

  Widget beforeSearchUI() {
    final QuestionProvider qp = Provider.of<QuestionProvider>(context, listen: false);
    double w = MediaQuery.of(context).size.width;
      return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: qp.data.map((item) {
          if(qp.data.isNotEmpty){
            return Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  print(item.id);
                  if (item.id == _chosenId) {
                    _chosenId = null;
                    _controller.add(null);
                  } else {
                    _chosenId = item.id;
                    print(item.question);
                    _controller.add(item.id);
                  }
                },
                child: MoreInfoWidget(
                  stream: _controller.stream,
                  title: item.question,
                  moreText: item.answer,
                  questionId: item.id,
                ),
              ),
            );
          }
          else{
            return Container();
          }
        }).toList(),
      );
    }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    QuestionProvider qp = Provider.of<QuestionProvider>(context, listen: false);
    qp.getQuestions();
    return FutureBuilder<List<Questions>>(
        future: qp.getQuestions(),
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
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: 20,
                    )),
                automaticallyImplyLeading: false,
                title: Text(
                  'Вопросы и ответы',
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
                          'Вопросы и ответы',
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                      qp.afterSearch(value);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      qp.filteredData.isEmpty ? beforeSearchUI() : afterSearchUI()
                    ],
                  ),
                ),
              ),
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  void dispose() {
    _searchQuestionTextController.dispose();
    _controller.close();
    QuestionProvider().dispose();
    super.dispose();
  }
}

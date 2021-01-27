import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rotation_app/ui/support_pages/more_info_widget.dart';
class QuestionsAnswers extends StatefulWidget {
  @override
  _QuestionsAnswersState createState() => _QuestionsAnswersState();
}

class _QuestionsAnswersState extends State<QuestionsAnswers> {

  final TextEditingController _searchQuestionTextController = TextEditingController();
  StreamController<bool> _buttonController = new BehaviorSubject();
  bool _isChoose = false;


  @override
  void initState() {
    _searchQuestionTextController.addListener(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
                  'Вопросы и ответы',
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
                        "assets/svg/Search.svg",
                        width: 24,
                        height: 24,
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
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4,),
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    print(_isChoose);
                    if (_isChoose) {
                      _isChoose = false;
                      _buttonController.add(false);
                    } else {
                      _isChoose = true;
                      _buttonController.add(true);

                    }
                  },
                  child: MoreInfoWidget(
                    stream: _buttonController.stream,
                    title: "Могу ли я сейчас оформить  ЖД-билеты самостоятельно?",
                    moreText: "Возможность самостоятельно оформлять  ЖД билеты и авиабилеты, появится в скором обновлении приложения Odyssey Rotation.  Следите за новостями!",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    print(_isChoose);
                    if (_isChoose) {
                      _buttonController.add(false);
                      _isChoose = false;
                    } else {
                      _buttonController.add(true);
                      _isChoose = true;
                    }
                  },
                  child: MoreInfoWidget(
                    stream: _buttonController.stream,
                    title: "Как мне узнать куплены ли мне билеты на следующую вахту?",
                    moreText: "Возможность самостоятельно оформлять  ЖД билеты и авиабилеты, появится в скором обновлении приложения Odyssey Rotation.  Следите за новостями!",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    print(_isChoose);
                    if (_isChoose) {
                      _buttonController.add(false);
                      _isChoose = false;
                    } else {
                      _buttonController.add(true);
                      _isChoose = true;
                    }
                  },
                  child: MoreInfoWidget(
                    stream: _buttonController.stream,
                    title: "Я не могу поехать по купленым билетам. Что делать?",
                    moreText: "Возможность самостоятельно оформлять  ЖД билеты и авиабилеты, появится в скором обновлении приложения Odyssey Rotation.  Следите за новостями!",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    print(_isChoose);
                    if (_isChoose) {
                      _buttonController.add(false);
                      _isChoose = false;
                    } else {
                      _buttonController.add(true);
                      _isChoose = true;
                    }
                  },
                  child: MoreInfoWidget(
                    stream: _buttonController.stream,
                    title: "Был назначен овертайм без  моего согласия. Как отменить?",
                    moreText: "Возможность самостоятельно оформлять  ЖД билеты и авиабилеты, появится в скором обновлении приложения Odyssey Rotation.  Следите за новостями!",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    print(_isChoose);
                    if (_isChoose) {
                      _buttonController.add(false);
                      _isChoose = false;
                    } else {
                      _buttonController.add(true);
                      _isChoose = true;
                    }
                  },
                  child: MoreInfoWidget(
                    stream: _buttonController.stream,
                    title: "Был назначен овертайм без  моего согласия. Как отменить?",
                    moreText: "Возможность самостоятельно оформлять  ЖД билеты и авиабилеты, появится в скором обновлении приложения Odyssey Rotation.  Следите за новостями!",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchQuestionTextController.dispose();
    super.dispose();
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:rotation_app/ui/login_pages/login_page.dart';
import 'package:rotation_app/logic_block/providers/user_login_provider.dart';

class NoAccountBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserLoginProvider auth = Provider.of<UserLoginProvider>(context, listen: false);
    return CupertinoActionSheet(
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Сотрудник не найден',
            style: TextStyle(fontFamily: "Root",
                fontSize: 20,
                color: Color(0xff1B344F),
                fontWeight: FontWeight.bold),
          ),
        ),
        message: Container(
          //margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            auth.userIIN == null ? 'Сотрудник не найден. Внимательно проверьте ваши данные и попробуйте снова.' : 'Сотрудник с ИИН: ${auth.userIIN} не найден. Внимательно проверьте ваши данные и попробуйте снова.',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Root",
                fontSize: 15,
                color: Color(0xff1B3652).withOpacity(0.5),
                fontWeight: FontWeight.w400),
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Обратиться в поддержку',
                style: TextStyle(fontFamily: "Root",
                    fontSize: 17,
                    color: Color(0xff1262CB),
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              return showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => SocialMediaBottomSheet());
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Попробовать снова',
            style: TextStyle(fontFamily: "Root",
                fontSize: 17,
                color: Color(0xff1262CB),
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}

class SuccessAddedNumberBottomSheet extends StatelessWidget {
  final String phoneNumber;

  const SuccessAddedNumberBottomSheet({Key key, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Номер успешно добавлен',
            style: TextStyle(fontFamily: "Root",
                fontSize: 20,
                color: Color(0xff1B344F),
                fontWeight: FontWeight.bold),
          ),
        ),
        message: Container(
          //margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            phoneNumber == null ? 'По указаному ИИН успешно добавлен номер телефона.  Вы сможете войти в аккаунт используя  этот номер.' : 'По указаному ИИН успешно добавлен номер телефона: +7 (${phoneNumber}.  Вы сможете войти в аккаунт используя  этот номер.',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Root",
                fontSize: 15,
                color: Color(0xff1B3652).withOpacity(0.5),
                fontWeight: FontWeight.w400),
          ),
        ),
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Перейти на страницу входа',
            style: TextStyle(fontFamily: "Root",
                fontSize: 17,
                color: Color(0xff1262CB),
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
    );
  }
}

class SendedRequestBottomSheet extends StatelessWidget {
  final String phoneNumber;

  const SendedRequestBottomSheet({Key key, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Заявка отправлена',
            style: TextStyle(fontFamily: "Root",
                fontSize: 20,
                color: Color(0xff1B344F),
                fontWeight: FontWeight.bold),
          ),
        ),
        message: Container(
          //margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            phoneNumber == null ? 'Заявка на изменение номера телефона успешно отправлена. Обработка займет до 30 минут.  После подтверждения Вы получите уведомление на Ваш телефон.' : 'Заявка на изменение номера телефона  на +7 (${phoneNumber} успешно отправлена. Обработка займет до 30 минут.  После подтверждения Вы получите уведомление на Ваш телефон..',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Root",
                fontSize: 15,
                color: Color(0xff1B3652).withOpacity(0.5),
                fontWeight: FontWeight.w400),
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Обратиться в поддержку',
                style: TextStyle(fontFamily: "Root",
                    fontSize: 17,
                    color: Color(0xff1262CB),
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              return showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => SocialMediaBottomSheet());
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Закрыть окно',
            style: TextStyle(fontFamily: "Root",
                fontSize: 17,
                color: Color(0xff1262CB),
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}

class ShowErrorBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Произошла ошибка',
            style: TextStyle(fontFamily: "Root",
                fontSize: 20,
                color: Color(0xffFF4242),
                fontWeight: FontWeight.bold),
          ),
        ),
        message: Container(
          //margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Не удалось добавить номер телефона  по указаному ИИН. Попробуйте снова  либо обратитесь в службу поддержки.' ,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Root",
                fontSize: 15,
                color: Color(0xff1B3652).withOpacity(0.5),
                fontWeight: FontWeight.w400),
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Обратиться в поддержку',
                style: TextStyle(fontFamily: "Root",
                    fontSize: 17,
                    color: Color(0xff1262CB),
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              return showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => SocialMediaBottomSheet());
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Попробовать снова',
            style: TextStyle(fontFamily: "Root",
                fontSize: 17,
                color: Color(0xff1262CB),
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}

class ShowTooManyRequestAlert extends StatelessWidget{
  var test = StringBuffer();
  @override
  Widget build(BuildContext context) {
    //UserLoginProvider auth = Provider.of<UserLoginProvider>(context, listen: true);
    return Consumer(
        builder: (context, UserLoginProvider user, _) {
          if(user.errorMessage != null){
            print(user.errorMessage);
            final splitText = user.errorMessage.split(" ", );
            if(int.parse(splitText[9]) >= 60 && int.parse(splitText[9]) < 120){
              splitText[9] = '1';
              splitText[10] = 'минуту';
            }
            else if(int.parse(splitText[9]) >= 120){
              splitText[9] = (int.parse(splitText[9])/60).toStringAsFixed(0);
              splitText[10] = 'минуты';
            }
            splitText.forEach((item){
              test.write(item + ' ');
            });
          }
          print(user.errorMessage);
          return AlertDialog(
            title: Text('Предупреждение'),
            content: user.errorMessage == null ? SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Количество запросов в минуту превысила норму.'),
                ],
              ),
            ) :  Text(test.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('ОК'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
    );
  }
}

class ShowErrorCodeAlert extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserLoginProvider user, _) {
        print(user.errorMessage);
        return AlertDialog(
          title: user.errorMessage == null ? Text('Коды не совпадают') : Text(user.errorMessage),
          /*content: user.errorMessage == null ? SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Количество запросов в минуту превысила норму.'),
              ],
            ),
          ) :  Text(user.errorMessage),*/
          actions: <Widget>[
            TextButton(
              child: Text('ОК'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class DeactivateAccountBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserLoginProvider auth = Provider.of<UserLoginProvider>(context, listen: false);
    double w = MediaQuery.of(context).size.width;
    return CupertinoActionSheet(
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Icon(
                Icons.block_outlined,
                color: Color(0xffFF4242),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Аккаунт деактивирован',
                style: TextStyle(fontFamily: "Root",
                    fontSize: 20,
                    color: Color(0xffFF4242),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        message: Container(
          width: w,
          //margin: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            'Уважаемый ${auth.userPhoneNumber}, ваш аккаунт был деактивирован вашим работодателем. Если у вас есть вопросы обратитесь в службу поддержки.',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Root",
                fontSize: 15,
                color: Color(0xff1B3652).withOpacity(0.5),
                fontWeight: FontWeight.w400),
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Обратиться в поддержку',
                style: TextStyle(fontFamily: "Root",
                    fontSize: 17,
                    color: Color(0xff1262CB),
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) =>
                      SocialMediaBottomSheet());
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Попробовать снова',
            style: TextStyle(fontFamily: "Root",
                fontSize: 17,
                color: Color(0xff1262CB),
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}

class SocialMediaBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Container(
              margin: EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/svg/phone-outgoing.png',
                    height: 30,
                    width: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Позвонить', style: TextStyle(fontFamily: "Root",fontSize: 18, color: Color(0xff2D4461), fontWeight: FontWeight.bold),),
                        SizedBox(height: 3,),
                        Text('круглосуточно, без выходных', style: TextStyle(fontFamily: "Root",fontSize: 15, color: Color(0xff2D4461).withOpacity(0.5), fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              launch("tel://+7(701)7051616");
              print('pressed');
            },
          ),
          CupertinoActionSheetAction(
            child: Container(
              margin: EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/svg/icons8-whatsapp.png',
                    height: 40,
                    width: 40,
                    excludeFromSemantics: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Написать в WhatsApp', style: TextStyle(fontFamily: "Root",fontSize: 18, color: Color(0xff2D4461), fontWeight: FontWeight.bold),),
                        SizedBox(height: 3,),
                        Text('оператор онлайн', style: TextStyle(fontFamily: "Root",fontSize: 15, color: Color(0xff2D4461).withOpacity(0.5), fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              if (Platform.isAndroid) {
                print('pressed');
                launch("https://wa.me/+77017051616/?text=");
                //return "https://wa.me/+77017051616/?text="; // new line
              } else {
                launch("https://api.whatsapp.com/send?phone=+77017051616=");
              }
            },
          ),
          CupertinoActionSheetAction(
            child: Container(
              margin: EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/telegram.svg',
                    height: 40,
                    width: 40,
                    excludeFromSemantics: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Написать в Telegram', style: TextStyle(fontFamily: "Root",fontSize: 18, color: Color(0xff2D4461), fontWeight: FontWeight.bold),),
                        SizedBox(height: 3,),
                        Text('оператор онлайн', style: TextStyle(fontFamily: "Root",fontSize: 15, color: Color(0xff2D4461).withOpacity(0.5), fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              print('pressed');
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Попробовать снова',
            style: TextStyle(fontFamily: "Root",
                fontSize: 17,
                color: Color(0xff1262CB),
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}

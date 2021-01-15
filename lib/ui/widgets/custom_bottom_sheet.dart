import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotation_app/ui/home_pages/home_page.dart';

class NoAccountBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Сотрудник не найден',
            style: TextStyle(
                fontSize: 20,
                color: Color(0xff1B344F),
                fontWeight: FontWeight.bold),
          ),
        ),
        message: Container(
          //margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Сотрудник с ИИН:920911300248 не найден. Внимательно проверьте ваши данные и попробуйте снова.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                color: Color(0xff1B3652).withOpacity(0.5),
                fontWeight: FontWeight.w400),
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Обратиться в поддержку',
                style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff1262CB),
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              print('pressed');
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Попробовать снова',
            style: TextStyle(
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

class DeactivateAccountBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(
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
            'Уважаемый Руслан Владимирович, ваш аккаунт был деактивирован вашим работодателем. Если у вас есть вопросы обратитесь в службу поддержки.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                color: Color(0xff1B3652).withOpacity(0.5),
                fontWeight: FontWeight.w400),
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Обратиться в поддержку',
                style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff1262CB),
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              print('pressed');
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Попробовать снова',
            style: TextStyle(
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
                  SvgPicture.asset(
                    'assets/svg/phone.svg',
                    height: 30,
                    width: 30,
                    excludeFromSemantics: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Позвонить', style: TextStyle(fontSize: 18, color: Color(0xff2D4461), fontWeight: FontWeight.bold),),
                        SizedBox(height: 3,),
                        Text('круглосуточно, без выходных', style: TextStyle(fontSize: 15, color: Color(0xff2D4461).withOpacity(0.5), fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
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
                  SvgPicture.asset(
                    'assets/svg/whatsapp.svg',
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
                        Text('Написать в WhatsApp', style: TextStyle(fontSize: 18, color: Color(0xff2D4461), fontWeight: FontWeight.bold),),
                        SizedBox(height: 3,),
                        Text('оператор онлайн', style: TextStyle(fontSize: 15, color: Color(0xff2D4461).withOpacity(0.5), fontWeight: FontWeight.w400),)
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
                        Text('Написать в Telegram', style: TextStyle(fontSize: 18, color: Color(0xff2D4461), fontWeight: FontWeight.bold),),
                        SizedBox(height: 3,),
                        Text('оператор онлайн', style: TextStyle(fontSize: 15, color: Color(0xff2D4461).withOpacity(0.5), fontWeight: FontWeight.w400),)
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
            style: TextStyle(
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

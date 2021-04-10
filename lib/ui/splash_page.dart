import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotation_app/logic_block/providers/conversation_rates_provider.dart';

import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/providers/notification_provider.dart';
import 'package:rotation_app/ui/login_pages/login_page.dart';
import 'package:rotation_app/config/app+theme.dart';
import 'package:rotation_app/ui/nav_bar/app.dart';


class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  nextPage(){
    final LoginProvider lp = Provider.of<LoginProvider>(context,listen: false);
    NotificationProvider np = Provider.of<NotificationProvider>(context, listen: false);
    //crp.getExchangeRate();
    lp.checkSignIn().then((value){
      if(value){
        np.sendFmcTokenToServer();
        lp.getUserInfo();
      }
      var page = value == true ? App() : LoginPage();
      Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => page));
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000)).then((value) => nextPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Image.asset("assets/images/logo.png", height: 100),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Odyssey',
                        style: AppTheme.splashText,),
                    Text(
                      'тм',
                      style: TextStyle(fontFamily: "Root",
                          color: Color(0xff1262CB),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Text(
                'by Professional Travel Service',
                style: TextStyle(fontFamily: "Root",
                    fontSize: 12,
                    color: Color(0xff1B344F).withOpacity(0.3),
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }
}

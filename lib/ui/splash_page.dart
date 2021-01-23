import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/ui/login_pages/login_page.dart';
import 'package:rotation_app/ui/nav_bar.dart';


class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  nextPage(){
    final LoginProvider lp = Provider.of<LoginProvider>(context,listen: false);
    final _isSingInState = lp.checkSignIn();
    _isSingInState.then((value){
      var page = value == true ? TabsPage() : LoginPage();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
    });
    //var page = lp.isSignedIn == true ? TabsPage() : LoginPage();
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
                    Text('Odyssey Rotation',
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xff1262CB),
                            fontWeight: FontWeight.bold)),
                    Text(
                      'тм',
                      style: TextStyle(
                          color: Color(0xff1262CB),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Text(
                'by Professional Travel Service',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff1B344F).withOpacity(0.3),
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }
}

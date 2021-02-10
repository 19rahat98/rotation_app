import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/ui/login_pages/login_page.dart';
import 'nav_bar/app.dart';


class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {

  nextPage(){
    final LoginProvider lp = Provider.of<LoginProvider>(context,listen: false);
    final _isSingInState = lp.checkSignIn();
    _isSingInState.then((value){
      var page = value == true ? App() : LoginPage();
      Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => page));
    });
    //var page = lp.isSignedIn == true ? TabsPage() : LoginPage();
  }

  @override
  void initState() {
    super.initState();
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }


}

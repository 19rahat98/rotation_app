import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:rotation_app/ui/splash_page.dart';
import 'package:rotation_app/logic_block/providers/login_provider.dart';
import 'package:rotation_app/logic_block/providers/question_provider.dart';
import 'package:rotation_app/logic_block/providers/articles_provider.dart';
import 'package:rotation_app/logic_block/providers/user_login_provider.dart';
import 'package:rotation_app/logic_block/providers/notification_provider.dart';
import 'package:rotation_app/logic_block/providers/conversation_rates_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.light) // Or Brightness.dark
    );
    final platform = Theme.of(context).platform;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserLoginProvider()),
        ChangeNotifierProvider<UserLoginProvider>(
          create: (context) => UserLoginProvider(),
        ),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        ChangeNotifierProvider(create: (_) => ArticlesProvider()),
        ChangeNotifierProvider(create: (_) => ConversationRatesProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: 'Odyssey',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}


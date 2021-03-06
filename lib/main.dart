import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


import 'package:rotation_app/ui/test.dart';
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
        title: 'Odyssey Rotation',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}


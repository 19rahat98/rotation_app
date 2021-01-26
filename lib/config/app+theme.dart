import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEBEBEB);
  static const Color nearlyWhite = Color(0xFFCFD5DC);
  static const Color white = Color(0xFFFFFFFF);

  static const Color mainColor = Color(0xFF1262CB);
  static const Color mainDarkColor = Color(0xFF1B344F);
  static const Color mainLightColor = Color(0xFF40BDFF);

  static const Color darkText = Color(0xFF1B344F);
  static const Color lightText = Color(0xFF748595);
  static const Color deactivatedText = Color(0xFF385780);
  static const Color darkerText = Color(0xFF17262A);

  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color iconColor = Color(0xFF2D4461);
  static const Color dangerousColor = Color(0xFFFF4242);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);

  static const String fontName = 'WorkSans';

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );

  static const TextStyle splashText = TextStyle( //Splash Page Text Style
    fontFamily: "Root",
    fontSize: 24,
    color: mainColor,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle mediumNearlyWhiteText = TextStyle( //Splash Page Text Style
    fontFamily: "Root",
    fontSize: 14,
    color: nearlyWhite,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle whiteBoldText = TextStyle( //Splash Page Text Style
    fontFamily: "Root",
    fontSize: 24,
    color: white,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle buttonText = TextStyle( //Splash Page Text Style
    fontFamily: "Root",
    fontSize: 17,
    color: white,
    fontWeight: FontWeight.w700,
  );



  static const TextStyle display1 = TextStyle( // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle( // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle( // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle( // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle( // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle( // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle( // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

}

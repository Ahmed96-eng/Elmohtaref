import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant.dart';

ThemeData lightThemeMode = ThemeData(
  // primarySwatch: Colors.teal,
  backgroundColor: mainColor,
  scaffoldBackgroundColor: mainColor,
  appBarTheme: AppBarTheme(
    // iconTheme: IconThemeData(color: Colors.teal),
    color: Color(0xff7BCFE9),
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff7BCFE9),
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    headline1: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  ),
  iconTheme: IconThemeData(size: 20),
);

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_karim/utils/theme/color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: mainColor,
    primarySwatch: Colors.purple,
    fontFamily: 'Tajawal',
    scaffoldBackgroundColor: Colors.grey.shade50,
    appBarTheme: AppBarTheme(
      backgroundColor: mainColor,
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Tajawal',
      ),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: whiteColor,
        fontSize: 38.sp,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: whiteColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: whiteColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        color: whiteColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
  static final ThemeData dartTheme = ThemeData(
    primaryColor: mainDarkColor,
    primarySwatch: Colors.purple,
    fontFamily: 'Tajawal',
    scaffoldBackgroundColor: secondDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: mainDarkColor,
      titleTextStyle: TextStyle(
        color: mainDarkColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Tajawal',
      ),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: mainDarkColor,
        fontSize: 38.sp,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: whiteColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: whiteColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        color: whiteColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

import 'package:flutter/material.dart';

class SizeConfigurationHelper {
  static late MediaQueryData mediaQueryData;
  static late double screenHeight;
  static late double screenWidth;
  static late Orientation screenOrientation;

  static void initSizeConfiguration(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenHeight = mediaQueryData.size.height;
    screenWidth = mediaQueryData.size.width;
    screenOrientation = mediaQueryData.orientation;
  }
}

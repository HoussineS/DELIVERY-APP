import 'package:flutter/material.dart';

class AppConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double
  usableHeight; // screen height without status bar & bottom padding

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    usableHeight =
        mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
  }
}

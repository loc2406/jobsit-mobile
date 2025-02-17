import 'package:flutter/cupertino.dart';

class ValueConstants{
  static double screenWidth = 0;
  static double screenHeight = 0;

  static void initScreenSize(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
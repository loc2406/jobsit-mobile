import 'package:flutter/cupertino.dart';

class ValueConstants {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static void initScreenSize(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  static double deviceWidthValue(
      {required double uiValue, double uiScreen = 414}) {
    return screenWidth * (uiValue / uiScreen);
  }

  static double deviceHeightValue(
      {required double uiValue, double uiScreen = 896}) {
    return screenHeight * (uiValue / uiScreen);
  }
}

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

  static final schedules = [
    {"id": 1, "name": "Full time"},
    {"id": 2, "name": "Part time"},
    {"id": 3, "name": "Remote"}
  ];

  static final positions = [
    {"id": 1, "name": "Front end"},
    {"id": 2, "name": "Back end"},
    {"id": 3, "name": "Full Stack"},
    {"id": 7, "name": "DevOps"}
  ];

  static final majors = [
    {"id": 1, "name": "Khoa học máy tính"},
    {"id": 2, "name": "Công nghệ phần mềm"},
    {"id": 3, "name": "Kỹ thuật máy tính"},
    {"id": 4, "name": "Trí tuệ nhân tạo"},
    {"id": 6, "name": "Hệ thống quản lý thông tin"}
  ];
}

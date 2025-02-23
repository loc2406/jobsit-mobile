import 'package:flutter/material.dart';

import 'color_constants.dart';

class WidgetConstants {
  static const inputFieldBorder = OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.main));
  static const circularProgress = CircularProgressIndicator(color: ColorConstants.main,);
  static const searchBorder = OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.main), borderRadius: BorderRadius.all(Radius.circular(10)));

  // Normal
  static const main11Style = TextStyle(color: ColorConstants.main, fontSize: 11, fontWeight: FontWeight.w500);
  static const main12Style = TextStyle(color: ColorConstants.main, fontSize: 12, fontWeight: FontWeight.w500);
  static const main13Style = TextStyle(color: ColorConstants.main, fontSize: 13, fontWeight: FontWeight.w500);

  static const black12Style = TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500);

  // Bold
  static const mainBold16Style = TextStyle(color: ColorConstants.main, fontSize: 16, fontWeight: FontWeight.w700);

  static const blackBold12Style = TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700);

  static const userNameStyle = TextStyle(color: ColorConstants.main, fontSize: 22, fontWeight: FontWeight.w500);
}

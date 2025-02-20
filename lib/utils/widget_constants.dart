import 'package:flutter/material.dart';

import 'color_constants.dart';

class WidgetConstants {
  static const inputFieldBorder = OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.main));
  static const inputFieldRequireStyle = TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
  static const circularProgress = CircularProgressIndicator(color: ColorConstants.main,);
  static const searchBorder = OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.main), borderRadius: BorderRadius.all(Radius.circular(10)));
}

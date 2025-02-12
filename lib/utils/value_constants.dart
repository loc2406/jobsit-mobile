import 'package:flutter/cupertino.dart';

class ValueConstants{
  static double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
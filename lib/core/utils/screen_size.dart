import 'package:flutter/widgets.dart';

class ScreenSize {
  static late double width;
  static late double hight;
  static init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    hight = MediaQuery.of(context).size.height;
  }
}

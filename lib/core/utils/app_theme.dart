import 'package:flutter/material.dart';
import 'package:quran/core/utils/color_guid.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.white),
  buttonTheme: ButtonThemeData(buttonColor: ColorGuid.mainColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(ColorGuid.mainColor),
      shadowColor: WidgetStatePropertyAll(ColorGuid.mainColor),
      textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: ColorGuid.mainColor,
    titleTextStyle: TextStyle(color: Colors.white),
    shadowColor: ColorGuid.mainColor,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.white,
    titleTextStyle: TextStyle(color: Colors.black),
  ),
  shadowColor: ColorGuid.mainColor,
  primaryColorLight: Colors.white,
  primaryColor: ColorGuid.mainColor,
  splashColor: Colors.grey,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ColorGuid.mainColor,
  ),
  expansionTileTheme: ExpansionTileThemeData(backgroundColor: Colors.white),
  primaryColorDark: Colors.black,
  secondaryHeaderColor: Color(0xfff9f5fd),
  dialogTheme: DialogThemeData(backgroundColor: Colors.white),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xff121212),
  iconTheme: IconThemeData(color: Color(0xff121212)),
  buttonTheme: ButtonThemeData(buttonColor: Color(0xff720D96)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xff720D96)),
      shadowColor: WidgetStatePropertyAll(Color(0xff720D96)),
      textStyle: WidgetStatePropertyAll(TextStyle(color: Color(0xff121212))),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff720D96),
    titleTextStyle: TextStyle(color: Color(0xff121212)),
    shadowColor: Color(0xff720D96),
    iconTheme: IconThemeData(color: Color(0xff121212)),
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Color(0xff121212),
    titleTextStyle: TextStyle(color: Colors.white),
  ),
  shadowColor: Color(0xff720D96),
  primaryColorLight: Colors.white,
  primaryColor: Color(0xff720D96),
  splashColor: Colors.grey,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff720D96),
  ),
  expansionTileTheme: ExpansionTileThemeData(
    backgroundColor: Color(0xff121212),
    collapsedBackgroundColor: Color(0xff121212),
  ),
  primaryColorDark: Colors.white,
  secondaryHeaderColor: Color.fromARGB(189, 45, 0, 87),
  dialogTheme: DialogThemeData(backgroundColor: Color(0xff121212)),
);

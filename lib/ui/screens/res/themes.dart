import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/style.dart';

final darkTheme = ThemeData(
  primaryColor: blackMain,
  primaryColorDark: blackDark,
  accentColor: white,
  unselectedWidgetColor: inactiveBlack,
  canvasColor: blackMain,
  accentTextTheme: TextTheme(
    headline4: normal32w700.copyWith(color: white),
    headline5: normal24w700.copyWith(color: white),
    headline6: normal18w500.copyWith(color: white),
    bodyText1: normal16w500.copyWith(color: white),
    bodyText2: normal14w400.copyWith(color: white),
    button: normal14w700.copyWith(color: white),
  ),
  primaryTextTheme: TextTheme(
    headline4: normal32w700.copyWith(color: Colors.red),
    headline5: normal24w700.copyWith(color: inactiveBlack),
    subtitle1: normal16w500.copyWith(color: inactiveBlack),
    bodyText1: normal14w700.copyWith(color: inactiveBlack),
    bodyText2: normal14w400.copyWith(color: inactiveBlack),
    button: normal14w700.copyWith(color: inactiveBlack),
  ),
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  ),
  buttonColor: green,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
  ),
  iconTheme: IconThemeData(
    color: white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: white,
    unselectedItemColor: white,
  ),
);

final lightTheme = ThemeData(
  primaryColor: white,
  primaryColorDark: whiteDark,
  accentColor: secondaryBlack,
  unselectedWidgetColor: inactiveBlack,
  canvasColor: white,
  accentTextTheme: TextTheme(
    headline4: normal32w700.copyWith(color: secondaryBlack),
    headline5: normal24w700.copyWith(color: secondaryBlack),
    headline6: normal18w500.copyWith(color: secondaryBlack),
    bodyText1: normal16w500.copyWith(color: secondaryBlack),
    bodyText2: normal14w400.copyWith(color: secondaryBlack),
    button: normal14w700.copyWith(color: secondaryBlack),
  ),
  primaryTextTheme: TextTheme(
    // headline4: normal32w700.copyWith(color: Colors.red),
    headline5: normal24w700.copyWith(color: inactiveBlack),
    subtitle1: normal16w500.copyWith(color: inactiveBlack),
    bodyText1: normal14w700.copyWith(color: inactiveBlack),
    bodyText2: normal14w400.copyWith(color: inactiveBlack),
    button: normal14w700.copyWith(color: inactiveBlack),
  ),
  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  ),
  buttonColor: green,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
  ),
  iconTheme: IconThemeData(
    color: white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: secondaryBlack,
    unselectedItemColor: secondaryBlack,
  ),
);

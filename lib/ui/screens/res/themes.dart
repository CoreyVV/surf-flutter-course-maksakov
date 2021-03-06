import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/style.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
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
  appBarTheme: const AppBarTheme(
    brightness: Brightness.dark,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  ),
  buttonColor: green,
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
  ),
  iconTheme: const IconThemeData(
    color: white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: white,
    unselectedItemColor: white,
  ),
);

final lightTheme = ThemeData(
  bottomSheetTheme: const BottomSheetThemeData(
    modalBackgroundColor: transparent,
    backgroundColor: transparent,
  ),
  brightness: Brightness.light,
  primaryColor: white,
  primaryColorDark: whiteDark,
  accentColor: secondaryWhite,
  unselectedWidgetColor: inactiveBlack,
  canvasColor: white,
  backgroundColor: red,
  indicatorColor: whiteMain,
  accentTextTheme: TextTheme(
    headline4: normal32w700.copyWith(color: secondaryWhite),
    headline5: normal24w700.copyWith(color: secondaryWhite),
    headline6: normal18w500.copyWith(color: secondaryWhite),
    bodyText1: normal16w500.copyWith(color: secondaryWhite),
    bodyText2: normal14w400.copyWith(color: secondaryWhite),
    button: normal14w700.copyWith(color: secondaryWhite),
  ),
  primaryTextTheme: TextTheme(
    // headline4: normal32w700.copyWith(color: Colors.red),
    headline5: normal24w700.copyWith(color: inactiveBlack),
    headline6: normal18w500.copyWith(color: inactiveBlack),
    subtitle1: normal16w500.copyWith(color: inactiveBlack),
    bodyText1: normal14w700.copyWith(color: inactiveBlack),
    bodyText2: normal14w400.copyWith(color: inactiveBlack),
    button: normal14w700.copyWith(color: inactiveBlack),
  ),
  textTheme: TextTheme(
    // headline4: normal32w700.copyWith(color: whiteMain),
    headline5: normal24w700.copyWith(color: whiteMain),
    // headline6: normal18w500.copyWith(color: whiteMain),
    bodyText1:
        normal16w500.copyWith(color: whiteMain, fontWeight: FontWeight.w400),
    bodyText2: normal14w400.copyWith(color: whiteMain),
  ),
  appBarTheme: const AppBarTheme(
    brightness: Brightness.light,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  ),
  buttonColor: green,
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: green,
      elevation: 0.0,
      textStyle: normal14w700.copyWith(color: white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: white,
  ),
  primaryIconTheme: const IconThemeData(
    color: black,
  ),
  accentIconTheme: const IconThemeData(
    color: greenWhite,
  ),
  sliderTheme: const SliderThemeData(
    // activeTickMarkColor: white,
    activeTrackColor: green,
    // inactiveTickMarkColor: inactiveBlack,
    inactiveTrackColor: inactiveBlack,
    thumbColor: white,
    trackHeight: 1,
    rangeThumbShape: RoundRangeSliderThumbShape(
      elevation: 4,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: secondaryBlack,
    unselectedItemColor: secondaryBlack,
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: greenWhite.withOpacity(0.4), width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: greenWhite.withOpacity(0.4)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    // foregroundColor: yellow,
    // focusColor: greenWhite,
    focusElevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
);

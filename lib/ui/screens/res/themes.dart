import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/style.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: blackMain,
  primaryColorDark: blackDark,
  // accentColor: white,
  unselectedWidgetColor: inactiveBlack,
  canvasColor: blackMain,

  // accentTextTheme: TextTheme(
  //   headline4: normal32w700.copyWith(color: white),
  //   headline5: normal24w700.copyWith(color: white),
  //   headline6: normal18w500.copyWith(color: white),
  //   bodyText1: normal16w500.copyWith(color: white),
  //   bodyText2: normal14w400.copyWith(color: white),
  //   button: normal14w700.copyWith(color: white),
  // ),
  primaryTextTheme: TextTheme(
    headline4: normal32w700.copyWith(color: Colors.red),
    headline5: normal24w700.copyWith(color: inactiveBlack),
    subtitle1: normal16w500.copyWith(color: inactiveBlack),
    bodyText1: normal14w700.copyWith(color: inactiveBlack),
    bodyText2: normal14w400.copyWith(color: inactiveBlack),
    button: normal14w700.copyWith(color: inactiveBlack),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  ),
  secondaryHeaderColor: green,
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
  primaryColor: colorWhite,
  primaryColorDark: colorBackground,
  unselectedWidgetColor: colorWhiteSecondary2,
  canvasColor: colorWhite,
  backgroundColor: colorBackground,
  //red
  indicatorColor: colorWhiteMain,
  secondaryHeaderColor: colorWhiteGreen,
  // accentTextTheme: TextTheme(
  //   headline4: normal32w700.copyWith(color: secondaryWhite),
  //   headline5: normal24w700.copyWith(color: secondaryWhite),
  //   headline6: normal18w500.copyWith(color: secondaryWhite),
  //   bodyText1: normal16w500.copyWith(color: secondaryWhite),
  //   bodyText2: normal14w400.copyWith(color: secondaryWhite),
  //   button: normal14w700.copyWith(color: secondaryWhite),
  // ),


  primaryTextTheme: TextTheme(
    headline4: normal32w700.copyWith(color: colorWhiteSecondary2),
    headline5: normal24w700.copyWith(color: colorWhiteSecondary2),
    headline6: normal18w500.copyWith(color: colorWhiteSecondary2),
    subtitle1: normal16w500.copyWith(color: colorWhiteSecondary2),
    bodyText1: normal16w500.copyWith(color: colorWhiteSecondary2),
    bodyText2: normal14w400.copyWith(color: colorWhiteSecondary2),
    button: normal14w700.copyWith(color: colorWhiteSecondary2),
  ),
  textTheme: TextTheme(
    headline4: normal32w700.copyWith(color: colorWhiteMain),
    headline5: normal24w700.copyWith(color: colorWhiteMain),
    headline6: normal18w500.copyWith(color: colorWhiteMain),
    subtitle1: normal16w500.copyWith(color: colorWhiteMain),
    bodyText1:
    normal16w500.copyWith(color: colorWhiteMain, fontWeight: FontWeight.w400),
    bodyText2: normal14w400.copyWith(color: colorWhiteMain),
    button: normal14w700.copyWith(color: colorWhiteMain),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  ),

  // buttonColor: colorWhiteGreen,
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: colorWhiteGreen,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: colorWhiteGreen, // background
      //onPrimary: , // foreground
      elevation: 0.0,
      textStyle: normal14w700.copyWith(color: colorWhite),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: colorWhite,
  ),
  //todo: black для чего?
  primaryIconTheme: const IconThemeData(
    color: black,
  ),
  // accentIconTheme: const IconThemeData(
  //   color: colorWhiteGreen,
  // ),
  sliderTheme: const SliderThemeData(
    // activeTickMarkColor: white,
    activeTrackColor: colorWhiteGreen,
    // inactiveTickMarkColor: inactiveBlack,
    inactiveTrackColor: colorWhiteSecondary2,
    thumbColor: colorWhite,
    trackHeight: 1,
    rangeThumbShape: RoundRangeSliderThumbShape(
      elevation: 4,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: colorWhiteSecondary,
    unselectedItemColor: colorWhiteSecondary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: colorWhiteGreen.withOpacity(0.4), width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: colorWhiteGreen.withOpacity(0.4)),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    // foregroundColor: yellow,
    // focusColor: greenWhite,
    focusElevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  ),
);

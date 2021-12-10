import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/style.dart';

final darkTheme = ThemeData(
  bottomSheetTheme: const BottomSheetThemeData(
    modalBackgroundColor: transparent,
    backgroundColor: transparent,
  ),
  brightness: Brightness.dark,
  canvasColor: colorBlackMain,
  indicatorColor: colorWhiteMain,
  // progressIndicatorTheme:
  colorScheme: const ColorScheme.dark(
    // brightness: Brightness.dark,
    primary: colorBlackMain,
    onPrimary: colorWhite,
    background: colorBlackDark,
    secondary: colorWhite,
    secondaryVariant: colorBlackSecondary2,
  ),

  primaryTextTheme: TextTheme(
    headline4: normal32w700.copyWith(color: colorWhiteSecondary2),
    headline5: normal24w700.copyWith(color: colorWhiteSecondary2),
    headline6: normal18w500.copyWith(color: colorWhiteSecondary2),
    subtitle1: normal16w500.copyWith(color: colorWhiteSecondary2),
    bodyText1: normal16w500.copyWith(
      color: colorWhiteSecondary2,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: normal14w400.copyWith(color: colorWhiteSecondary2),
    button: normal14w700.copyWith(color: colorWhiteSecondary2),
  ),
  textTheme: TextTheme(
    headline4: normal32w700.copyWith(color: colorWhite),
    headline5: normal24w700.copyWith(color: colorWhite),
    headline6: normal18w500.copyWith(color: colorWhite),
    subtitle1: normal16w500.copyWith(color: colorWhite),
    bodyText1: normal16w500.copyWith(
      color: colorWhite,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: normal14w400.copyWith(color: colorWhite),
    button: normal14w700.copyWith(color: colorWhite),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: colorBlackGreen,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: colorBlackGreen, // background
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

  sliderTheme: const SliderThemeData(
    activeTrackColor: colorBlackGreen,
    inactiveTrackColor: colorBlackSecondary2,
    thumbColor: colorWhite,
    trackHeight: 1,
    rangeThumbShape: RoundRangeSliderThumbShape(
      elevation: 4,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: colorBlackGreen.withOpacity(0.4), width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: colorBlackGreen.withOpacity(0.4)),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    focusElevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  ),

);

final lightTheme = ThemeData(
  bottomSheetTheme: const BottomSheetThemeData(
    modalBackgroundColor: transparent,
    backgroundColor: transparent,
  ),
  brightness: Brightness.light,
  canvasColor: colorWhite,
  indicatorColor: colorWhiteMain,
  // progressIndicatorTheme:
  colorScheme: const ColorScheme.light(
    // brightness: Brightness.light,
    primary: colorWhite,
    onPrimary: colorWhiteMain,
    background: colorBackground,
    secondary: colorWhiteSecondary,
    secondaryVariant: colorWhiteSecondary2,
  ),

  primaryTextTheme: TextTheme(
    headline4: normal32w700.copyWith(color: colorWhiteSecondary2),
    headline5: normal24w700.copyWith(color: colorWhiteSecondary2),
    headline6: normal18w500.copyWith(color: colorWhiteSecondary2),
    subtitle1: normal16w500.copyWith(color: colorWhiteSecondary2),
    bodyText1: normal16w500.copyWith(
      color: colorWhiteSecondary2,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: normal14w400.copyWith(color: colorWhiteSecondary2),
    button: normal14w700.copyWith(color: colorWhiteSecondary2),
  ),
  textTheme: TextTheme(
    headline4: normal32w700.copyWith(color: colorWhiteMain),
    headline5: normal24w700.copyWith(color: colorWhiteMain),
    headline6: normal18w500.copyWith(color: colorWhiteMain),
    subtitle1: normal16w500.copyWith(color: colorWhiteMain),
    bodyText1: normal16w500.copyWith(
      color: colorWhiteMain,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: normal14w400.copyWith(color: colorWhiteMain),
    button: normal14w700.copyWith(color: colorWhite),
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
  sliderTheme: const SliderThemeData(
    activeTrackColor: colorWhiteGreen,
    inactiveTrackColor: colorWhiteSecondary2,
    thumbColor: colorWhite,
    trackHeight: 1,
    rangeThumbShape: RoundRangeSliderThumbShape(
      elevation: 4,
    ),
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
    focusElevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  ),
);

extension CustomColorScheme on ColorScheme {
  Color get inactiveBlack => colorInactiveBlack;

  Color get green =>  brightness == Brightness.light ? colorWhiteGreen : colorBlackGreen;

  Color get red => brightness == Brightness.light ? colorWhiteRed : colorBlackRed;

  Color get yellow => brightness == Brightness.light ? colorWhiteYellow : colorBlackYellow;

  Color get transparent => Colors.transparent;
}

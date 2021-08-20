import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/screens/AddSightScreen.dart';
import 'package:places/ui/screens/OnboardingScreen.dart';
import 'package:places/ui/screens/SettingsScreen.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/sight_card.dart';
import 'package:places/ui/screens/visiting_screen.dart';
import 'package:places/ui/screens/sight_details.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/mocks.dart';

void main() {
  runApp(_MaterialAppWithTheme());
}

class _MaterialAppWithTheme extends StatefulWidget {
  const _MaterialAppWithTheme({Key? key}) : super(key: key);

  @override
  __MaterialAppWithThemeState createState() => __MaterialAppWithThemeState();
}

class __MaterialAppWithThemeState extends State<_MaterialAppWithTheme> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white,
      ),
    );

    return MaterialApp(
      theme: themeNotifier.getTheme(),
      home: SightListScreen(),
      // home: SightCard(mocks[0]),
      // home: Scaffold(body: SightDetails(sight: mocks[0])),
      // home: VisitingScreen(),
      // home: FilterScreen(),
      // home: SettingsScreen(),
      // home: AddSightScreen(),
      // home: SelectSightType(),
      // home: OnboardingScreen(),
      title: 'places',
    );
  }

  _changeTheme() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(_changeTheme);
  }

  @override
  void dispose() {
    super.dispose();
    themeNotifier.removeListener(_changeTheme);
  }
}

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  getPrimaryColor() => _themeData.primaryColor;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;

    final style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: themeNotifier.getPrimaryColor(),
    );

    SystemChrome.setSystemUIOverlayStyle(style);

    notifyListeners();
  }
}

final themeNotifier = ThemeNotifier(lightTheme);

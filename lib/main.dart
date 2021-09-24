import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/themes.dart';

void main() {
  
  // PlaceRepository().getPlaces().then((_listPlaces) {
  //   for (final place in _listPlaces) {
  //     print(place.name);
  //   }
  // });

  runApp(const _MaterialAppWithTheme());
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
      // home: const SplashScreen(),
      home: SightListScreen(),
      title: 'places',
    );
  }

  void _changeTheme() {
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

  ThemeData getTheme() => _themeData;

  Color getPrimaryColor() => _themeData.primaryColor;

  void setTheme(ThemeData themeData) async {
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

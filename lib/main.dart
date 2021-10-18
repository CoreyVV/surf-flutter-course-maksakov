import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/interactor/favorite_place_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/themes.dart';

final settingsInteractor = SettingsInteractor();
final placeInteractor = PlaceInteractor(placeRepository: PlaceRepository());
final favoritePlaceInteractor = FavoritePlaceInteractor();

void main() {
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
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            settingsInteractor.isDarkTheme ? blackMain : white,
      ),
    );
    favoritePlaceInteractor.init();

    return MaterialApp(
      theme: settingsInteractor.isDarkTheme ? darkTheme : lightTheme,
      // home: const SplashScreen(),
      home: SightListScreen(),
      title: 'places',
    );
  }

  @override
  void initState() {
    settingsInteractor.addListener(() => setState(() {
          final style = SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor:
                settingsInteractor.isDarkTheme ? blackMain : white,
          );

          SystemChrome.setSystemUIOverlayStyle(style);
        }));
    super.initState();
  }

  @override
  void dispose() {
    settingsInteractor.removeListener(() => setState(() {}));
    super.dispose();
  }
}


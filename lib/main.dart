import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/interactor/favorite_place_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/screens/place_list_screen.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

// final _favoritePlaceInteractor = FavoritePlaceInteractor();

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
    return MultiProvider(
      providers: [
        Provider<PlaceInteractor>(
          create: (context) =>
              PlaceInteractor(placeRepository: PlaceRepository()),
          dispose: (context, interactor) {
            interactor.dispose();
          },
        ),
        ChangeNotifierProvider<SettingsInteractor>(
          create: (context) => SettingsInteractor(),
        ),
        Provider<FavoritePlaceInteractor>(
          create: (context) => FavoritePlaceInteractor(),
          dispose: (context, interactor) {
            interactor.dispose();
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final settingsInteractor = Provider.of<SettingsInteractor>(context);
          final style = SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor:
            settingsInteractor.isDarkTheme ? blackMain : white,
          );
          Provider.of<FavoritePlaceInteractor>(context).init();

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: style,
            child: MaterialApp(
              theme: settingsInteractor.isDarkTheme
                  ? darkTheme
                  : lightTheme,
              // home: const SplashScreen(),
              home: PlaceListScreen(),
              title: 'places',
            ),
          );
        },
      ),
    );
  }
}


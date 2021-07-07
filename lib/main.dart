import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/visiting_screen.dart';
import 'package:places/ui/screens/sight_details.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/mocks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white, //blackMain,
      ),
    );
    return MaterialApp(
      theme: lightTheme,
      // home: SightListScreen(),
      // home: Scaffold(body: SightDetails(mocks[0])),
      // home: VisitingScreen(),
      home: FilterScreen(),
      title: 'places',
    );
  }
}

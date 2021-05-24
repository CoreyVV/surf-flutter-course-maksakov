import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
// import 'package:places/mocks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      home: SightListScreen(),
      // home: Scaffold(body: SightCard(mocks[2])),
      title: 'places',
    );
  }
}

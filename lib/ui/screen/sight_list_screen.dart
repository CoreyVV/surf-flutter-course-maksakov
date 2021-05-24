import 'package:flutter/material.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/mocks.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Список\nинтересных мест',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 32,
              fontStyle: FontStyle.normal),
          maxLines: 2,
        ),
        toolbarHeight: 136,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // title: RichText(
        //   text: TextSpan(
        //       text: 'С',
        //       style: TextStyle(
        //           color: Colors.green,
        //           backgroundColor: Colors.transparent,
        //           fontSize: 32,
        //           fontWeight: FontWeight.w700,
        //           fontStyle: FontStyle.normal),
        //       children: [
        //         TextSpan(
        //             text: 'писок',
        //             style: TextStyle(color: Colors.black),
        //             children: [
        //               TextSpan(
        //                   text: '\nи',
        //                   style: TextStyle(color: Colors.yellow),
        //                   children: [
        //                     TextSpan(
        //                         text: 'нтересных мест',
        //                         style: TextStyle(color: Colors.black))
        //                   ])
        //             ]),
        //       ]),
        //   textAlign: TextAlign.left,
        //   maxLines: 2,
        // ),
        // toolbarHeight: 136,
        // backgroundColor: Colors.transparent,
        // elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: [
              SightCard(mocks[0]),
              SightCard(mocks[1]),
              SightCard(mocks[2]),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   child: Icon(Icons.add),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'person',
      //     ),
      //   ],
      // ),
    );
  }
}

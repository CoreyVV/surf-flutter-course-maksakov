import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      print(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // title: Text(
        //   'Список\nинтересных мест',
        //   textAlign: TextAlign.left,
        //   style: TextStyle(
        //       fontFamily: 'Roboto',
        //       color: Colors.black,
        //       fontWeight: FontWeight.w700,
        //       fontSize: 32,
        //       fontStyle: FontStyle.normal),
        //   maxLines: 2,
        // ),
        // toolbarHeight: 136,
        // backgroundColor: Colors.transparent,
        // elevation: 0.0,
        title: RichText(
          text: TextSpan(
              text: 'С',
              style: TextStyle(
                  color: Colors.green,
                  backgroundColor: Colors.transparent,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal),
              children: [
                TextSpan(
                    text: 'писок',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                          text: '\nи',
                          style: TextStyle(color: Colors.yellow),
                          children: [
                            TextSpan(
                                text: 'нтересных мест',
                                style: TextStyle(color: Colors.black))
                          ])
                    ]),
              ]),
          textAlign: TextAlign.left,
          maxLines: 2,
        ),
        toolbarHeight: 136,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: GridView.count(
          // primary: false,
          // padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("There might be something interesting"),
              color: Colors.teal[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("and here too"),
              color: Colors.teal[300],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(_counter.toString()),
              color: Colors.teal[500],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("There might be something interesting"),
              color: Colors.blue[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("and here too"),
              color: Colors.blue[300],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(_counter.toString()),
              color: Colors.blue[500],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("There might be something interesting"),
              color: Colors.yellow[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("and here too"),
              color: Colors.yellow[300],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(_counter.toString()),
              color: Colors.yellow[500],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'person',
          ),
        ],
      ),
    );
  }
}

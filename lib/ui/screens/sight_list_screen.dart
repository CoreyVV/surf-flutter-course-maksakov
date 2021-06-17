import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/style.dart';
import 'package:places/ui/screens/sight_card.dart';
import 'package:places/mocks.dart';

class SightAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  SightAppBar(this.height);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Список\nинтересных мест',
        textAlign: TextAlign.left,
        style: Theme.of(context).accentTextTheme.headline4,
        maxLines: 2,
      ),
      // backgroundColor: Colors.transparent,
      // elevation: 0.0,
      toolbarHeight: height,
    );
  }
}

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SightAppBar(136),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                // color: Color(0xFF252849),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                // color: Color(0xFF252849),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                // color: Color(0xFF252849),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                // color: Color(0xFF252849),
              ),
              label: ''),
        ],
      ),
    );
  }
}

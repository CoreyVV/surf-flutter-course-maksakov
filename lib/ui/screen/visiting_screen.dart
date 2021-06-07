import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_visited.dart';
import 'package:places/ui/screen/sight_planned.dart';

class VisitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
              padding:
                  EdgeInsets.only(left: 134, top: 16, right: 133, bottom: 16),
              alignment: Alignment.center,
              child: Text(
                'Избранное',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontStyle: FontStyle.normal),
                maxLines: 2,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                margin:
                    EdgeInsets.only(left: 16, top: 14, right: 15, bottom: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  unselectedLabelColor: Color(0xFF7C7E92),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color(0xFF3B3E5B)),
                  tabs: [
                    Container(
                      width: 184,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(child: Text('Хочу посетить')),
                    ),
                    Container(
                      width: 184,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(child: Text('Посетил')),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            toolbarHeight: 108,
          ),
          body: TabBarView(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(children: [
                  SightCardVisited(mocks[0]),
                  // SightCardVisited(mocks[2]),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(children: [
                  SightCardPlanned(mocks[1]),
                ]),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    color: Color(0xFF252849),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.map,
                    color: Color(0xFF252849),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: Color(0xFF252849),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: Color(0xFF252849),
                  ),
                  label: ''),
            ],
          ),
        );
      }),
    );
  }
}

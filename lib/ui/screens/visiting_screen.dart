import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/bottom_navigation_bar.dart';
import 'package:places/ui/screens/sight_visited.dart';
import 'package:places/ui/screens/sight_planned.dart';

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
                style: Theme.of(context).accentTextTheme.headline6,
                maxLines: 2,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                margin:
                    EdgeInsets.only(left: 16, top: 14, right: 15, bottom: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).accentColor),
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
                  SightCardPlanned(mocks[0]),
                  // SightCardVisited(mocks[2]),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(children: [
                  SightCardVisited(mocks[1]),
                ]),
              ),
            ],
          ),
          bottomNavigationBar: MyBottomNavigationBar(),
        );
      }),
    );
  }
}

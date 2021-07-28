import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/bottom_navigation_bar.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_visited.dart';
import 'package:places/ui/screens/sight_planned.dart';

class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
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
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Column(
                    children: [
                      if (mocks.isNotEmpty)
                        for (var sight in mocks)
                          SightCardPlanned(
                            sight: sight,
                            onRemove: () {
                              setState(() {
                                mocks.remove(sight);
                              });
                            },
                          )
                      else
                        _EmptyList(
                          asset: AssetsStr.card,
                          bodyText:
                              'Отмечайте понравившиеся\nместа и они появиятся здесь.',
                        ),
                      // SightCardVisited(mocks[2]),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Column(
                    children: [
                      if (mocks.isNotEmpty)
                        for (var sight in mocks)
                          SightCardVisited(
                            sight: sight,
                            onRemove: () {
                              setState(() {
                                mocks.remove(sight);
                              });
                            },
                          )
                      else
                        _EmptyList(
                          asset: AssetsStr.go,
                          bodyText:
                              'Завершите маршрут,\nчтобы место попало сюда.',
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: MyBottomNavigationBar(),
        );
      }),
    );
  }
}

//Виджет отображения пустого списка
class _EmptyList extends StatelessWidget {
  // const _EmptyList({ Key? key }) : super(key: key);
  final String asset;
  final String bodyText;

  const _EmptyList({
    required this.asset,
    required this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 170,
          ),
          MyIcon(
            asset: asset,
            color: Theme.of(context).unselectedWidgetColor,
            height: 48,
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            'Пусто',
            style: Theme.of(context).primaryTextTheme.headline6,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            bodyText,
            style: Theme.of(context).primaryTextTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

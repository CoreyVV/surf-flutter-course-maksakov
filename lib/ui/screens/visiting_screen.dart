import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/bottom_navigation_bar.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_visited.dart';
import 'package:places/ui/screens/sight_planned.dart';

List<Sight> _listVisitedSights = [...mocks];
List<Sight> _listPlannedSights = [...mocks];

class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  bool isDrag = false;
  bool isOnMove = false;
  Map<String, bool> _mapIsDragVisited = Map.fromIterable(_listVisitedSights,
      key: (item) => item.name, value: (item) => false);
  Map<String, bool> _mapIsOnMoveVisited = Map.fromIterable(_listVisitedSights,
      key: (item) => item.name, value: (item) => false);
  Map<String, bool> _mapIsDragPlanned = Map.fromIterable(_listVisitedSights,
      key: (item) => item.name, value: (item) => false);
  Map<String, bool> _mapIsOnMovePlanned = Map.fromIterable(_listVisitedSights,
      key: (item) => item.name, value: (item) => false);

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
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      if (_listPlannedSights.isNotEmpty)
                        Flexible(
                          child: ListView.builder(
                            itemCount: _listPlannedSights.length,
                            itemBuilder: (context, index) {
                              Sight sight = _listPlannedSights[index];
                              return Column(
                                children: [
                                  DragTarget(
                                    key: ValueKey(sight.name + 'dt'),
                                    builder:
                                        (context, candidateData, rejectedData) {
                                      return Container(
                                        height: _mapIsOnMovePlanned[sight.name]!
                                            ? 218
                                            : 16,
                                        width: 338,
                                        color: Colors.transparent,
                                      );
                                    },
                                    onWillAccept: (Sight? data) {
                                      return _listPlannedSights.contains(data);
                                    },
                                    onAccept: (Sight? data) {
                                      int index =
                                          _listPlannedSights.indexOf(sight);
                                      if (index <
                                          _listPlannedSights.indexOf(data!)) {
                                        _listPlannedSights.remove(data);
                                        _listPlannedSights.insert(index, data);
                                      } else {
                                        _listPlannedSights.remove(data);
                                        _listPlannedSights.insert(
                                            index - 1, data);
                                      }
                                      setState(() {
                                        _mapIsOnMovePlanned[sight.name] = false;
                                      });
                                    },
                                    onMove: (data) {
                                      setState(() {
                                        _mapIsOnMovePlanned[sight.name] = true;
                                      });
                                    },
                                    onLeave: (data) {
                                      setState(() {
                                        _mapIsOnMovePlanned[sight.name] = false;
                                      });
                                    },
                                  ),
                                  Draggable<Sight>(
                                    data: sight,
                                    onDragStarted: () {
                                      setState(() {
                                        _mapIsDragPlanned[sight.name] = true;
                                      });
                                    },
                                    onDragEnd: (details) {
                                      setState(() {
                                        _mapIsDragPlanned[sight.name] = false;
                                      });
                                    },
                                    feedback: SightCardPlanned(
                                      key: ValueKey(sight),
                                      sight: sight,
                                      onRemove: () {
                                        setState(() {
                                          _listPlannedSights.remove(sight);
                                        });
                                      },
                                    ),
                                    child: _mapIsDragPlanned[sight.name]!
                                        ? SizedBox.shrink()
                                        : Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Container(
                                                  width: 360,
                                                  height: 218,
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                ),
                                              ),
                                              Positioned(
                                                top: 80,
                                                right: 28,
                                                child: Column(
                                                  children: [
                                                    MyIcon(
                                                      asset:
                                                          AssetsStr.icon_bucket,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      'Удалить',
                                                      style: Theme.of(context)
                                                          .accentTextTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Dismissible(
                                                key: ValueKey(
                                                    sight.name + 'ds_vs'),
                                                // crossAxisEndOffset: 80.0,
                                                direction:
                                                    DismissDirection.endToStart,
                                                dismissThresholds: const {
                                                  DismissDirection.endToStart:
                                                      0.25
                                                },
                                                child: SightCardVisited(
                                                  key: ValueKey(sight),
                                                  sight: sight,
                                                  onRemove: () {
                                                    setState(() {
                                                      _listPlannedSights
                                                          .remove(sight);
                                                    });
                                                  },
                                                ),
                                                onDismissed: (direction) {
                                                  setState(() {
                                                    _listPlannedSights
                                                        .remove(sight);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                  ),
                                ],
                              );
                            },
                          ),
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
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      if (_listVisitedSights.isNotEmpty)
                        Flexible(
                          child: ListView.builder(
                            itemCount: _listVisitedSights.length,
                            itemBuilder: (context, index) {
                              Sight sight = _listVisitedSights[index];
                              return Column(
                                children: [
                                  DragTarget(
                                    key: ValueKey(sight.name + 'dt'),
                                    builder:
                                        (context, candidateData, rejectedData) {
                                      return Container(
                                        height: _mapIsOnMoveVisited[sight.name]!
                                            ? 218
                                            : 16,
                                        width: 338,
                                        color: Colors.transparent,
                                      );
                                    },
                                    onWillAccept: (Sight? data) {
                                      return _listVisitedSights.contains(data);
                                    },
                                    onAccept: (Sight? data) {
                                      int index =
                                          _listVisitedSights.indexOf(sight);
                                      if (index <
                                          _listVisitedSights.indexOf(data!)) {
                                        _listVisitedSights.remove(data);
                                        _listVisitedSights.insert(index, data);
                                      } else {
                                        _listVisitedSights.remove(data);
                                        _listVisitedSights.insert(
                                            index - 1, data);
                                      }
                                      setState(() {
                                        _mapIsOnMoveVisited[sight.name] = false;
                                      });
                                    },
                                    onMove: (data) {
                                      setState(() {
                                        _mapIsOnMoveVisited[sight.name] = true;
                                      });
                                    },
                                    onLeave: (data) {
                                      setState(() {
                                        _mapIsOnMoveVisited[sight.name] = false;
                                      });
                                    },
                                  ),
                                  Draggable<Sight>(
                                    data: sight,
                                    onDragStarted: () {
                                      setState(() {
                                        _mapIsDragVisited[sight.name] = true;
                                      });
                                    },
                                    onDragEnd: (details) {
                                      setState(() {
                                        _mapIsDragVisited[sight.name] = false;
                                      });
                                    },
                                    feedback: SightCardVisited(
                                      key: ValueKey(sight),
                                      sight: sight,
                                      onRemove: () {
                                        setState(() {
                                          _listVisitedSights.remove(sight);
                                        });
                                      },
                                    ),
                                    child: _mapIsDragVisited[sight.name]!
                                        ? SizedBox.shrink()
                                        : Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Container(
                                                  width: 360,
                                                  height: 218,
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                ),
                                              ),
                                              Positioned(
                                                top: 80,
                                                right: 28,
                                                child: Column(
                                                  children: [
                                                    MyIcon(
                                                      asset:
                                                          AssetsStr.icon_bucket,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      'Удалить',
                                                      style: Theme.of(context)
                                                          .accentTextTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Dismissible(
                                                key: ValueKey(
                                                    sight.name + 'ds_vs'),
                                                // crossAxisEndOffset: 80.0,
                                                direction:
                                                    DismissDirection.endToStart,
                                                dismissThresholds: const {
                                                  DismissDirection.endToStart:
                                                      0.25
                                                },
                                                child: SightCardVisited(
                                                  key: ValueKey(sight),
                                                  sight: sight,
                                                  onRemove: () {
                                                    setState(() {
                                                      _listVisitedSights
                                                          .remove(sight);
                                                    });
                                                  },
                                                ),
                                                onDismissed: (direction) {
                                                  setState(() {
                                                    _listVisitedSights
                                                        .remove(sight);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                  ),
                                ],
                              );
                            },
                          ),
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

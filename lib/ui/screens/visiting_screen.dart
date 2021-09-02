import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/widgets/bottom_navigation_bar.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_card_favorite.dart';

List<Sight> _listVisitedSights = mocks.where((sight) => sight.isVisited).toList();
List<Sight> _listPlannedSights = mocks.where((sight) => sight.isPlanned).toList();

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (_) {
        return Scaffold(
          appBar: const _AppBar(),
          body: const _Body(),
          bottomNavigationBar: MyBottomNavigationBar(pageIndex: 2,),
        );
      }),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const _AppBar({
    this.height = 108,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        padding: const EdgeInsets.only(
          left: 134,
          top: 16,
          right: 133,
          bottom: 16,
        ),
        alignment: Alignment.center,
        child: Text(
          'Избранное',
          textAlign: TextAlign.center,
          style: Theme.of(context).accentTextTheme.headline6,
          maxLines: 2,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
          margin: const EdgeInsets.only(
            left: 16,
            top: 14,
            right: 15,
            bottom: 6,
          ),
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
              color: Theme.of(context).accentColor,
            ),
            tabs: [
              Container(
                width: 184,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(child: Text('Хочу посетить')),
              ),
              Container(
                width: 184,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(child: Text('Посетил')),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 108,
      automaticallyImplyLeading: false,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        SafeArea(
          child: _TabList(
            listSight: _listPlannedSights,
            asset: AssetsStr.card,
            bodyText: 'Отмечайте понравившиеся\nместа и они появиятся здесь.',
          ),
        ),
        SafeArea(
          child: _TabList(
            listSight: _listVisitedSights,
            asset: AssetsStr.go,
            bodyText: 'Завершите маршрут,\nчтобы место попало сюда.',
          ),
        ),
      ],
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
          const SizedBox(
            height: 170,
          ),
          MyIcon(
            asset: asset,
            color: Theme.of(context).unselectedWidgetColor,
            height: 48,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            'Пусто',
            style: Theme.of(context).primaryTextTheme.headline6,
          ),
          const SizedBox(
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

//Виджет закладки запланированных мест
class _TabList extends StatefulWidget {
  final List<Sight> listSight;
  final String asset;
  final String bodyText;

  const _TabList({
    required this.listSight,
    required this.asset,
    required this.bodyText,
    Key? key,
  }) : super(key: key);

  @override
  _TabListState createState() => _TabListState();
}

class _TabListState extends State<_TabList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (widget.listSight.isNotEmpty)
            _DraggableList(
              listSight: widget.listSight,
              onEmptyList: () => {setState(() {})},
            )
          else
            _EmptyList(
              asset: widget.asset,
              bodyText: widget.bodyText,
            ),
        ],
      ),
    );
  }
}

class _DraggableList extends StatefulWidget {
  final List<Sight> listSight;
  final VoidCallback onEmptyList;

  const _DraggableList({
    required this.listSight,
    required this.onEmptyList,
    Key? key,
  }) : super(key: key);

  @override
  _DraggableListState createState() => _DraggableListState();
}

class _DraggableListState extends State<_DraggableList> {
  late final Map<String, bool> _mapIsDrag;
  late final Map<String, bool> _mapIsMove;

  @override
  void initState() {
    _mapIsDrag = {
      for (var item in widget.listSight) item.name: false,
    };
    _mapIsMove = {
      for (var item in widget.listSight) item.name: false,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: widget.listSight.length,
        itemBuilder: (context, index) {
          final Sight sight = widget.listSight[index];

          return Column(
            children: [
              DragTarget(
                key: ValueKey('${sight.name}dt'),
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    height: _mapIsMove[sight.name]! ? 218 : 16,
                    width: 338,
                    color: Colors.transparent,
                  );
                },
                onWillAccept: (data) {
                  return widget.listSight.contains(data);
                },
                onAccept: (Sight? data) {
                  final int index = widget.listSight.indexOf(sight);
                  if (index < widget.listSight.indexOf(data!)) {
                    widget.listSight
                      ..remove(data)
                      ..insert(index, data);
                  } else {
                    widget.listSight
                      ..remove(data)
                      ..insert(index - 1, data);
                  }
                  _onMove(sight, false);
                },
                onMove: (data) => _onMove(sight, true),
                onLeave: (data) => _onMove(sight, false),
              ),
              Draggable<Sight>(
                data: sight,
                onDragStarted: () => _onDrag(sight, true),
                onDragEnd: (details) => _onDrag(sight, false),
                feedback: SightCardFavorite(
                  key: ValueKey(sight),
                  sight: sight,
                  onRemove: () => {_onRemove(sight)},
                ),
                child: _mapIsDrag[sight.name]!
                    ? const SizedBox.shrink()
                    : _DismissibleStack(
                        sight: sight,
                        onRemove: () => {_onRemove(sight)},
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onRemove(Sight sight) {
    setState(() {
      widget.listSight.remove(sight);
      if (widget.listSight.isEmpty) {
        widget.onEmptyList();
      }
    });
  }

  void _onDrag(Sight sight, bool isDrag) {
    setState(() {
      _mapIsDrag[sight.name] = isDrag;
    });
  }

  void _onMove(Sight sight, bool isMove) {
    setState(() {
      _mapIsMove[sight.name] = isMove;
    });
  }
}

class _Bucket extends StatelessWidget {
  const _Bucket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyIcon(
          asset: AssetsStr.iconBucket,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Удалить',
          style: Theme.of(context).accentTextTheme.bodyText1!.copyWith(
                color: Theme.of(
                  context,
                ).primaryColor,
              ),
        ),
      ],
    );
  }
}

class _DismissibleStack extends StatefulWidget {
  final Sight sight;
  final VoidCallback onRemove;

  const _DismissibleStack({
    required this.sight,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  _DismissibleStackState createState() => _DismissibleStackState();
}

class _DismissibleStackState extends State<_DismissibleStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 360,
            height: 218,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        const Positioned(
          top: 80,
          right: 28,
          child: _Bucket(),
        ),
        Dismissible(
          key: ValueKey(
            '${widget.sight.name}ds_vs',
          ),
          direction: DismissDirection.endToStart,
          dismissThresholds: const {
            DismissDirection.endToStart: 0.25,
          },
          onDismissed: (direction) => widget.onRemove(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SightCardFavorite(
              key: ValueKey(widget.sight),
              sight: widget.sight,
              onRemove: widget.onRemove,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/main.dart';
import 'package:places/ui/screens/res/strings.dart';
import 'package:places/ui/screens/widgets/bottom_navigation_bar.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_card_favorite.dart';


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

  @override
  Size get preferredSize => Size.fromHeight(height);

  const _AppBar({
    this.height = 108,
    Key? key,
  }) : super(key: key);

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
          AppStrings.favorite,
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
                child: const Center(child: Text(AppStrings.wantToVisit)),
              ),
              Container(
                width: 184,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(child: Text(AppStrings.visited)),
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
            listPlace: favoritePlaceInteractor.getFavoritesPlaces,
            asset: AssetsStr.card,
            bodyText: AppStrings.markFavorite,
          ),
        ),
        SafeArea(
          child: _TabList(
            listPlace: placeInteractor.getVisitedPlaces(),
            asset: AssetsStr.go,
            bodyText: AppStrings.finishRoute,
          ),
        ),
      ],
    );
  }
}

//Виджет отображения пустого списка
class _EmptyList extends StatelessWidget {
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
            AppStrings.empty,
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
  final List<Place> listPlace;
  final String asset;
  final String bodyText;

  const _TabList({
    required this.listPlace,
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
          if (widget.listPlace.isNotEmpty)
            _DraggableList(
              listPlace: widget.listPlace,
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
  final List<Place> listPlace;
  final VoidCallback onEmptyList;

  const _DraggableList({
    required this.listPlace,
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
      for (var item in widget.listPlace) item.name: false,
    };
    _mapIsMove = {
      for (var item in widget.listPlace) item.name: false,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: widget.listPlace.length,
        itemBuilder: (context, index) {
          final place = widget.listPlace[index];

          return Column(
            children: [
              DragTarget(
                key: ValueKey('${place.name}dt'),
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    height: _mapIsMove[place.name]! ? 218 : 16,
                    width: 338,
                    color: Colors.transparent,
                  );
                },
                onWillAccept: (data) {
                  return widget.listPlace.contains(data);
                },
                onAccept: (Place? data) {
                  final index = widget.listPlace.indexOf(place);
                  if (index < widget.listPlace.indexOf(data!)) {
                    widget.listPlace
                      ..remove(data)
                      ..insert(index, data);
                  } else {
                    widget.listPlace
                      ..remove(data)
                      ..insert(index - 1, data);
                  }
                  _onMove(place, false);
                },
                onMove: (data) => _onMove(place, true),
                onLeave: (data) => _onMove(place, false),
              ),
              Draggable<Place>(
                data: place,
                onDragStarted: () => _onDrag(place, true),
                onDragEnd: (details) => _onDrag(place, false),
                feedback: PlaceCardFavorite(
                  key: ValueKey(place),
                  place: place,
                  onRemove: () => {_onRemove(place)},
                ),
                child: _mapIsDrag[place.name]!
                    ? const SizedBox.shrink()
                    : _DismissibleStack(
                        place: place,
                        onRemove: () => {_onRemove(place)},
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onRemove(Place place) {
    setState(() {
      widget.listPlace.remove(place);
      if (widget.listPlace.isEmpty) {
        widget.onEmptyList();
      }
    });
  }

  void _onDrag(Place place, bool isDrag) {
    setState(() {
      _mapIsDrag[place.name] = isDrag;
    });
  }

  void _onMove(Place place, bool isMove) {
    setState(() {
      _mapIsMove[place.name] = isMove;
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
          AppStrings.delete,
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
  final Place place;
  final VoidCallback onRemove;

  const _DismissibleStack({
    required this.place,
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
            '${widget.place.name}ds_vs',
          ),
          direction: DismissDirection.endToStart,
          dismissThresholds: const {
            DismissDirection.endToStart: 0.25,
          },
          onDismissed: (direction) => widget.onRemove(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PlaceCardFavorite(
              key: ValueKey(widget.place),
              place: widget.place,
              onRemove: widget.onRemove,
            ),
          ),
        ),
      ],
    );
  }
}

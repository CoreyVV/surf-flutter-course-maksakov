import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/main.dart';
import 'package:places/ui/screens/add_sight_screen.dart';
import 'package:places/ui/screens/widgets/bottom_navigation_bar.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_card.dart';
import 'package:places/ui/screens/widgets/search_bar.dart';

class SightAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const SightAppBar({
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Список\nинтересных мест',
        textAlign: TextAlign.left,
        style: Theme.of(context).accentTextTheme.headline4,
        maxLines: 2,
      ),
      toolbarHeight: height,
    );
  }
}

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: const _SightListWidget(),
      bottomNavigationBar: MyBottomNavigationBar(
        pageIndex: 0,
      ),
      floatingActionButton:
          MediaQuery.of(context).orientation == Orientation.portrait
              ? const _NewSightButton()
              : const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _SightListWidget extends StatelessWidget {
  const _SightListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? const _SightListPortraitWidget()
        : const _SightListLandscapeWidget();
  }
}

class _SightListPortraitWidget extends StatefulWidget {
  const _SightListPortraitWidget({Key? key}) : super(key: key);

  @override
  __SightListPortraitWidgetState createState() =>
      __SightListPortraitWidgetState();
}

class __SightListPortraitWidgetState extends State<_SightListPortraitWidget> {
  @override
  void initState() {
    placeInteractor.getListPlaces;
    super.initState();
  }

  @override
  void dispose() {
    placeInteractor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<List<Place>>(
        stream: placeInteractor.getListPlaces,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final _listPlaces = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: _AppBarPortraitHeaderDelegate(),
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    for (int i = 0; i < _listPlaces.length; i++)
                      Column(
                        children: [
                          PlaceCard(place: _listPlaces[i]),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SightListLandscapeWidget extends StatefulWidget {
  const _SightListLandscapeWidget({Key? key}) : super(key: key);

  @override
  __SightListLandscapeWidgetState createState() =>
      __SightListLandscapeWidgetState();
}

class __SightListLandscapeWidgetState extends State<_SightListLandscapeWidget> {
  @override
  void initState() {
    placeInteractor.getListPlaces;
    super.initState();
  }

  @override
  void dispose() {
    placeInteractor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: StreamBuilder<List<Place>>(
        stream: placeInteractor.getListPlaces,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final _listPlaces = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: _AppBarLandscapeHeaderDelegate(),
                pinned: true,
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30.0,
                  crossAxisSpacing: 36.0,
                  childAspectRatio: 1.77,
                ),
                delegate: SliverChildListDelegate(
                  [
                    for (int i = 0; i < _listPlaces.length; i++)
                      PlaceCard(place: _listPlaces[i]),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

//FAB
class _NewSightButton extends StatelessWidget {
  const _NewSightButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 177,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (_) => const AddSightScreen(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: <Color>[
                yellow,
                greenWhite,
              ],
            ),
          ),
          child: SizedBox(
            height: 48,
            width: 177,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                MyIcon(asset: AssetsStr.iconPlus),
                SizedBox(
                  width: 13.64,
                ),
                Text('НОВОЕ МЕСТО'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarPortraitHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 240;

  @override
  double get minExtent => 80;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Column(
      children: [
        Expanded(
          child: shrinkOffset < (maxExtent - minExtent) * 0.6
              ? Column(
                  children: [
                    SizedBox(
                      height: (minExtent - shrinkOffset).clamp(20, 54),
                    ),
                    Text(
                      'Список\nинтересных мест',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).accentTextTheme.headline4,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: (minExtent - shrinkOffset).clamp(10, 24),
                    ),
                    if (shrinkOffset < (maxExtent - minExtent) * 0.4)
                      Flexible(
                        child: Opacity(
                          opacity: 1 - shrinkOffset / 100,
                          child: SearchBar(),
                        ),
                      ),
                    SizedBox(
                      height: (minExtent - shrinkOffset).clamp(16, 24),
                    ),
                  ],
                )
              : Container(
                  color: Theme.of(context).canvasColor,
                  height: minExtent,
                  child: Center(
                    child: Text(
                      'Список интересных мест',
                      style: Theme.of(context).accentTextTheme.headline6,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _AppBarLandscapeHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 142;

  @override
  double get minExtent => 56;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Column(
      children: [
        Expanded(
          child: shrinkOffset < (maxExtent - minExtent) * 0.3
              ? Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Список интересных мест',
                        style: Theme.of(context).accentTextTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: (minExtent - shrinkOffset).clamp(10, 22),
                    ),
                    if (shrinkOffset < (maxExtent - minExtent) * 0.2)
                      Flexible(
                        child: Opacity(
                          opacity: 1 - shrinkOffset / 100,
                          child: SearchBar(),
                        ),
                      ),
                    SizedBox(
                      height: (minExtent - shrinkOffset).clamp(10, 14),
                    ),
                  ],
                )
              : Container(
                  color: Theme.of(context).canvasColor,
                  height: minExtent,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Список интересных мест',
                      style: Theme.of(context).accentTextTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/store/place_list/place_list_store.dart';
import 'package:places/ui/screens/add_sight_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/my_icons.dart';
import 'package:places/ui/screens/res/app_strings.dart';
import 'package:places/ui/screens/place_card.dart';
import 'package:places/ui/screens/widgets/my_bottom_navigation_bar.dart';
import 'package:places/ui/screens/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatefulWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
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
        AppStrings.appBarText2Str,
        textAlign: TextAlign.left,
        style: Theme.of(context).accentTextTheme.headline4,
        maxLines: 2,
      ),
      toolbarHeight: height,
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
  late PlaceListStore _store;

  @override
  void initState() {
    _store = PlaceListStore(context.read<PlaceInteractor>());
    _store.getListPlaces();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Observer(
        builder: (context) {
          final future = _store.getListPlacesFuture;
          if (future == null) {
            return const Center(child: CircularProgressIndicator());
          }
          switch (future.status) {
            case FutureStatus.pending:
              {
                return const Center(child: CircularProgressIndicator());
              }
            case FutureStatus.rejected:
              {
                return const _ErrorPlaceHolder();
              }
            case FutureStatus.fulfilled:
              {
                final _listPlaces = future.value!;

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
              }
          }
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
  late PlaceListStore _store;

  @override
  void initState() {
    _store = PlaceListStore(context.read<PlaceInteractor>());
    _store.getListPlaces();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Observer(
        builder: (context) {
          final future = _store.getListPlacesFuture;
          if (future == null) {
            return const Center(child: CircularProgressIndicator());
          }
          switch (future.status) {
            case FutureStatus.pending:
              {
                return const Center(child: CircularProgressIndicator());
              }
            case FutureStatus.rejected:
              {
                return const _ErrorPlaceHolder();
              }
            case FutureStatus.fulfilled:
              {
                final _listPlaces = future.value!;

                return CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: _AppBarLandscapeHeaderDelegate(),
                      pinned: true,
                    ),
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
              }
          }
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
                Text(AppStrings.newSightButtonTextUppercase),
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
                      AppStrings.appBarText2Str,
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
                      AppStrings.appBarText1Str,
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
                        AppStrings.appBarText1Str,
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
                      AppStrings.appBarText1Str,
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

//Виджет отображения ошибки
class _ErrorPlaceHolder extends StatelessWidget {
  const _ErrorPlaceHolder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyIcon(
            asset: AssetsStr.errorPlaceHolder,
            color: Theme.of(context).unselectedWidgetColor,
            height: 64,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            AppStrings.error,
            style: Theme.of(context).primaryTextTheme.headline6,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            AppStrings.errorPlaceHolderText,
            style: Theme.of(context).primaryTextTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

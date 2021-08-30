import 'package:flutter/material.dart';
import 'package:places/ui/screens/add_sight_screen.dart';
import 'package:places/ui/screens/bottom_navigation_bar.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_card.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/widgets/search_bar.dart';

class SightAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const SightAppBar({
    required this.height,
    Key? key,
  }) : super(key: key);

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
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _AppBarHeaderDelegate(),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                for (int i = 0; i < mocks.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SightCard(mocks[i]),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
      floatingActionButton: const _NewSightButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => AddSightScreen(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
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
              children: [
                MyIcon(asset: AssetsStr.icon_plus),
                const SizedBox(
                  width: 13.64,
                ),
                const Text('НОВОЕ МЕСТО'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarHeaderDelegate extends SliverPersistentHeaderDelegate {
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
              ? Container(
                  child: Column(
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Opacity(
                              child: SearchBar(),
                              opacity: 1 - shrinkOffset / 100,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: (minExtent - shrinkOffset).clamp(16, 24),
                      ),
                    ],
                  ),
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
  double get maxExtent => 240;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

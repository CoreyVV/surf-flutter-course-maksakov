import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/ui/screens/place_list_screen.dart';
import 'package:places/ui/screens/res/my_icons.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatefulWidget {
  int pageIndex;

  MyBottomNavigationBar({
    required this.pageIndex,
    Key? key,
  }) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: widget.pageIndex == 0
                ? AssetsStr.iconListFull
                : AssetsStr.bottomNavigationIconList,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: widget.pageIndex == 1
                ? AssetsStr.iconMapFull
                : AssetsStr.bottomNavigationIconMap,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: widget.pageIndex == 2
                ? AssetsStr.iconHeartFull
                : AssetsStr.bottomNavigationIconHeart,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: widget.pageIndex == 3
                ? AssetsStr.iconSettingsFull
                : AssetsStr.bottomNavigationIconSettings,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: '',
        ),
      ],
      onTap: (index) {
        setState(() {
          widget.pageIndex = index;

        });
        if (index == 1) {
          context.read<PlaceInteractor>().getListPlacesStream;
        }
        _navigate(index);
      },
    );
  }

  void _navigate(int index) {
    switch (index) {
      case 0:
        {
          Navigator.of(context).pushReplacement<void, void>(
            MaterialPageRoute(
              builder: (_) => const PlaceListScreen(),
            ),
          );
          break;
        }
      case 1:
        {
          Navigator.of(context).pushReplacement<void, void>(
            MaterialPageRoute(
              builder: (_) => const PlaceListScreen(),
            ),
          );
          break;
        }
      case 2:
        {
          Navigator.of(context).pushReplacement<void, void>(
            MaterialPageRoute(
              builder: (_) => const VisitingScreen(),
            ),
          );
          break;
        }
      case 3:
        {
          Navigator.of(context).pushReplacement<void, void>(
            MaterialPageRoute(
              builder: (_) => const SettingsScreen(),
            ),
          );
          break;
        }
    }
  }
}

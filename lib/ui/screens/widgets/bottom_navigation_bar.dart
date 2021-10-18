import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/main.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';

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
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: widget.pageIndex == 1
                ? AssetsStr.iconMapFull
                : AssetsStr.bottomNavigationIconMap,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: widget.pageIndex == 2
                ? AssetsStr.iconHeartFull
                : AssetsStr.bottomNavigationIconHeart,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: widget.pageIndex == 3
                ? AssetsStr.iconSettingsFull
                : AssetsStr.bottomNavigationIconSettings,
          ),
          label: '',
        ),
      ],
      onTap: (index) {
        setState(() {
          widget.pageIndex = index;

        });
        if (index == 1) {
          placeInteractor.getListPlaces;
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
              builder: (_) => const SightListScreen(),
            ),
          );
          break;
        }
      case 1:
        {
          Navigator.of(context).pushReplacement<void, void>(
            MaterialPageRoute(
              builder: (_) => const SightListScreen(),
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

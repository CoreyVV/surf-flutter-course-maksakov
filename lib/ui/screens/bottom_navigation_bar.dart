import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: AssetsStr.bottom_navigation_icon_list,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: AssetsStr.bottom_navigation_icon_map,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: AssetsStr.bottom_navigation_icon_heart,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            asset: AssetsStr.bottom_navigation_icon_settings,
          ),
          label: '',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => SightListScreen(),
                ),
              );
              break;
            }
          case 1:
            {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => SightListScreen(),
                ),
              );
              break;
            }
          case 2:
            {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => VisitingScreen(),
                ),
              );
              break;
            }
          case 3:
            {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => SettingsScreen(),
                ),
              );
              break;
            }
        }
      },
    );
  }
}

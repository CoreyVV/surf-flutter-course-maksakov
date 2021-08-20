import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/icons.dart';

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
    );
  }
}

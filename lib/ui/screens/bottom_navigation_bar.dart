import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/screens/res/icons.dart';

class MyBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
            icon: MyIcons.bbottom_navigation_icon_list, label: ''),
        BottomNavigationBarItem(
            icon: MyIcons.bottom_navigation_icon_map, label: ''),
        BottomNavigationBarItem(
            icon: MyIcons.bottom_navigation_icon_heart_full, label: ''),
        BottomNavigationBarItem(
            icon: MyIcons.bottom_navigation_icon_settings, label: ''),
      ],
    );
  }
}

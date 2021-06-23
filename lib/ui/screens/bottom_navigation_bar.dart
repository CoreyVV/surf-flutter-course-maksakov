import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'res/icons/bottom_navigation-icon-list.svg',
              height: 24,
              width: 24,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'res/icons/bottom_navigation-icon-map.svg',
              height: 24,
              width: 24,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'res/icons/bottom_navigation-icon-heart-full.svg',
              height: 24,
              width: 24,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'res/icons/bottom_navigation-icon-settings.svg',
              height: 24,
              width: 24,
            ),
            label: ''),
      ],
    );
  }
}

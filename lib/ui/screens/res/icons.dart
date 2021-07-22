import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIcons {
//bottom navigation bars icons
  static final SvgPicture icon_close =
      SvgPicture.asset('res/icons/icon-close.svg');
  static final SvgPicture icon_heart =
      SvgPicture.asset('res/icons/icon-heart.svg');

// light theme catalogs icons
  static final SvgPicture catalog_white_cafe =
      SvgPicture.asset('res/icons/catalog-white-cafe.svg');
  static final SvgPicture catalog_white_hotel =
      SvgPicture.asset('res/icons/catalog-white-hotel.svg');
  static final SvgPicture catalog_white_museum =
      SvgPicture.asset('res/icons/catalog-white-museum.svg');
  static final SvgPicture catalog_white_park =
      SvgPicture.asset('res/icons/catalog-white-park.svg');
  static final SvgPicture catalog_white_particular_place =
      SvgPicture.asset('res/icons/catalog-white-particular_place.svg');
  static final SvgPicture catalog_white_restourant =
      SvgPicture.asset('res/icons/catalog-white-restourant.svg');

  //other icons
  static final SvgPicture icon_arrow = SvgPicture.asset(
    'res/icons/icon-arrow.svg',
    color: Colors.black,
  );
  static final SvgPicture icon_tick_choice =
      SvgPicture.asset('res/icons/icon-tick_choice.svg');

  static final SvgPicture icon_info = SvgPicture.asset(
    'res/icons/icon-info.svg',
  );
}

class MyIcon extends StatelessWidget {
  final String asset;
  final Color? color;

  const MyIcon({
    required this.asset,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    Color iconColor = color ?? iconTheme.color!;
    return SvgPicture.asset(
      this.asset,
      color: iconColor,
    );
  }
}

class AssetsStr {
  static final String bottom_navigation_icon_heart =
      'res/icons/bottom_navigation-icon-heart.svg';
  static final String bottom_navigation_icon_list =
      'res/icons/bottom_navigation-icon-list.svg';
  static final String bottom_navigation_icon_map =
      'res/icons/bottom_navigation-icon-map.svg';
  static final String bottom_navigation_icon_settings =
      'res/icons/bottom_navigation-icon-settings.svg';
  static final String icon_view = 'res/icons/icon-view.svg';
  static final String icon_clear = 'res/icons/icon-clear.svg';
  static final String icon_arrow = 'res/icons/header-icon-arrow.svg';
  static final String icon_tick = 'res/icons/icon-tick.svg';
}

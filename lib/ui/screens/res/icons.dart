import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//TODO добавить зависимость цвета иконок от темы приложения

class MyIcons {
//bottom navigation bars icons
  static final SvgPicture icon_close =
      SvgPicture.asset('res/icons/icon-close.svg');
  static final SvgPicture icon_heart =
      SvgPicture.asset('res/icons/icon-heart.svg');
  static final SvgPicture bottom_navigation_icon_heart_full =
      SvgPicture.asset('res/icons/bottom_navigation-icon-heart-full.svg');
  static final SvgPicture bbottom_navigation_icon_list =
      SvgPicture.asset('res/icons/bottom_navigation-icon-list.svg');
  static final SvgPicture bottom_navigation_icon_map =
      SvgPicture.asset('res/icons/bottom_navigation-icon-map.svg');
  static final SvgPicture bottom_navigation_icon_settings =
      SvgPicture.asset('res/icons/bottom_navigation-icon-settings.svg');

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
}

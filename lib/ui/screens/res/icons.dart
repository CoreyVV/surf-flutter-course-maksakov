import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIcons {
//bottom navigation bars icons
  static final SvgPicture iconClose =
      SvgPicture.asset('res/icons/icon-close.svg');
  static final SvgPicture iconHeart =
      SvgPicture.asset('res/icons/icon-heart.svg');

// light theme catalogs icons
  static final SvgPicture catalogWhiteCafe =
      SvgPicture.asset('res/icons/catalog-white-cafe.svg');
  static final SvgPicture catalogWhiteHotel =
      SvgPicture.asset('res/icons/catalog-white-hotel.svg');
  static final SvgPicture catalogWhiteMuseum =
      SvgPicture.asset('res/icons/catalog-white-museum.svg');
  static final SvgPicture catalogWhitePark =
      SvgPicture.asset('res/icons/catalog-white-park.svg');
  static final SvgPicture catalogWhiteParticularPlace =
      SvgPicture.asset('res/icons/catalog-white-particular_place.svg');
  static final SvgPicture catalogWhiteRestaurant =
      SvgPicture.asset('res/icons/catalog-white-restaurant.svg');

  //other icons
  static final SvgPicture iconArrow = SvgPicture.asset(
    'res/icons/icon-arrow.svg',
    color: Colors.black,
  );
  static final SvgPicture iconTickChoice =
      SvgPicture.asset('res/icons/icon-tick_choice.svg');

  static final SvgPicture iconInfo = SvgPicture.asset(
    'res/icons/icon-info.svg',
  );
}

class MyIcon extends StatelessWidget {
  final String asset;
  final Color? color;
  final double? height;
  final BoxFit fit;

  const MyIcon({
    required this.asset,
    this.color,
    this.height,
    this.fit = BoxFit.contain,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final Color iconColor = color ?? iconTheme.color!;
    
    return SvgPicture.asset(
      asset,
      color: iconColor,
      height: height,
      fit: fit,
    );
  }
}

class AssetsStr {
  static const String bottomNavigationIconHeart =
      'res/icons/bottom_navigation-icon-heart.svg';
  static const String bottomNavigationIconList =
      'res/icons/bottom_navigation-icon-list.svg';
  static const String bottomNavigationIconMap =
      'res/icons/bottom_navigation-icon-map.svg';
  static const String bottomNavigationIconSettings =
      'res/icons/bottom_navigation-icon-settings.svg';
  static const String iconView = 'res/icons/icon-view.svg';
  static const String iconClear = 'res/icons/icon-clear.svg';
  static const String iconArrow = 'res/icons/header-icon-arrow.svg';
  static const String iconTick = 'res/icons/icon-tick.svg';
  static const String iconPlus = 'res/icons/icon-plus.svg';
  static const String search = 'res/icons/Search.svg';
  static const String filter = 'res/icons/Filter.svg';
  static const String delete = 'res/icons/Delete.svg';
  static const String card = 'res/icons/card.svg';
  static const String go = 'res/icons/GO.svg';
  static const String buttonWhitePlus = 'res/icons/Button-White-Plus.svg';
  static const String iconBucket = 'res/icons/Icon-Bucket.svg';
  static const String iconCalendar = 'res/icons/icon-calendar.svg';
  static const String buttonWhiteIconGo =
      'res/icons/button-white-icon-go.svg';
  static const String headerIconArrow = 'res/icons/header-icon-arrow.svg';
  static const String iconHeart = 'res/icons/icon-heart.svg';
  static const String tutorial1Frame = 'res/icons/Tutorial 1 frame.svg';
  static const String tutorial2Frame = 'res/icons/Tutorial 2 frame.svg';
  static const String tutorial3Frame = 'res/icons/Tutorial 3 frame.svg';
  static const String subtract = 'res/icons/Subtract.svg';
  static const String iconShare = 'res/icons/icon-share.svg';
  static const String iconClose = 'res/icons/icon-close.svg';
  static const String iconHeartFull = 'res/icons/Icon-Heart Full.svg';
  static const String iconListFull = 'res/icons/Icon-List Full.svg';
  static const String iconMapFull = 'res/icons/Icon-Map Full.svg';
  static const String iconSettingsFull = 'res/icons/Icon-Settings-fill.svg';
  static const String iconPhoto = 'res/icons/Icon-Photo.svg';
  static const String iconFail = 'res/icons/Icon-Fail.svg';
  static const String iconCamera = 'res/icons/Icon-Camera.svg';
}

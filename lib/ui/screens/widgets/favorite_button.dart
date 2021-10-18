import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/main.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';

class FavoriteButton extends StatefulWidget {
  final Place place;

  const FavoriteButton({required this.place, Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        highlightColor: greenWhite.withOpacity(0.24),
        splashColor: greenWhite.withOpacity(0.12),
        onTap: () {
          print('SightCard/iconHeart was tapped');
          setState(() {
            favoritePlaceInteractor.setFavorite(widget.place);
          });
        },
        child: Ink(
          child: MyIcon(
            asset: favoritePlaceInteractor.isFavorite(widget.place)
                ? AssetsStr.iconHeartFull
                : AssetsStr.iconHeart,
          ),
        ),
      ),
    );
  }
}
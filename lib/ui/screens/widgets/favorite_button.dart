import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/interactor/favorite_place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/my_icons.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  final Place place;

  const FavoriteButton({required this.place, Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}
//добавил стримконтроллер в виджет отображения иконки избранного и перестроил
//логику работы с учетом стрима
class _FavoriteButtonState extends State<FavoriteButton> {
  final StreamController<bool> _streamController = StreamController();
  late bool _isFavoriteNow;
  late FavoritePlaceInteractor _favoritePlaceInteractor;

  @override
  void initState() {
    _favoritePlaceInteractor = context.read<FavoritePlaceInteractor>();
    _isFavoriteNow = _favoritePlaceInteractor.isFavorite(widget.place);
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _streamController.stream,
      initialData: _isFavoriteNow,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _isFavoriteNow = snapshot.data!;

          return Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              highlightColor: greenWhite.withOpacity(0.24),
              splashColor: greenWhite.withOpacity(0.12),
              onTap: () {
                //TODO: убрать print
                print('SightCard/iconHeart was tapped');
                _streamController.sink.add(!_isFavoriteNow);
                _favoritePlaceInteractor.setFavorite(widget.place);
              },
              child: Ink(
                child: MyIcon(
                  asset: _isFavoriteNow
                      ? AssetsStr.iconHeartFull
                      : AssetsStr.iconHeart,
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

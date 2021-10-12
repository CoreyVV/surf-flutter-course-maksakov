import 'dart:async';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_details.dart';
import 'package:places/ui/screens/widgets/loading_builder.dart';

class PlaceCard extends StatefulWidget {
  final Place place;

  const PlaceCard({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  final _btnFavoriteController = StreamController<bool>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: double.infinity,
        height: 188,
        child: Stack(
          children: [
            _Base(
              place: widget.place,
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.hardEdge,
              child: Ink(
                child: InkWell(
                  highlightColor: greenWhite.withOpacity(0.24),
                  splashColor: greenWhite.withOpacity(0.12),
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (_) {
                        return PlaceDetails(
                          id: widget.place.id,
                        );
                      },
                      isScrollControlled: true,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                widget.place.placeType,
                style: Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
              ),
            ),
            Positioned(
              top: 19,
              right: 18,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  highlightColor: greenWhite.withOpacity(0.24),
                  splashColor: greenWhite.withOpacity(0.12),
                  onTap: () {
                    print('SightCard/iconHeart was tapped');
                    _onBtnFavorite();
                  },
                  child: Ink(
    //Не совсем понял как использовать стрим
    // при обработке нажатия на "добавить в избранное".
    // В текущем варианте после перерисовки состояние иконки не сохранится
                    child: StreamBuilder<Object>(
                      stream: _btnFavoriteController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.data == true) {
                          return const MyIcon(asset: AssetsStr.iconHeartFull);
                        } else {
                          return const MyIcon(asset: AssetsStr.iconHeart);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _btnFavoriteController.close();
    super.dispose();
  }

  void _onBtnFavorite() {
    if (placeInteractor.isFavorite(widget.place)) {
      placeInteractor.removeFromFavorites(widget.place);
      _btnFavoriteController.sink.add(false);
    } else {
      placeInteractor.addToFavorites(widget.place);
      _btnFavoriteController.sink.add(true);
    }
  }
}

class _Base extends StatelessWidget {
  final Place place;

  const _Base({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 96,
          child: Image.network(
            place.urls[0],
            loadingBuilder: loadingBuilder,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          height: 92,
          color: Theme.of(context).primaryColorDark,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 328),
                  child: Text(
                    place.name,
                    maxLines: 2,
                    style: Theme.of(context).accentTextTheme.bodyText1,
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 328),
                  child: Text(
                    place.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

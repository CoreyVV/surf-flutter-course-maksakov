import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screens/place_details.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/widgets/favorite_button.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: double.infinity,
        height: 188,
        child: Stack(
          children: [
            _Base(
              place: place,
            ),
            Material(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                          id: place.id,
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
                place.placeType,
                style: Theme.of(context).textTheme.button,
              ),
            ),
            Positioned(
              top: 19,
              right: 18,
              child: FavoriteButton(
                place: place,
              ),
            ),
          ],
        ),
      ),
    );
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
            place.urls.first,
            // loadingBuilder: loadingBuilder,
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
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
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

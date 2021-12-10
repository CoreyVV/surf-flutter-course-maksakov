import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screens/place_details.dart';
import 'package:places/ui/screens/res/app_strings.dart';
import 'package:places/ui/screens/res/my_icons.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

class PlaceCardFavorite extends StatelessWidget {
  final Place place;
  final void Function() onRemove;

  const PlaceCardFavorite({
    required Key key,
    required this.place,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: InkWell(
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
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Column(
            children: [
              _ImagePart(
                place: place,
                onRemove: onRemove,
              ),
              Container(
                width: 360,
                height: 122,
                color: Theme.of(context).colorScheme.background,
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Text(
                        place.name,
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 2,
                      ),
                    ),
                    Positioned(
                      top: 38,
                      left: 16,
                      child: context.read<PlaceInteractor>().isVisited(place)
                          ? Text(
                              'Цель достигнута 12 окт. 2020',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText2,
                            )
                          : Text(
                              'Запланировано на 12 окт. 2020',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText2!
                                  .copyWith(color: Theme.of(context).colorScheme.green),
                            ),
                    ),
                    Positioned(
                      top: 68,
                      left: 16,
                      child: Text(
                        'закрыто до 09:00',
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconCalendar extends StatelessWidget {
  const _IconCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final res = await _onCalendarPressed(context);
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // color: Colors.transparent,
          ),
          width: 24,
          height: 24,
          child: const MyIcon(
            asset: AssetsStr.iconCalendar,
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _onCalendarPressed(BuildContext context) async {
    DateTime? _date;
    _date = Platform.isIOS
        ? await showDialog(
            context: context,
            builder: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 240,
                          color: Theme.of(context).colorScheme.red,
                          child: CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              onDateTimeChanged: (datetime) {},
                              minimumDate: DateTime.now()
                                  .subtract(const Duration(days: 1)),),),
                    ],),)
        : await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2120),
            fieldLabelText: AppStrings.dataPickerLabelText,
            helpText: AppStrings.dataPickerHelpText,);

    return _date;
  }
}

class _IconShare extends StatelessWidget {
  const _IconShare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          //TODO: убрать print
          print('sight_planned/share was tapped');
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: 24,
          height: 24,
          child: const MyIcon(
            asset: AssetsStr.iconShare,
          ),
        ),
      ),
    );
  }
}

class _IconRemove extends StatelessWidget {
  final VoidCallback onTap;

  const _IconRemove({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.transparent,
          ),
          width: 24,
          height: 24,
          child: const MyIcon(
            asset: AssetsStr.iconClose,
          ),
        ),
      ),
    );
  }
}

class _ImagePart extends StatelessWidget {
  final Place place;
  final VoidCallback onRemove;

  const _ImagePart({
    required this.place,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 96,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Theme.of(context).colorScheme.red,
            ),
          ),
          Image.network(
            place.urls.first,
            // loadingBuilder: loadingBuilder,
            fit: BoxFit.cover,
            width: 360,
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Text(
              place.placeType,
              style: Theme.of(context)
                  .textTheme
                  .button,
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: _IconRemove(
              onTap: onRemove,
            ),
          ),
          if (context.read<PlaceInteractor>().isVisited(place))
            const Positioned(
              top: 16,
              right: 56,
              child: _IconShare(),
            )
          else
            const Positioned(
              top: 16,
              right: 56,
              child: _IconCalendar(),
            ),
        ],
      ),
    );
  }
}

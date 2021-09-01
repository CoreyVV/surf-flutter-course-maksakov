import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_details.dart';
import 'package:places/ui/screens/widgets/loading_builder.dart';

class SightCardFavorite extends StatelessWidget {
  final Sight sight;
  final void Function() onRemove;

  const SightCardFavorite({
    required Key key,
    required this.sight,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (_) => SightDetails(
                id: sight.id,
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              _ImagePart(
                sight: sight,
                onRemove: onRemove,
              ),
              Container(
                width: 360,
                height: 122,
                color: Theme.of(context).primaryColorDark,
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Text(
                        sight.name,
                        style: Theme.of(context).accentTextTheme.bodyText1,
                        maxLines: 2,
                      ),
                    ),
                    Positioned(
                      top: 38,
                      left: 16,
                      child: sight.isVisited
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
                                  .copyWith(color: green),
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
        onTap: () {
          print('sight_planned/calendar was tapped');
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
}

class _IconShare extends StatelessWidget {
  const _IconShare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('sight_planned/share was tapped');
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Colors.transparent,
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
  final Sight sight;
  final VoidCallback onRemove;


  const _ImagePart({
    required this.sight,
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
              color: Theme.of(context).primaryColor,
            ),
          ),
          Image.network(
            sight.url,
            loadingBuilder: loadingBuilder,
            fit: BoxFit.cover,
            width: 360,
            // height: double.infinity,
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Text(
              sight.type,
              style: Theme.of(context)
                  .accentTextTheme
                  .button!
                  .copyWith(color: white),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: _IconRemove(
              onTap: onRemove,
            ),
          ),
          if (sight.isVisited)
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

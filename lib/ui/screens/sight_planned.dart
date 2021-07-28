import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screens/res/colors.dart';

class SightCardPlanned extends StatelessWidget {
  final Sight sight;
  final void Function() onRemove;

  const SightCardPlanned({
    required this.sight,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 96,
              child: Stack(
                children: [
                  Image.network(
                    sight.url,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
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
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                        child: SvgPicture.asset(
                          'res/icons/icon-close.svg',
                        ),
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {
                        onRemove();
                      },
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 56,
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.transparent,
                        ),
                        child: SvgPicture.asset(
                          'res/icons/icon-calendar.svg',
                        ),
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {
                        print('sight_planned/calendar was tapped');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 102,
              color: Theme.of(context).primaryColorDark,
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      sight.name,
                      style: Theme.of(context).accentTextTheme.bodyText1,
                    ),
                  ),
                  Positioned(
                    top: 38,
                    left: 16,
                    child: Text(
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
            )
          ],
        ),
      ),
    );
  }
}

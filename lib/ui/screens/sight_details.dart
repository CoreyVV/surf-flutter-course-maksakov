import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screens/res/colors.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Container(
        height: 360,
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
              top: 36,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                width: 32,
                height: 32,
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 24, bottom: 2),
              child: Text(
                sight.name,
                style: Theme.of(context).accentTextTheme.headline5,
              ),
            ),
            Row(
              children: [
                Text(
                  sight.type,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'закрыто до 09:00',
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                )
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 16, bottom: 24),
              height: 112,
              child: Text(
                sight.details,
                style: Theme.of(context).accentTextTheme.bodyText2,
                maxLines: 4,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 24),
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'ПОСТРОИТЬ МАРШРУТ',
                style: Theme.of(context)
                    .accentTextTheme
                    .button!
                    .copyWith(color: white),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 17),
              child: Row(children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Theme.of(context).unselectedWidgetColor,
                ),
                SizedBox(width: 9),
                Text(
                  'Запланировать',
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                ),
                SizedBox(width: 40),
                Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(width: 9),
                Text(
                  'В избранное',
                  style: Theme.of(context).accentTextTheme.bodyText2,
                )
              ]),
            )
          ],
        ),
      ),
    ]));
  }
}

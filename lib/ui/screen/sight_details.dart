import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Container(
        color: Colors.blueGrey,
        height: 360,
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
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  sight.type,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'закрыто до 09:00',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Roboto',
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 16, bottom: 24),
              height: 72,
              child: Text(
                sight.details,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Roboto',
                ),
                maxLines: 4,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 24),
              height: 48,
              color: Colors.green,
              child: Text(
                'ПОСТРОИТЬ МАРШРУТ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 17),
              child: Row(children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                SizedBox(width: 9),
                Text(
                  'Запланировать',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(width: 40),
                Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
                SizedBox(width: 9),
                Text(
                  'В избранное',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Roboto',
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    ]));
  }
}

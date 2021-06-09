import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightCardVisited extends StatelessWidget {
  final Sight sight;

  const SightCardVisited(this.sight);

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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                      top: 16,
                      right: 56,
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Container(
              // padding: EdgeInsets.only(left: 16, top: 16, right: 16),
              width: double.infinity,
              height: 102,
              color: Color(0xFFF5F5F5),
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      sight.name,
                      style: TextStyle(
                        color: Color(0xFF3B3E5B),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 38,
                    left: 16,
                    child: Text(
                      'Запланировано на 12 окт. 2020',
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 68,
                    left: 16,
                    child: Text(
                      'закрыто до 09:00',
                      style: TextStyle(
                        color: Color(0xFF7C7E92),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                      ),
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

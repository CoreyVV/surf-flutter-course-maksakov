import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screens/res/colors.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: [
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
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: SvgPicture.asset(
                          'res/icons/header-icon-arrow.svg',
                          color: Theme.of(context).primaryIconTheme.color,
                          // color: Colors.black,
                        ),
                        width: 32,
                        height: 32,
                      ),
                      onTap: () {
                        print('sight_details/back was tapped');
                      },
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
                            .accentTextTheme
                            .bodyText2!
                            .copyWith(
                              fontWeight: FontWeight.w700,
                            ),
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
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: SizedBox(
                      height: 48,
                      width: 328,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          print('sight_details/go was tapped');
                        },
                        icon: SvgPicture.asset(
                            'res/icons/button-white-icon-go.svg'),
                        label: Text(
                          'ПОСТРОИТЬ МАРШРУТ',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                      width: 0.8,
                      color: Theme.of(context).unselectedWidgetColor,
                    ))),
                    padding: EdgeInsets.only(
                      left: 17,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 19),
                      child: Row(
                        children: [
                          InkWell(
                            child: Container(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SvgPicture.asset(
                                          'res/icons/icon-calendar.svg'),
                                    ),
                                    WidgetSpan(child: SizedBox(width: 9)),
                                    TextSpan(
                                      text: 'Запланировать',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              print('sight_details/planned was tapped');
                            },
                          ),
                          SizedBox(width: 40),
                          InkWell(
                            child: Container(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SvgPicture.asset(
                                        'res/icons/icon-heart.svg',
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    WidgetSpan(child: SizedBox(width: 9)),
                                    TextSpan(
                                      text: 'В Избранное',
                                      style: Theme.of(context)
                                          .accentTextTheme
                                          .bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              print('sight_details/favorite was tapped');
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

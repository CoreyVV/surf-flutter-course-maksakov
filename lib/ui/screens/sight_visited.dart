import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screens/res/colors.dart';

class SightCardVisited extends StatelessWidget {
  final Sight sight;
  final void Function() onRemove;
  final Key key;

  const SightCardVisited({
    required this.key,
    required this.sight,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          SizedBox(
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
                  child: Material(
                    color: Colors.transparent,
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
                ),
                Positioned(
                  top: 16,
                  right: 56,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.transparent,
                        ),
                        child: SvgPicture.asset(
                          'res/icons/icon-share.svg',
                        ),
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {
                        print('sight_planned/share was tapped');
                      },
                    ),
                  ),
                ),
              ],
            ),
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
                  child: Text(
                    'Цель достигнута 12 окт. 2020',
                    style: Theme.of(context).primaryTextTheme.bodyText2,
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
    );
  }
}

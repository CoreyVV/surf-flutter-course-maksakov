import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/sight_details.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: double.infinity,
        height: 188,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 96,
                  child: Image.network(
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
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  height: 92,
                  color: Theme.of(context).primaryColorDark,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(width: 328),
                          child: Text(
                            sight.name,
                            maxLines: 2,
                            style: Theme.of(context).accentTextTheme.bodyText1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(width: 328),
                          child: Text(
                            sight.details,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SightDetails(
                          id: sight.id,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                sight.type,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SightDetails(id: sight.id),
                      ),
                    );
                  },
                  child: Ink(
                    child: SvgPicture.asset(
                      'res/icons/icon-heart.svg',
                      height: 24,
                      width: 24,
                      color: white,
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
}

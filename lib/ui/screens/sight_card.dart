import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              Container(
                height: 132,
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
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Text(
                        sight.type,
                        style: Theme.of(context)
                            .accentTextTheme
                            .bodyText2!
                            .copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    Positioned(
                      top: 19,
                      right: 18,
                      child: Icon(
                        Icons.favorite_border,
                      ),
                    ),
                  ],
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
        ),
      ),
    );
  }
}

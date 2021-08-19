import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screens/res/icons.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails({
    required this.sight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _HeaderDelegate(
              child: _SightsImages(
                sight: sight,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  _SightsTexts(sight: sight),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 24,
                    ),
                    child: _ButtonGoTo(),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 0.8,
                          color: Theme.of(context).unselectedWidgetColor,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: 17,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 19,
                      ),
                      child: Row(
                        children: [
                          _Button(
                            title: 'Запланировать',
                            asset: AssetsStr.icon_calendar,
                          ),
                          const SizedBox(width: 40),
                          _Button(
                            title: 'В избранное',
                            asset: AssetsStr.icon_heart,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SightsImages extends StatefulWidget {
  final Sight sight;
  const _SightsImages({
    required this.sight,
    Key? key,
  }) : super(key: key);

  @override
  __SightsImagesState createState() => __SightsImagesState();
}

class __SightsImagesState extends State<_SightsImages> {
  final PageController _pageController = PageController();
  int _currentPageValue = 0;

  void _getChangedPageAndMoveBar(int page) {
    _currentPageValue = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      width: 392,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.sight.images.length,
            onPageChanged: _getChangedPageAndMoveBar,
            itemBuilder: (BuildContext context, int index) {
              return _Image(url: widget.sight.images[index]);
            },
          ),
          Positioned(
            top: 36,
            left: 16,
            child: InkWell(
              onTap: () {
                print('sight_details/back was tapped');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                width: 32,
                height: 32,
                child: MyIcon(
                  asset: AssetsStr.header_icon_arrow,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Row(
              children: [
                for (int i = 0; i < widget.sight.images.length; i++)
                  _MyIndicator(
                    isActive: i == _currentPageValue,
                    width: 392 / widget.sight.images.length,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MyIndicator extends StatelessWidget {
  final bool isActive;
  final double width;
  const _MyIndicator({
    required this.isActive,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isActive ? Theme.of(context).indicatorColor : Colors.transparent,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String url;
  const _Image({
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
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
      width: 397,
      height: 360,
    );
  }
}

class _ButtonGoTo extends StatelessWidget {
  const _ButtonGoTo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 328,
      child: ElevatedButton.icon(
        onPressed: () {
          print('sight_details/go was tapped');
        },
        icon: MyIcon(
          asset: AssetsStr.button_white_icon_go,
        ),
        label: const Text(
          'ПОСТРОИТЬ МАРШРУТ',
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final String asset;
  const _Button({
    required this.title,
    required this.asset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final String strInfo = 'sight_details/ $title was tapped';
        print(strInfo);
      },
      child: Container(
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: MyIcon(
                  asset: asset, //AssetsStr.icon_heart,
                  color: Theme.of(context).accentColor,
                ),
              ),
              const WidgetSpan(
                child: SizedBox(width: 9),
              ),
              TextSpan(
                text: title, //'В Избранное',
                style: Theme.of(context).accentTextTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SightsTexts extends StatelessWidget {
  final Sight sight;
  const _SightsTexts({
    required this.sight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 2,
          ),
          child: Text(
            sight.name,
            style: Theme.of(context).accentTextTheme.headline5,
          ),
        ),
        Row(
          children: [
            Text(
              sight.type,
              style: Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              'закрыто до 09:00',
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
          ],
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 24,
          ),
          height: 112,
          child: Text(
            sight.details,
            style: Theme.of(context).accentTextTheme.bodyText2,
            maxLines: 4,
          ),
        ),
      ],
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  _HeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 360.0;

  @override
  double get minExtent => 0.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    throw false;
  }
}

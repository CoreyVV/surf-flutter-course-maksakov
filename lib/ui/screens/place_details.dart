import 'package:flutter/material.dart';
import 'package:places/data/interactor/favorite_place_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screens/res/app_strings.dart';
import 'package:places/ui/screens/res/my_icons.dart';
import 'package:provider/provider.dart';

class PlaceDetails extends StatelessWidget {
  final int id;

  const PlaceDetails({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Place>(
      future: context.read<PlaceInteractor>().getPlaceDetails(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final place = snapshot.data!;

        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Material(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: _HeaderDelegate(
                        child: _PlaceImages(
                          place: place,
                        ),
                      ),
                    ),
                    _PlaceDetails(
                      place: place,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PlaceDetails extends StatelessWidget {
  final Place place;

  const _PlaceDetails({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            _PlaceTexts(place: place),
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
                      title: AppStrings.schedule,
                      asset: AssetsStr.iconCalendar,
                      onTap: () {
                        //TODO: убрать print
                        print('SightDetails/iconCalendar was tapped');
                      },
                    ),
                    const SizedBox(width: 40),
                    _Button(
                      title: AppStrings.addToFavorites,
                      asset: AssetsStr.iconHeart,
                      onTap: () {
                        //TODO(vv): убрать print, See https://link/todo.
                        print('SightDetails/iconHeart was tapped');
                        context
                            .read<FavoritePlaceInteractor>()
                            .setFavorite(place);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceImages extends StatefulWidget {
  final Place place;

  const _PlaceImages({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  _PlaceImagesState createState() => _PlaceImagesState();
}

class _PlaceImagesState extends State<_PlaceImages> {
  final PageController _pageController = PageController();
  int _currentPageValue = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      width: 392,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.place.urls.length,
            onPageChanged: _getChangedPageAndMoveBar,
            itemBuilder: (context, index) {
              return _Image(url: widget.place.urls[index]);
            },
          ),
          Positioned(
            top: 16,
            right: 16,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).primaryColor,
                ),
                width: 40,
                height: 40,
                child: MyIcon(
                  asset: AssetsStr.iconClose,
                  color: Theme.of(context).primaryIconTheme.color,
                  height: 12,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Row(
              children: [
                for (int i = 0; i < widget.place.urls.length; i++)
                  _MyIndicator(
                    isActive: i == _currentPageValue,
                    width: 392 / widget.place.urls.length,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _getChangedPageAndMoveBar(int page) {
    _currentPageValue = page;
    setState(() {});
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
        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
      // loadingBuilder: loadingBuilder,
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
          //TODO: убрать print
          print('sight_details/go was tapped');
        },
        icon: const MyIcon(
          asset: AssetsStr.buttonWhiteIconGo,
        ),
        label: const Text(
          AppStrings.createRouteUppercase,
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final String asset;
  final VoidCallback onTap;

  const _Button({
    required this.title,
    required this.asset,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: MyIcon(
                  asset: asset,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const WidgetSpan(
                child: SizedBox(width: 9),
              ),
              TextSpan(
                text: title,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceTexts extends StatelessWidget {
  final Place place;

  const _PlaceTexts({
    required this.place,
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
            place.name,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
        ),
        Row(
          children: [
            Text(
              place.placeType,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
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
            place.description,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
            maxLines: 4,
          ),
        ),
      ],
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  @override
  double get maxExtent => 360.0;

  @override
  double get minExtent => 0.0;

  _HeaderDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

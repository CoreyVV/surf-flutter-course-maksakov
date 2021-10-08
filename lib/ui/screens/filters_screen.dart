import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/services/location_service.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_list_screen.dart';

int _amountFilteredPlaces = 0;

const double _searchMinDistance = 100;
const double _searchMaxDistance = 10000;
const double _searchDistanceStep = 100;
final int _searchDivisions =
    ((_searchMaxDistance - _searchMinDistance) / _searchDistanceStep).round();
late RangeValues _currentRangeValues;

//класс типа места с иконкой и заголовком
class SightTypeIcon {
  final String type;
  final String title;
  final SvgPicture icon;

  SightTypeIcon({
    required this.title,
    required this.type,
    required this.icon,
  });

  @override
  String toString() {
    return title;
  }
}

//типы мест для таблицы фильтров
final sightTypeIconCafe = SightTypeIcon(
  title: 'Кафе',
  type: SightType.cafe,
  icon: MyIcons.catalogWhiteCafe,
);
final sightTypeIconHotel = SightTypeIcon(
  title: 'Отель',
  type: SightType.hotel,
  icon: MyIcons.catalogWhiteHotel,
);
final sightTypeIconMuseum = SightTypeIcon(
  title: 'Музей',
  type: SightType.museum,
  icon: MyIcons.catalogWhiteMuseum,
);
final sightTypeIconPark = SightTypeIcon(
  title: 'Парк',
  type: SightType.park,
  icon: MyIcons.catalogWhitePark,
);
final sightTypeIconParticularPlace = SightTypeIcon(
  title: 'Особое место',
  type: SightType.particularPlace,
  icon: MyIcons.catalogWhiteParticularPlace,
);
final sightTypeIconRestaurant = SightTypeIcon(
  title: 'Ресторан',
  type: SightType.restaurant,
  icon: MyIcons.catalogWhiteRestaurant,
);

//храним значение таблицы фильтров
Map<SightTypeIcon, bool> filterMap = {
  sightTypeIconCafe: false,
  sightTypeIconHotel: false,
  sightTypeIconMuseum: false,
  sightTypeIconPark: false,
  sightTypeIconParticularPlace: false,
  sightTypeIconRestaurant: false,
};
List<String> filterList = [];

//экран фильтров
class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final isSmallScreenResolution =
        MediaQuery.of(context).size.height <= 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: SizedBox(
            height: 32,
            width: 32,
            child: IconButton(
              splashRadius: 16,
              onPressed: () {
                print('filter_screen/back was tapped');
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SightListScreen(),
                  ),
                );
              },
              icon: MyIcons.iconArrow,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: TextButton(
              onPressed: () {
                print('filter_screen/clear was tapped');
                setState(() {
                  filterMap.updateAll((key, value) => false);
                  filterList.clear();
                });
              },
              child: Text(
                'Очистить',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).buttonColor),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (isSmallScreenResolution)
            TypeFilterSmall(onTap: (key) {
              setState(() {
                filterMap[key] = !filterMap[key]!;
                filterMap[key]!
                    ? filterList.add(key.type)
                    : filterList.remove(key.type);
              });
            })
          else
            TypeFilter(onTap: (key) {
              setState(() {
                filterMap[key] = !filterMap[key]!;
                filterMap[key]!
                    ? filterList.add(key.type)
                    : filterList.remove(key.type);
              });
            }),
          const DistanceFilter(),
          const ShowButton(),
        ],
      ),
    );
  }
}

//фильтр с таблицей типов мест для низких разрешений
class TypeFilterSmall extends StatelessWidget {
  // const TypeFilter({Key? key}) : super(key: key);
  final Function(SightTypeIcon) onTap;

  const TypeFilterSmall({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: long-method
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 24),
        height: 120,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: 96,
              height: 92,
              child: Column(
                children: [
                  TypeFilterBox(
                    sightTypeIcon: sightTypeIconHotel,
                    onTap: () => onTap(sightTypeIconHotel),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    sightTypeIconHotel.title,
                    style:
                        Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              width: 96,
              height: 92,
              child: Column(
                children: [
                  TypeFilterBox(
                    sightTypeIcon: sightTypeIconRestaurant,
                    onTap: () => onTap(sightTypeIconRestaurant),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    sightTypeIconRestaurant.title,
                    style:
                        Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              width: 96,
              height: 92,
              child: Column(
                children: [
                  TypeFilterBox(
                    sightTypeIcon: sightTypeIconParticularPlace,
                    onTap: () => onTap(sightTypeIconParticularPlace),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    sightTypeIconParticularPlace.title,
                    style:
                        Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 96,
              height: 92,
              child: Column(
                children: [
                  TypeFilterBox(
                    sightTypeIcon: sightTypeIconPark,
                    onTap: () => onTap(sightTypeIconPark),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    sightTypeIconPark.title,
                    style:
                        Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              width: 96,
              height: 92,
              child: Column(
                children: [
                  TypeFilterBox(
                    sightTypeIcon: sightTypeIconMuseum,
                    onTap: () => onTap(sightTypeIconMuseum),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    sightTypeIconMuseum.title,
                    style:
                        Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              width: 96,
              height: 92,
              child: Column(
                children: [
                  TypeFilterBox(
                    sightTypeIcon: sightTypeIconCafe,
                    onTap: () => onTap(sightTypeIconCafe),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    sightTypeIconCafe.title,
                    style:
                        Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//фильтр с таблицей типов мест
class TypeFilter extends StatelessWidget {
  // const TypeFilter({Key? key}) : super(key: key);
  final Function(SightTypeIcon) onTap;

  const TypeFilter({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: long-method
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.5, right: 16.5, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 96,
                  height: 92,
                  child: Column(
                    children: [
                      TypeFilterBox(
                        sightTypeIcon: sightTypeIconHotel,
                        onTap: () => onTap(sightTypeIconHotel),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        sightTypeIconHotel.title,
                        style: Theme.of(context)
                            .accentTextTheme
                            .bodyText2!
                            .copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 96,
                  height: 92,
                  child: Column(
                    children: [
                      TypeFilterBox(
                        sightTypeIcon: sightTypeIconRestaurant,
                        onTap: () => onTap(sightTypeIconRestaurant),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        sightTypeIconRestaurant.title,
                        style: Theme.of(context)
                            .accentTextTheme
                            .bodyText2!
                            .copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 96,
                  height: 92,
                  child: Column(
                    children: [
                      TypeFilterBox(
                        sightTypeIcon: sightTypeIconParticularPlace,
                        onTap: () => onTap(sightTypeIconParticularPlace),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        sightTypeIconParticularPlace.title,
                        style: Theme.of(context)
                            .accentTextTheme
                            .bodyText2!
                            .copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.5, right: 16.5, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 96,
                  height: 92,
                  child: Column(
                    children: [
                      TypeFilterBox(
                        sightTypeIcon: sightTypeIconPark,
                        onTap: () => onTap(sightTypeIconPark),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        sightTypeIconPark.title,
                        style: Theme.of(context)
                            .accentTextTheme
                            .bodyText2!
                            .copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 96,
                  height: 92,
                  child: Column(
                    children: [
                      TypeFilterBox(
                        sightTypeIcon: sightTypeIconMuseum,
                        onTap: () => onTap(sightTypeIconMuseum),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        sightTypeIconMuseum.title,
                        style: Theme.of(context)
                            .accentTextTheme
                            .bodyText2!
                            .copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 96,
                  height: 92,
                  child: Column(
                    children: [
                      TypeFilterBox(
                        sightTypeIcon: sightTypeIconCafe,
                        onTap: () => onTap(sightTypeIconCafe),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        sightTypeIconCafe.title,
                        style: Theme.of(context)
                            .accentTextTheme
                            .bodyText2!
                            .copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//элемент таблицы фильтров по типам мест
class TypeFilterBox extends StatelessWidget {
  // const TypeFilterBox({ Key? key }) : super(key: key);

  final SightTypeIcon sightTypeIcon;
  final void Function() onTap;

  const TypeFilterBox({
    required this.sightTypeIcon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: Stack(
        children: [
          sightTypeIcon.icon,
          InkWell(
            borderRadius: BorderRadius.circular(64),
            onTap: onTap,
            child: Ink(),
          ),
          if (filterMap[sightTypeIcon]!)
            Positioned(
              right: -4,
              bottom: -4,
              child: MyIcons.iconTickChoice,
            ),
        ],
      ),
    );
  }
}

//Фильтр по расстоянию
class DistanceFilter extends StatefulWidget {
  const DistanceFilter({Key? key}) : super(key: key);

  @override
  DistanceFilterState createState() => DistanceFilterState();
}

class DistanceFilterState extends State<DistanceFilter> {
  late String _textRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues =
        const RangeValues(_searchMinDistance, _searchMaxDistance);
    _textRangeValues =
        ' от ${_currentRangeValues.start / 1000} до ${_currentRangeValues.end / 1000} км';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  child: Row(
                    children: [
                      Text(
                        'Расстояние',
                        style: Theme.of(context).accentTextTheme.bodyText1,
                      ),
                      const SizedBox(
                        width: 132,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          _textRangeValues,
                          style: Theme.of(context)
                              .accentTextTheme
                              .bodyText1!
                              .copyWith(color: inactiveBlack),
                        ),
                      ),
                    ],
                  ),
                ),
                RangeSlider(
                  values: _currentRangeValues,
                  onChanged: (newRangeValues) {
                    setState(() => renewTextRangeSlider(newRangeValues));
                  },
                  min: _searchMinDistance,
                  max: _searchMaxDistance,
                  divisions: _searchDivisions,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void renewTextRangeSlider(RangeValues newRangeValues) {
    _currentRangeValues = newRangeValues;
    _textRangeValues =
        ' от ${(_currentRangeValues.start / 1000).toStringAsFixed(1)} до ${(_currentRangeValues.end / 1000).toStringAsFixed(1)} км';
  }
}

class ShowButton extends StatefulWidget {
  const ShowButton({Key? key}) : super(key: key);

  @override
  _ShowButtonState createState() => _ShowButtonState();
}

class _ShowButtonState extends State<ShowButton> {
  late String _textElevatedButton;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 64,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ElevatedButton(
            onPressed: () {
              getSights();
              print('show button was tapped');
              print(filterList);
            },
            child: Text(_textElevatedButton),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSights();
    _textElevatedButton = 'ПОКАЗАТЬ ($_amountFilteredPlaces)';
  }

  void renewTextElevatedButton() {
    _textElevatedButton = 'ПОКАЗАТЬ ($_amountFilteredPlaces)';
  }

  void getSights() async {
    final List<Sight> sights = [];
    bool isSuitable;
    for (final Sight sight in mocks) {
      isSuitable = true
      // await checkSight(
      //   sight.lat,
      //   sight.lon,
      //   _searchMinDistance / 1000,
      //   _searchMaxDistance / 1000,
      // )
      ;
      if (filterList.isNotEmpty) {
        if (isSuitable && (filterList.contains(sight.type))) {
          sights.add(sight);
        }
      } else {
        if (isSuitable) {
          sights.add(sight);
        }
      }
    }
    _amountFilteredPlaces = sights.length;
    renewTextElevatedButton();
    setState(() {});
  }
}

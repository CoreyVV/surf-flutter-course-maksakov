import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/services/filters.dart';
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
    return this.title;
  }
}

//типы мест для таблицы фильтров
final sightTypeIconCafe = SightTypeIcon(
    title: 'Кафе', type: SightType.cafe, icon: MyIcons.catalog_white_cafe);
final sightTypeIconHotel = SightTypeIcon(
    title: 'Отель', type: SightType.hotel, icon: MyIcons.catalog_white_hotel);
final sightTypeIconMuseum = SightTypeIcon(
    title: 'Музей', type: SightType.museum, icon: MyIcons.catalog_white_museum);
final sightTypeIconPark = SightTypeIcon(
    title: 'Парк', type: SightType.park, icon: MyIcons.catalog_white_park);
final sightTypeIconParticularPlace = SightTypeIcon(
    title: 'Особое место',
    type: SightType.particular_place,
    icon: MyIcons.catalog_white_particular_place);
final sightTypeIconRestourant = SightTypeIcon(
    title: 'Ресторан',
    type: SightType.restourant,
    icon: MyIcons.catalog_white_restourant);

//храним значение таблицы фильтров
Map<SightTypeIcon, bool> filterMap = {
  sightTypeIconCafe: false,
  sightTypeIconHotel: false,
  sightTypeIconMuseum: false,
  sightTypeIconPark: false,
  sightTypeIconParticularPlace: false,
  sightTypeIconRestourant: false,
};
List<String> filterList = [];

//экран фильтров
class FilterScreen extends StatefulWidget {
// const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SightListScreen(),
                  ),
                );
              },
              icon: MyIcons.icon_arrow,
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
      body: ListView(
        children: [
          TypeFilter(onTap: (SightTypeIcon key) {
            setState(() {
              filterMap[key] = !filterMap[key]!;
              filterMap[key]!
                  ? filterList.add(key.type)
                  : filterList.remove(key.type);
            });
          }),
          DistanceFilter(),
          ShowButton(),
        ],
      ),
    );
  }
}

//фильтр с таблицей типов мест
class TypeFilter extends StatelessWidget {
  // const TypeFilter({Key? key}) : super(key: key);
  final Function(SightTypeIcon) onTap;

  TypeFilter({
    required this.onTap,
  });

  @override
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
                      SizedBox(
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
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 96,
                  height: 92,
                  child: Column(
                    children: [
                      TypeFilterBox(
                        sightTypeIcon: sightTypeIconRestourant,
                        onTap: () => onTap(sightTypeIconRestourant),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        sightTypeIconRestourant.title,
                        style: Theme.of(context)
                            .accentTextTheme
                            .bodyText2!
                            .copyWith(
                              fontSize: 12,
                            ),
                      )
                    ],
                  ),
                ),
                SizedBox(
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
                      SizedBox(
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
                      )
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
                      SizedBox(
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
                      )
                    ],
                  ),
                ),
                SizedBox(
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
                      SizedBox(
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
                      )
                    ],
                  ),
                ),
                SizedBox(
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
                      SizedBox(
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
                      )
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

  TypeFilterBox({
    required this.sightTypeIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: MyIcons.icon_tick_choice,
            ),
        ],
      ),
    );
  }
}

//Фильтр по расстоянию
class DistanceFilter extends StatefulWidget {
  // const DistanceFilter({Key? key}) : super(key: key);

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

  void renewTextRangeSlider(newRangeValues) {
    _currentRangeValues = newRangeValues;
    _textRangeValues =
        ' от ${(_currentRangeValues.start / 1000).toStringAsFixed(1)} до ${(_currentRangeValues.end / 1000).toStringAsFixed(1)} км';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 4, bottom: 16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  child: Row(
                    children: [
                      Text(
                        'Расстояние',
                        style: Theme.of(context).accentTextTheme.bodyText1,
                      ),
                      SizedBox(
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
}

class ShowButton extends StatefulWidget {
  // const ShowButton({Key? key}) : super(key: key);

  @override
  _ShowButtonState createState() => _ShowButtonState();
}

class _ShowButtonState extends State<ShowButton> {
  late String _textElevatedButton;

  void renewTextElevatedButton() {
    _textElevatedButton = 'ПОКАЗАТЬ (${_amountFilteredPlaces})';
  }

  @override
  void initState() {
    super.initState();
    getSights();
    _textElevatedButton = 'ПОКАЗАТЬ (${_amountFilteredPlaces})';
  }

  getSights() async {
    List<Sight> sights = [];

    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _currentPosition;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();

    print(_currentPosition);
    setState(() {
      for (var sight in mocks) {
        if (filterList.length > 0) {
          if ((checkSight(
                  sight.lat,
                  sight.lon,
                  _currentPosition.latitude!,
                  _currentPosition.longitude!,
                  _searchMinDistance / 1000,
                  _searchMaxDistance / 1000)) &&
              (filterList.contains(sight.type))) {
            sights.add(sight);
          }
        } else {
          if (checkSight(
              sight.lat,
              sight.lon,
              _currentPosition.latitude!,
              _currentPosition.longitude!,
              _searchMinDistance / 1000,
              _searchMaxDistance / 1000)) {
            sights.add(sight);
          }
        }
      }
      _amountFilteredPlaces = sights.length;
      renewTextElevatedButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 64,
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ElevatedButton(
            child: Text(_textElevatedButton),
            onPressed: () {
              getSights();
              print('show button was tapped');
              print(filterList);
            },
          ),
        ),
      ),
    );
  }
}

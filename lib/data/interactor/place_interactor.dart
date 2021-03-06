import 'dart:async';
import 'package:location/location.dart';
import 'package:places/data/exception/network_exception.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/services/location_service.dart';

class PlaceInteractor {
  final PlaceRepository placeRepository;

  final StreamController<List<Place>> _placeListController =
      StreamController.broadcast();
  final _listVisitedPlaces = <Place>[];

  Stream<List<Place>> get getListPlaces {
    _loadListPlace();
    return _placeListController.stream;
  }

  PlaceInteractor({
    required this.placeRepository,
  });

  void dispose() {
    _placeListController.close();
  }

  Future<Place> getPlaceDetails(int id) {
    return placeRepository.getPlace(id);
  }

  bool isVisited(Place place) {
    return _listVisitedPlaces.contains(place);
  }

  List<Place> getVisitedPlaces() {
    return _listVisitedPlaces;
  }

  void addToVisitedPlaces(Place place) {
    _listVisitedPlaces.add(place);
  }

  Future<Place> addNewPlace(Place place) {
    final result = placeRepository.postPlace(place);
    return result;
  }

  Future<List<Place>> _getPlaces(int radius, String category) async {
    final currentPosition = await LocationService().getCurrentPosition();
    if (radius == 0) {
      final listPlaces = await placeRepository.getPlaces();
      listPlaces.sort((a, b) => LocationService()
          .distanceTo(
            currentPosition,
            LocationData.fromMap(
              <String, dynamic>{'latitude': a.lat, 'longitude': a.lon},
            ),
          )
          .compareTo(LocationService().distanceTo(
            currentPosition,
            LocationData.fromMap(
              <String, dynamic>{'latitude': b.lat, 'longitude': b.lon},
            ),
          )));

      return listPlaces;
    } else {
      final listPlaces = await placeRepository.getPlaces();
      listPlaces
          .where((place) =>
              LocationService().distanceTo(
                currentPosition,
                LocationData.fromMap(
                  <String, dynamic>{
                    'latitude': place.lat,
                    'longitude': place.lon,
                  },
                ),
              ) <=
              radius)
          .toList()
          .sort((a, b) => LocationService()
              .distanceTo(
                currentPosition,
                LocationData.fromMap(
                  <String, dynamic>{'latitude': a.lat, 'longitude': a.lon},
                ),
              )
              .compareTo(LocationService().distanceTo(
                currentPosition,
                LocationData.fromMap(
                  <String, dynamic>{'latitude': b.lat, 'longitude': b.lon},
                ),
              )));

      return listPlaces;
    }
  }

  void _loadListPlace() async {
    try {
      final listPlace = await _getPlaces(1, '1');
      _placeListController.sink.add(listPlace);
    } on NetworkException catch (e) {
      _placeListController.sink.addError(e);
    }
  }
}

import 'package:location/location.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/services/location_service.dart';

final placeInteractor = PlaceInteractor(placeRepository: PlaceRepository());

class PlaceInteractor {
  final PlaceRepository placeRepository;
  final _listVisitedPlaces = <Place>[];
  final _listFavoritePlaces = <Place>[];

  PlaceInteractor({
    required this.placeRepository,
  });

  Future<List<Place>> getPlaces(int radius, String category) async {
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

  Future<Place> getPlaceDetails(int id) {
    return placeRepository.getPlace(id);
  }

  bool isFavorite(Place place) {
    return _listFavoritePlaces.contains(place);
  }

  List<Place> getFavoritesPlaces() {
    return _listFavoritePlaces;
  }

  void addToFavorites(Place place) {
    _listFavoritePlaces.add(place);
  }

  void removeFromFavorites(Place place) {
    _listFavoritePlaces.remove(place);
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
}
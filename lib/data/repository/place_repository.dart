import 'package:places/data/exception/network_exception.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_mapper.dart';
import 'package:places/data/repository/test_backend_flutter_service.dart';

class PlaceRepository {
  final TestBackEndFlutterService _testBackEndFlutterService =
      TestBackEndFlutterService();

  PlaceRepository();

  Future<List<Place>> getPlaces() async {
    try {
    final result = await _testBackEndFlutterService.getPlaces();

    return
      result.map<Place>(PlaceMapper.fromApi).toList();
    } on NetworkException {
      rethrow;
    }
  }

  Future<Place> getPlace(int id) async {
    final result = await _testBackEndFlutterService.getPlace(id);

    return PlaceMapper.fromApi(result);
  }

  Future<Place> postPlace(Place place) async {
    final result = await _testBackEndFlutterService.postPlace(
      place.id,
      place.lat,
      place.lon,
      place.name,
      place.urls,
      place.placeType,
      place.description,
    );

    return PlaceMapper.fromApi(result);
  }

  Future<int?> deletePlace(Place place) async {
    final result = await _testBackEndFlutterService.deletePlace(place.id);

    return result;
  }

  Future<Place> putPlace(Place place) async {
    final result = await _testBackEndFlutterService.putPlace(
      place.id,
      place.lat,
      place.lon,
      place.name,
      place.urls,
      place.placeType,
      place.description,
    );

    return PlaceMapper.fromApi(result);
  }
}

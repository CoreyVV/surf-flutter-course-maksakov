import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_mapper.dart';
import 'package:places/data/repository/test_backend_flutter_service.dart';

class PlaceRepository {
  final TestBackEndFlutterService _testBackEndFlutterService =
      TestBackEndFlutterService();

  PlaceRepository();

  Future<List<Place>> getPlaces() async {
    final result = await _testBackEndFlutterService.getPlaces();

    return List<Place>.from(
        result.map<dynamic>((place) => PlaceMapper.fromApi(place)));
  }

  Future<Place> getPlace(String id) async {
    final result = await _testBackEndFlutterService.getPlace(id);

    return PlaceMapper.fromApi(result);
  }
}

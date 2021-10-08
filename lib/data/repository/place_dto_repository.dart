import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_dto_mapper.dart';
import 'package:places/data/repository/test_backend_flutter_service.dart';

class PlaceDtoRepository {
  final TestBackEndFlutterService _testBackEndFlutterService =
  TestBackEndFlutterService();

  PlaceDtoRepository();

  Future<List<PlaceDto>> getFilteredPlaces(
      final double lat,
      final double lon,
      final double radius,
      final List<String> typeFilter,
      final String nameFilter,
      ) async {
    final result = await _testBackEndFlutterService.getPlaceDto(
      lat, lon, radius, typeFilter, nameFilter,
    );

    return List<PlaceDto>.from(
        result.map<dynamic>(PlaceDtoMapper.fromApi),);
  }

}

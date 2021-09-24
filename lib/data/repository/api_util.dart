// import 'package:places/data/model/place.dart';
// import 'package:places/data/repository/place_mapper.dart';
// import 'package:places/data/repository/test_backend_flutter_service.dart';
//
// class ApiUtil {
//   final TestBackEndFlutterService _testBackEndFlutterService;
//
//   ApiUtil(this._testBackEndFlutterService);
//
//   Future<List<Place>> getPlaces() async {
//     final result = await _testBackEndFlutterService.getPlaces();
//     return List<Place>.from(result.map<dynamic>(
//             (place) => PlaceMapper.fromApi(place)));
//   }
// }
import 'package:dio/dio.dart';
import 'package:places/data/repository/api_place.dart';
import 'package:places/data/repository/api_urls.dart';

class TestBackEndFlutterService {
  static const _baseUrl = 'https://test-backend-flutter.surfstudio.ru';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
    ),
  );

  Future<List<ApiPlace>> getPlaces() async {
    final response = await _getDio().get<dynamic>(
      ApiUrls.place,
    );
    // for (var map in response.data) {
    //   var id = map['id'],
    //       lon = map['lng'],
    //       lat = map['lat'],
    //       name = map['name'],
    //       urls = List<String>.from(map['urls']),
    //       placeType = map['placeType'],
    //       description = map['description'];
    //   print(id);
    //   print(lon);
    //   print(lat);
    //   print(name);
    //   print(urls);
    //   print(placeType);
    //   print(description);
    //   if (id == Null) {print('*****');}
    //   if (lon == Null) {print('*****');}
    //   if (lat == Null) {print('*****');}
    //   if (name == Null) {print('*****');}
    //   if (urls == Null) {print('*****');}
    //   if (placeType == Null) {print('*****');}
    //   if (description == Null) {print('*****');}
    // }

    List<ApiPlace> _listApiPlaces = List<ApiPlace>.from(
      response.data.map(
        (place) => ApiPlace.fromApi(place),
      ),
    );

    return _listApiPlaces;
  }

  // Future<PlaceRepository> getPlace(int id) async {
  //   final response = await _getDio().get<dynamic>(
  //     ApiUrls.place,
  //   );
  //   return PlaceRepository(
  //     id: 'id',
  //     lat: 1,
  //     lon: 1,
  //     name: 'name',
  //     urls: ['urls1', 'urls2'],
  //     placeType: 'placeType',
  //     description: 'description',
  //   );
  // }

  Dio _getDio() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          print(
            'ERROR $e',
          );
          return handler.next(e);
        },
        onRequest: (options, handler) {
          print(
            'REQUEST  [${options.method}] => PATH:${options.baseUrl}${options.path}',
          );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE [${response.statusCode}]');
          return handler.next(response);
        },
      ),
    );
    return _dio;
  }

// Future<PlaceRepository> getDay({
//   @required double latitude,
//   @required double longitude,
// }) async {
//   final query = {'lat': latitude, 'lng': longitude, 'formatted': 0};
//   final response = await _dio.get(
//     '/json',
//     queryParameters: query,
//   );
//   return ApiDay.fromApi(response.data);
// }
}

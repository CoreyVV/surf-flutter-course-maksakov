import 'package:dio/dio.dart';
import 'package:places/data/repository/api_place.dart';
import 'package:places/data/repository/api_urls.dart';
import 'package:places/data/repository/get_place_body.dart';

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

    List<ApiPlace> _listApiPlaces = List<ApiPlace>.from(
      response.data.map(
        (place) => ApiPlace.fromApi(place),
      ),
    );

    return _listApiPlaces;
  }

  Future<ApiPlace> getPlace(int id) async {
    final response = await _getDio().get<dynamic>('${ApiUrls.place}/$id');

    return ApiPlace.fromApi(response.data);
  }

  Future<ApiPlace> postPlace(
    final int id,
    final double lat,
    final double lng,
    final String name,
    final List<String> urls,
    final String placeType,
    final String description,
  ) async {
    final body = GetPlaceBody(
      id: id,
      lat: lat,
      lng: lng,
      name: name,
      urls: urls,
      placeType: placeType,
      description: description,
    );

    final response = await _getDio().post<dynamic>(
      ApiUrls.place,
      queryParameters: body.toApi(),
    );

    return ApiPlace.fromApi(response.data);
  }

  Future<int?> deletePlace(int id) async {
    final response = await _getDio().delete<dynamic>('${ApiUrls.place}/$id');

    return response.statusCode;
  }

  Future<ApiPlace> putPlace(
      final int id,
      final double lat,
      final double lng,
      final String name,
      final List<String> urls,
      final String placeType,
      final String description,
      ) async {
    final body = GetPlaceBody(
      id: id,
      lat: lat,
      lng: lng,
      name: name,
      urls: urls,
      placeType: placeType,
      description: description,
    );

    final response = await _getDio().put<dynamic>(
      '${ApiUrls.place}/$id',
      queryParameters: body.toApi(),
    );

    return ApiPlace.fromApi(response.data);
  }


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
}

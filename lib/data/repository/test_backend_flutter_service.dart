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

    List<ApiPlace> _listApiPlaces = List<ApiPlace>.from(
      response.data.map(
        (place) => ApiPlace.fromApi(place),
      ),
    );

    return _listApiPlaces;
  }

  Future<ApiPlace> getPlace(String id) async {
    final response = await _getDio().get<dynamic>('${ApiUrls.place}/$id');

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

import 'package:dio/dio.dart';
import 'package:places/data/exception/network_exception.dart';
import 'package:places/data/repository/api_place.dart';
import 'package:places/data/repository/api_urls.dart';
import 'package:places/data/repository/get_place_body.dart';
import 'package:places/data/repository/api_place_dto.dart';
import 'package:places/data/repository/get_places_dto_body.dart';

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
    try {
      final response = await _getDio().get<dynamic>(
        ApiUrls.place,
      );
      final listApiPlaces = (response.data as List)
          .whereType<Map<String, dynamic>>()
          .map((place) => ApiPlace.fromApi(place))
          .toList();

      return listApiPlaces;
    } on DioError catch (e) {
      final options = e.requestOptions;

      throw NetworkException(
        request: '${options.baseUrl}${options.path}',
        description: e.message,
      );
    }
  }

  Future<ApiPlace> getPlace(int id) async {
    try {
      final response = await _getDio().get<dynamic>('${ApiUrls.place}/$id');

      return ApiPlace.fromApi(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw NetworkException.fromDioError(e);
    }
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
    try {
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

      return ApiPlace.fromApi(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<int?> deletePlace(int id) async {
    try {
      final response = await _getDio().delete<dynamic>('${ApiUrls.place}/$id');

      return response.statusCode;
    } on DioError catch (e) {
      throw NetworkException.fromDioError(e);
    }
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
    try {
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

      return ApiPlace.fromApi(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<List<ApiPlaceDto>> getPlaceDto(
    final double lat,
    final double lng,
    final double radius,
    final List<String> typeFilter,
    final String nameFilter,
  ) async {
    try {
      final body = GetPlacesDtoBody(
        lat: lat,
        lng: lng,
        radius: radius,
        typeFilter: typeFilter,
        nameFilter: nameFilter,
      );
      final List<ApiPlaceDto> _listApiPlacesDto;
      final response = await _getDio().post<dynamic>(
        ApiUrls.filteredPlaces,
        data: body.toApi(),
      );
      if (response.statusCode == 200) {
        _listApiPlacesDto = (response.data as List)
            .whereType<Map<String, dynamic>>()
            .map(
              (placeDto) => ApiPlaceDto.fromApi(placeDto),
            )
            .toList();
      } else {
        _listApiPlacesDto = <ApiPlaceDto>[];
      }

      return _listApiPlacesDto;
    } on DioError catch (e) {
      throw NetworkException.fromDioError(e);
    }
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
            'REQUEST  [${options.method}] => PATH:${options.baseUrl}${options.path}  BODY: ${options.data}',
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

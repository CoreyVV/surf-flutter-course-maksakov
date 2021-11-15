import 'package:dio/dio.dart';

//исключение для обработки сетевых ошибок
class NetworkException implements Exception {
  late final String request;
  late final String description;
  late final int? code;

  NetworkException({
    required this.request,
    required this.description,
    this.code,
  });

  NetworkException.fromDioError(DioError dioError) {
    final options = dioError.requestOptions;
    final response = dioError.response;
    if (response != null) {
      code = response.statusCode;
    }
    request = '${options.baseUrl}${options.path}';
    description = dioError.message;
  }

  @override
  String toString() {
    var message = 'В запросе $request возникла ошибка:';
    message = code != null ? ' $code $description' : ' $description';

    return message;
  }
}

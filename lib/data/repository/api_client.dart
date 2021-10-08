import 'package:dio/dio.dart';

class ApiClient {

  dynamic getData(String url) async {
    return _dio().get<dynamic>(url);
  }

  dynamic postData(String url, dynamic data) async {
    return _dio().post<dynamic>(url);
  }

  dynamic putData(String url, dynamic data) async {
    return _dio().put<dynamic>(url);
  }

  dynamic deleteData(String url, dynamic data) async {
    return _dio().delete<dynamic>(url);
  }

  Dio _dio() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://test-backend-flutter.surfstudio.ru',
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
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

    return dio;
  }
}

import 'package:dio/dio.dart';

class HttpClient {
  final dio = Dio(BaseOptions(
// baseUrl: 'https://test-backend-flutter.surfstudio.ru',
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: 5000,
    receiveTimeout: 5000,
    sendTimeout: 5000,
    responseType: ResponseType.json,
  ));

  void _initInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          return handler.next(e);
        },
        onRequest: (options, handler) {
          print('REQUEST  [${options.method}] => PATH:${options.baseUrl}${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE [${response.statusCode}]');
          return handler.next(response);
        },
      ),
    );
  }

  Future<dynamic> getUsers() async {
    _initInterceptors();
    final usersResponse = await dio.get<dynamic>('/users');
    if (usersResponse.statusCode == 200) {
      return usersResponse.data;
    }
    throw Exception(
        'HTTP request error. Error code ${usersResponse.statusCode}');
  }
}

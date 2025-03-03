import 'package:dio/dio.dart';

class DioHttpClientImplementation implements HttpClient {
  final Dio dio;
  DioHttpClientImplementation(this.dio);

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.get<T>(
      url,
      queryParameters: queryParameters,
    );
  }
}

abstract class HttpClient {
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
  });
}

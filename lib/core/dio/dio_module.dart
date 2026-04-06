import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/core/api/api_constants.dart';
import 'package:weather/core/dio/dio_interceptor.dart';

@module
abstract class DioModule {
  @singleton
  @injectable
  Dio proviedDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        queryParameters: {"key": ApiConstants.apiKey},
      ),
    );
    dio.interceptors.add(DioInterceptor());
    return dio;
  }
}

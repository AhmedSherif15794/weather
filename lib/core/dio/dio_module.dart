import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/core/api/api_constants.dart';

@module
abstract class DioModule {
  @singleton
  @injectable
  Dio proviedDio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        queryParameters: {"key": ApiConstants.apiKey},
      ),
    );
  }
}

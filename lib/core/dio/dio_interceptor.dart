import 'package:dio/dio.dart';
import 'package:weather/core/utils/app_exception.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException appException;
    String message = 'Something went wrong';
    var response = err.response!.data;
    if (response is Map) {
      message = response['"error"']["message"] ?? message;
    }
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      appException = NetworkException(message: message);
    } else if (err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.response?.statusCode != null) {
      appException = ServerException(
        message: message,
        statusCode: err.response?.statusCode,
      );
    } else {
      appException = UnkownException(message: message);
    }
    handler.reject(
      DioException(requestOptions: err.requestOptions, error: appException),
    );
  }
}

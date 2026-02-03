import 'package:dio/dio.dart';
import 'package:weather/core/utils/app_exception.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message = 'Something went wrong';

    final response = err.response?.data;
    if (response is Map && response['error'] != null) {
      message = response['error']['message'] ?? message;
    }

    late AppException appException;

    switch (err.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
        appException = NetworkException(message: 'Network Error');
        break;

      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.badResponse:
        appException = ServerException(
          message: message,
          statusCode: err.response?.statusCode,
        );
        break;

      default:
        appException = UnkownException(message: 'Unexpected Error');
    }

    // err.error = appException;
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: appException,
        response: err.response,
        type: err.type,
      ),
    );
  }
}

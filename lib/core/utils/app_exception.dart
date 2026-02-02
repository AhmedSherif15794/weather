sealed class AppException implements Exception {
  String message;
  AppException({required this.message});
}

class ServerException extends AppException {
  int? statusCode;
  ServerException({required super.message, this.statusCode});
}

class NetworkException extends AppException {
  NetworkException({required super.message});
}

class UnkownException extends AppException {
  UnkownException({required super.message});
}

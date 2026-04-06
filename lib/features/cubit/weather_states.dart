import 'package:weather/domain/entities/weather_response_dto.dart';

class WeatherStates {}

class InitialState extends WeatherStates {}

class SuccessState extends WeatherStates {
  WeatherResponseDto weather;
  SuccessState({required this.weather});
}

class LoadingState extends WeatherStates {}

class ErrorState extends WeatherStates {
  String message;
  ErrorState({required this.message});
}

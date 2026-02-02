import 'package:weather/domain/entities/weather_response_dto.dart';

abstract class WeatherStates {}

class WeatherInitialState extends WeatherStates {}

class WeatherLoadingState extends WeatherStates {
  // PracticeWeatherModel weatherModel;

  // WeatherLoadedState({required this.weatherModel});
}

class WeatherSuccessState extends WeatherStates {
  WeatherResponseDto responseDto;
  WeatherSuccessState({required this.responseDto});
}

class WeatherErrorState extends WeatherStates {
  String message;
  WeatherErrorState({required this.message});
}

class SearchState extends WeatherStates {}

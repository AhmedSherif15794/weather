import 'package:weather/data/models/weather_response.dart';

abstract class WeatherRepo {
  Future<WeatherResponse> getWeatherByLocation({
    required double latitude,
    required double longitude,
  });
  Future<WeatherResponse> getWeatherByCityName({required String cityName});
}

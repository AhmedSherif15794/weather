import 'package:weather/data/models/weather_response.dart';

abstract class WeatherRepo {
  Future<WeatherResponse> getWeather({required String cityName});
}

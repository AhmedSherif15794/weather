import 'package:weather/data/models/weather_response.dart';

abstract class RemoteDs {
  Future<WeatherResponse> getWeather({required String city});
}

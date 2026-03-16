import 'package:injectable/injectable.dart';
import 'package:weather/data/data_sources/remote/remote_ds.dart';
import 'package:weather/data/models/weather_response.dart';
import 'package:weather/domain/repositories/weather_repo/weather_repo.dart';

@Injectable(as: WeatherRepo)
class WeatherRepoImpl implements WeatherRepo {
  RemoteDs remoteDs;
  WeatherRepoImpl({required this.remoteDs});
  @override
  Future<WeatherResponse> getWeatherByLocation({
    required double latitude,
    required double longitude,
  }) {
    return remoteDs.getWeatherByLocation(
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<WeatherResponse> getWeatherByCityName({required String cityName}) {
    return remoteDs.getWeatherByCityName(cityName: cityName);
  }
}

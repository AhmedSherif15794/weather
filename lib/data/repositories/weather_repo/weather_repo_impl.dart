import 'package:injectable/injectable.dart';
import 'package:weather/data/data_sources/remote/remote_ds.dart';
import 'package:weather/data/models/weather_response.dart';
import 'package:weather/domain/repositories/weather_repo/weather_repo.dart';

@Injectable(as: WeatherRepo)
class WeatherRepoImpl implements WeatherRepo {
  RemoteDs remoteDs;
  WeatherRepoImpl({required this.remoteDs});
  @override
  Future<WeatherResponse> getWeather({required String cityName}) {
    return remoteDs.getWeather(city: cityName);
  }
}

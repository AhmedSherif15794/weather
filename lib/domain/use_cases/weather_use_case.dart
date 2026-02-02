import 'package:injectable/injectable.dart';
import 'package:weather/data/mapper/weather_response_mapper.dart';
import 'package:weather/domain/entities/weather_response_dto.dart';
import 'package:weather/domain/repositories/weather_repo/weather_repo.dart';

@injectable
class WeatherUseCase {
  WeatherRepo weatherRepo;
  WeatherUseCase({required this.weatherRepo});

  Future<WeatherResponseDto> getWeather({required String cityName}) async {
    // weather response  => weather respnose dto
    var weather = await weatherRepo.getWeather(cityName: cityName);
    return weather.toWeatherResponseDto();
  }
}

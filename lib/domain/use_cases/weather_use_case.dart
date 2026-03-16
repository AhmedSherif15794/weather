import 'package:injectable/injectable.dart';
import 'package:weather/data/mapper/weather_response_mapper.dart';
import 'package:weather/domain/entities/weather_response_dto.dart';
import 'package:weather/domain/repositories/weather_repo/weather_repo.dart';

@injectable
class WeatherUseCase {
  WeatherRepo weatherRepo;
  WeatherUseCase({required this.weatherRepo});

  Future<WeatherResponseDto> getWeatherByLocation({
    required double latitude,
    required double longitude,
  }) async {
    // weather response  => weather respnose dto
    var weather = await weatherRepo.getWeatherByLocation(
      latitude: latitude,
      longitude: longitude,
    );
    return weather.toWeatherResponseDto();
  }

  Future<WeatherResponseDto> getWeatheByCityName({
    required String cityName,
  }) async {
    var weather = await weatherRepo.getWeatherByCityName(cityName: cityName);
    return weather.toWeatherResponseDto();
  }
}

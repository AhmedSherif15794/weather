import 'package:weather/data/mapper/forecast_day_mapper.dart';
import 'package:weather/data/models/weather_response.dart';
import 'package:weather/domain/entities/weather_response_dto.dart';

extension WeatherResponseMapper on WeatherResponse {
  WeatherResponseDto toWeatherResponseDto() {
    if (location != null &&
        location!.name != null &&
        location!.country != null &&
        location!.region != null &&
        location!.localtime != null &&
        location!.localtimeEpoch != null &&
        location!.lat != null &&
        location!.lon != null &&
        current != null &&
        current!.condition != null &&
        current!.condition!.text != null &&
        current!.condition!.icon != null &&
        current!.lastUpdated != null &&
        current!.lastUpdatedEpoch != null &&
        forecast != null &&
        forecast!.forecastday != null) {}
    return WeatherResponseDto(
      name: location!.name!,
      country: location!.country!,
      region: location!.region!,
      localTime: location!.localtime!,
      localtimeEpoch: location!.localtimeEpoch!,
      lat: location!.lat!,
      lon: location!.lon!,
      condition: current!.condition!.text!,
      conditionIcon: current!.condition!.icon!,
      lastUpdated: current!.lastUpdated!,
      lastUpdatedEboch: current!.lastUpdatedEpoch!,
      tempC: current!.tempC!,
      forecastDayDto:
          forecast!.forecastday!.map((e) => e.toForecastDayDto()).toList(),
    );
  }
}

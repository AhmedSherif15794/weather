import 'package:weather/domain/entities/forecast_day_dto.dart';

class WeatherResponseDto {
  // location
  String name;
  String country;
  String region;
  int localtimeEpoch; //with seconds
  String localTime;
  double lat;
  double lon;

  // current
  int lastUpdatedEboch; // with seconds
  String lastUpdated;
  double tempC; // current temp

  // condition
  String condition;
  String conditionIcon;

  // days
  List<ForecastDayDto> forecastDayDto;

  WeatherResponseDto({
    required this.name,
    required this.country,
    required this.region,
    required this.localTime,
    required this.localtimeEpoch,
    required this.lat,
    required this.lon,

    required this.condition,
    required this.conditionIcon,

    required this.lastUpdated,
    required this.lastUpdatedEboch,
    required this.tempC,

    required this.forecastDayDto,
  });
}

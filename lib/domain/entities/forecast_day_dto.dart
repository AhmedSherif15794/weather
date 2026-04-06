import 'package:weather/domain/entities/hour_dto.dart';

class ForecastDayDto {
  String date;
  int dateEpoch;

  // day
  double maxTempC;
  double minTempC;
  double avgTempC;

  // condition
  String condition;
  String conditionIcon;

  // Astro
  String sunRise;
  String sunSet;
  String moonRise;
  String moonSet;
  String moonPhase;

  // hours
  List<HourDto> hours;

  ForecastDayDto({
    required this.date,
    required this.dateEpoch,
    required this.maxTempC,
    required this.minTempC,
    required this.avgTempC,
    required this.condition,
    required this.conditionIcon,
    required this.sunRise,
    required this.sunSet,
    required this.moonRise,
    required this.moonSet,
    required this.moonPhase,
    required this.hours,
  });
}

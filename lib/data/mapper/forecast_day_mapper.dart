import 'package:weather/data/mapper/hour_mapper.dart';
import 'package:weather/data/models/forecast_day.dart';
import 'package:weather/domain/entities/forecast_day_dto.dart';

extension ForecastDayMapperon on Forecastday {
  ForecastDayDto toForecastDayDto() {
    if (date != null &&
        dateEpoch != null &&
        day != null &&
        day!.maxtempC != null &&
        day!.mintempC != null &&
        day!.avgtempC != null &&
        day!.condition != null &&
        day!.condition!.text != null &&
        day!.condition!.icon != null &&
        astro != null &&
        astro!.sunrise != null &&
        astro!.sunset != null &&
        astro!.moonrise != null &&
        astro!.moonset != null &&
        astro!.moonPhase != null &&
        hour != null) {
      return ForecastDayDto(
        date: date!,
        dateEpoch: dateEpoch!,
        maxTempC: day!.maxtempC!,
        minTempC: day!.mintempC!,
        avgTempC: day!.avgtempC!,
        condition: day!.condition!.text!,
        conditionIcon: day!.condition!.icon!,
        sunRise: astro!.sunrise!,
        sunSet: astro!.sunset!,
        moonRise: astro!.moonrise!,
        moonSet: astro!.moonset!,
        moonPhase: astro!.moonPhase!,
        hours: hour!.map((e) => e.toHourDto()).toList(),
      );
    }
    throw Exception();
  }
}

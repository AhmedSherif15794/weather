import 'package:weather/data/models/hour.dart';
import 'package:weather/domain/entities/hour_dto.dart';

extension HourMapper on Hour {
  HourDto toHourDto() {
    if (time != null &&
        timeEpoch != null &&
        tempC != null &&
        condition != null &&
        condition!.text != null &&
        condition!.icon != null) {
      return HourDto(
        time: time!,
        timeEpoch: timeEpoch!,
        tempC: tempC!,
        condition: condition!.text!,
        conditionIcon: condition!.icon!,
      );
    }
    throw Exception();
  }
}

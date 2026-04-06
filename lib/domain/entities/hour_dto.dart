class HourDto {
  String time;
  int timeEpoch; // with seconds

  double tempC;
  String condition;
  String conditionIcon;

  HourDto({
    required this.time,
    required this.timeEpoch,
    required this.tempC,
    required this.condition,
    required this.conditionIcon,
  });
}

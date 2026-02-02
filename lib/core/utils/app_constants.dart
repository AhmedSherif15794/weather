import 'package:flutter/material.dart';
import 'package:weather/core/utils/app_colors.dart';

class AppConstants {
  static Gradient getWeatherGradient(String condition) {
    final cond = condition.toLowerCase();

    if (cond == "sunny") {
      // Sunny
      return const LinearGradient(
        colors: [Colors.orange, Colors.yellow],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (cond == "clear") {
      // Clear - ليل صافي
      return const LinearGradient(
        colors: [Colors.indigo, Colors.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (cond == "cloudy" ||
        cond == "partly cloudy" ||
        cond == "overcast") {
      // Cloudy / Overcast
      return const LinearGradient(
        colors: [Colors.blueGrey, Colors.grey],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (cond == "mist" || cond == "fog") {
      // Mist / Fog
      return const LinearGradient(
        colors: [Colors.grey, Colors.blueGrey],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (cond.contains("rain")) {
      return const LinearGradient(
        colors: [Colors.blue, Colors.indigo],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (cond.contains("snow")) {
      return const LinearGradient(
        colors: [Colors.lightBlueAccent, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (cond.contains("thunder")) {
      return const LinearGradient(
        colors: [Colors.deepPurple, Colors.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else {
      // Default
      return const LinearGradient(
        colors: [Colors.teal, Colors.cyan],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
  }

  static Color getWeatherColor(String condition) {
    if (condition == "Sunny") {
      return Colors.orange; // الجو مشمس
    } else if (condition == "Clear") {
      return Colors.indigo; // ليل صافي
    } else if (condition == "Partly cloudy" ||
        condition == "Cloudy" ||
        condition == "Overcast") {
      return Colors.blueGrey; // سحاب
    } else if (condition == "Mist" ||
        condition == "Fog" ||
        condition == "Freezing fog") {
      return Colors.grey; // شبورة / ضباب
    } else if (condition.contains("rain") || condition.contains("shower")) {
      return Colors.blue; // مطر
    } else if (condition.contains("snow") || condition.contains("sleet")) {
      return Colors.lightBlueAccent; // تلج
    } else if (condition.contains("thunder")) {
      return Colors.deepPurple; // رعد
    } else {
      return Colors.teal; // Default
    }
  }

  static Color getWetherTextColor(String condition) {
    if (condition == "Sunny") {
      return AppColors.black; // الجو مشمس
    } else if (condition == "Clear") {
      return AppColors.white; // ليل
    } else if (condition == "Partly cloudy" ||
        condition == "Cloudy" ||
        condition == "Overcast") {
      return AppColors.white; // سحاب
    } else if (condition == "Mist" ||
        condition == "Fog" ||
        condition == "Freezing fog") {
      return AppColors.white; // شبورة / ضباب
    } else if (condition.contains("rain") || condition.contains("shower")) {
      return AppColors.white; // مطر
    } else if (condition.contains("snow") || condition.contains("sleet")) {
      return AppColors.white; // تلج
    } else if (condition.contains("thunder")) {
      return AppColors.white; // رعد
    } else {
      return AppColors.white; // Default
    }
  }
}

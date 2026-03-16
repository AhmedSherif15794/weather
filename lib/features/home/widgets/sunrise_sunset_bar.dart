import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/utils/app_colors.dart';

class SunriseSunsetBar extends StatelessWidget {
  const SunriseSunsetBar({
    super.key,
    required this.now,
    required this.sunset,
    required this.sunrise,
  });
  final DateTime now;
  final String sunset;
  final String sunrise;
  @override
  Widget build(BuildContext context) {
    DateTime timeSunRise = DateFormat('hh:mm a').parse(sunrise);
    DateTime dateSunRise = DateTime(
      now.year,
      now.month,
      now.day,
      timeSunRise.hour,
      timeSunRise.minute,
    );
    DateTime timeSunSet = DateFormat('hh:mm a').parse(sunset);
    DateTime dateSunSet = DateTime(
      now.year,
      now.month,
      now.day,
      timeSunSet.hour,
      timeSunSet.minute,
    );

    DateTime tomorrowSunrise = dateSunRise.add(Duration(days: 1));
    DateTime yesterdaySunset = dateSunSet.subtract(Duration(days: 1));

    bool isDaytime = now.isAfter(dateSunRise) && now.isBefore(dateSunSet);

    double progress;
    IconData icon;
    double alignmentX;

    if (isDaytime) {
      icon = Icons.sunny;
      progress =
          (now.difference(dateSunRise).inMinutes) /
          (dateSunSet.difference(dateSunRise).inMinutes);
      alignmentX = (progress.clamp(0.0, 1.0) * 2) - 1;
    } else {
      icon = Icons.nightlight_outlined;

      if (now.isAfter(dateSunSet)) {
        progress =
            (now.difference(dateSunSet).inMinutes) /
            (tomorrowSunrise.difference(dateSunSet).inMinutes);
      } else {
        progress =
            (now.difference(yesterdaySunset).inMinutes) /
            (dateSunRise.difference(yesterdaySunset).inMinutes);
      }
      alignmentX = 1 - (progress.clamp(0.0, 1.0) * 2);
    }

    // print('progress: $progress');
    // print('alignmentX: $alignmentX');
    // print('now: $now');

    return Stack(
      alignment: Alignment.center,
      children: [
        LinearProgressIndicator(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          backgroundColor: AppColors.white.withAlpha(30),
          value: isDaytime ? progress.clamp(0, 1) : 0,
          minHeight: 6,
        ),
        Align(
          alignment: Alignment(alignmentX, 0),
          child: Icon(icon, color: AppColors.white),
        ),
      ],
    );
  }
}

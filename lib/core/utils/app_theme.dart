import 'package:flutter/material.dart';
import 'package:weather/core/utils/app_colors.dart';
import 'package:weather/core/utils/app_styles.dart';

class AppTheme {
  static ThemeData theme() => ThemeData(
    scaffoldBackgroundColor: AppColors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
    ),
    textTheme: TextTheme(
      titleLarge: AppStyles.semiBold65WhiteNuneto(),
      titleMedium: AppStyles.regular16WhiteNuneto(),

      bodyLarge: AppStyles.regular15GreySarabun(),
      bodyMedium: AppStyles.regular12GreySarabun(),
      bodySmall: AppStyles.regular10GreySarabun(),

      labelSmall: AppStyles.regular8GreySarabun(),
    ),
  );
}

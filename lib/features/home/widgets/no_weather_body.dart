import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/utils/app_colors.dart';

class NoWeatherBody extends StatelessWidget {
  const NoWeatherBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: Text(
          "There is no weather 😌 Start searching now 🔍",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 30.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

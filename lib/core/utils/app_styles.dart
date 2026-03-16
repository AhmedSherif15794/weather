import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/core/utils/app_colors.dart';

class AppStyles {
  // semiBold

  // 45 white
  static TextStyle semiBold65WhiteNuneto() => GoogleFonts.nunito(
    fontSize: 65.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  //   45 grey
  static TextStyle semiBold45GreyNuneto() => GoogleFonts.nunito(
    fontSize: 45.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
  );

  //   Regular

  // 16 White nunito
  static TextStyle regular16WhiteNuneto() => GoogleFonts.nunito(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  // 12White nunito
  static TextStyle regular12WhiteNuneto() => GoogleFonts.nunito(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  //   12Grey Sarabon
  static TextStyle regular12GreySarabun() => GoogleFonts.sarabun(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  //   15 grey sarabon
  static TextStyle regular15GreySarabun() => GoogleFonts.sarabun(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  // 8 grey sarabon
  static TextStyle regular8GreySarabun() => GoogleFonts.sarabun(
    fontSize: 8.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
  //   10 grey sarabon
  static TextStyle regular10GreySarabun() => GoogleFonts.sarabun(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
}

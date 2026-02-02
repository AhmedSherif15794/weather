import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/utils/app_colors.dart';

class AppFunctions {
  static OutlineInputBorder buildDecorationBorder({Color? borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: borderColor ?? AppColors.grey, width: 2),
    );
  }

  static void loadingDialog({required BuildContext context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.transparent,

            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator(color: AppColors.white)],
            ),
          ),
    );
  }

  static void popDialog({required BuildContext context}) {
    Navigator.pop(context);
  }

  static Future<void> messageDialog({
    required BuildContext context,
    required String message,
    String? title,
  }) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => AlertDialog(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
              side: BorderSide(color: AppColors.black),
            ),
            contentPadding: EdgeInsets.all(22.r),
            backgroundColor: AppColors.white,
            content: Text(
              message,
              // textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(color: AppColors.black),
            ),
            title:
                title != null
                    ? Text(
                      title,
                      // textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(color: AppColors.black),
                    )
                    : null,
          ),
    );

    await Future.delayed(Duration(milliseconds: 3000));

    // ignore: use_build_context_synchronously
    popDialog(context: context);
  }

  // static String? nameValidator(String? value, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return AppLocalizations.of(context)!.please_enter_your_name;
  //   }

  //   return null;
  // }

  // static String? emailValidator(String? value, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return AppLocalizations.of(context)!.please_enter_your_email;
  //   }
  //   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
  //     return AppLocalizations.of(context)!.please_enter_avalid_email_address;
  //   }
  //   return null;
  // }

  // static String? passwordValidator(String? value, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return AppLocalizations.of(context)!.please_enter_your_password;
  //   }
  //   if (value.length < 8) {
  //     return AppLocalizations.of(
  //       context,
  //     )!.password_must_be_at_least_eight_characters_long;
  //   }
  //   if (!value.contains(RegExp(r'[A-Z]'))) {
  //     return AppLocalizations.of(
  //       context,
  //     )!.password_must_contain_at_least_one_uppercase_letter;
  //   }
  //   if (!value.contains(RegExp(r'[a-z]'))) {
  //     return AppLocalizations.of(
  //       context,
  //     )!.password_must_contain_at_least_one_lowercase_letter;
  //   }
  //   if (!value.contains(RegExp(r'[0-9]'))) {
  //     return AppLocalizations.of(
  //       context,
  //     )!.password_must_contain_at_least_one_number;
  //   }
  //   if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
  //     return AppLocalizations.of(
  //       context,
  //     )!.password_must_contain_at_least_one_special_char;
  //   }
  //   return null;
  // }

  // static String? rePasswordValidator({
  //   required String? value,
  //   required String password,
  //   required BuildContext context,
  // }) {
  //   if (value == null || value.isEmpty) {
  //     return AppLocalizations.of(context)!.please_enter_your_password;
  //   }
  //   if (password != value) {
  //     return AppLocalizations.of(context)!.thats_not_matched_with_the_password;
  //   }
  //   return null;
  // }

  // static String? mobileNumberValidator(String? value, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return AppLocalizations.of(context)!.please_enter_your_mobile_num;
  //   }
  //   if (value.trim().length != 11) {
  //     return AppLocalizations.of(context)!.please_enter_a_valid_mobile_num;
  //   }

  //   return null;
  // }
}

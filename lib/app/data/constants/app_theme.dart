import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/app/data/constants/constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.light,
    primaryColor: AppColors.kPrimary,
    scaffoldBackgroundColor: AppColors.kWhite,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: AppColors.kWhite,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.all(15.h),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        hintStyle: AppTypography.kRegular14
            .copyWith(color: AppColors.kBlack.withOpacity(0.6)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.kBlack.withOpacity(0.1))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.kBlack.withOpacity(0.1))),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.kBlack.withOpacity(0.1))),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.kBlack.withOpacity(0.1))),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.red))),
  );
}

SystemUiOverlayStyle defaultOverlay = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.black,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
);

SystemUiOverlayStyle customOverlay = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
);

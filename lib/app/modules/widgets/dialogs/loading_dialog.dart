
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_mate/app/data/constants/constants.dart';

bool isLoading = false;
showLoading() async {
  isLoading = true;
  await Get.dialog(
      AlertDialog(
        elevation: 0,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 80.h,
              width: 80.h,
              decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Lottie.asset(
                'assets/lottie/loading.json',
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false);
  isLoading = false;
}

hideLoading() async {
  if (isLoading) {
    Get.back();
  }
  return;
}

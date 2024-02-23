import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/widgets/buttons/primary_button.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  final String? title;
  final bool showOkButton;
  const ErrorDialog(
      {super.key, required this.message, this.showOkButton = true, this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.kBlack,
      contentPadding: EdgeInsets.all(12.h),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/lottie/error.json',
              height: 160, width: 160, fit: BoxFit.cover),
          Text(title ?? 'Error',
              style: AppTypography.kSemiBold18
                  .copyWith(color: AppColors.kPrimary)),
          SizedBox(height: 20.h),
          Text(
            message,
            style: AppTypography.kLight14,
            textAlign: TextAlign.center,
          ),
          if (showOkButton) ...[
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: PrimaryButton(
                onTap: () {
                  Get.back();
                },
                text: 'Okay',
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ],
      ),
    );
  }
}

Future<void> showErrorDialog(String message, String? title) {
  return Get.dialog(ErrorDialog(
    message: message,
    title: title,
  ));
}

Future<void> showNoNetworkDialog() {
  return Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: const ErrorDialog(
          showOkButton: false,
          message: "No internet connection",
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.75));
}

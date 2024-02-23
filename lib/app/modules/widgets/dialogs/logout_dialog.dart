import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/widgets/buttons/custom_text_button.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onPressedOk;
  final VoidCallback cancel;
  const LogoutDialog(
      {super.key, required this.onPressedOk, required this.cancel});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          Center(child: Text('Logout', style: AppTypography.kBold18)),
          SizedBox(height: 10.h),
          Text('Are you sure you want to logout?',
              textAlign: TextAlign.center, style: AppTypography.kLight14),
          SizedBox(height: 20.h),
          Divider(color: Colors.grey.withOpacity(0.3), height: 1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              CustomTextButton(
                  onTap: cancel,
                  text: 'Cancel',
                  textColor: isDarkMode(context) ? Colors.white : Colors.black),
              Container(
                  color: Colors.grey.withOpacity(0.3), width: 1, height: 42),
              CustomTextButton(
                  onTap: onPressedOk,
                  text: 'Logout',
                  textColor: AppColors.kPrimary),
              const SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}

void dismissLogoutDialog() {
  Get.back();
}

Future<void> showLogoutDialog(
    {required VoidCallback onPressedOk, required VoidCallback cancel}) async {
  await Get.dialog(
      LogoutDialog(
        onPressedOk: onPressedOk,
        cancel: cancel,
      ),
      barrierDismissible: false);
}

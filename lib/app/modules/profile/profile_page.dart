import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/profile/components/avatar.dart';
import 'package:task_mate/app/modules/profile/components/logout_button.dart';
import 'package:task_mate/app/modules/profile/edit_profile.dart';
import 'package:task_mate/app/modules/widgets/buttons/primary_button.dart';
import 'package:task_mate/app/modules/widgets/dialogs/logout_dialog.dart';
import 'package:task_mate/app/service/auth_service.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Setting', style: AppTypography.kSemiBold18),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: ProfileImageWidget(
              radius: 70.r,
            )),
            SizedBox(height: 20.h),
            Center(
              child: PrimaryButton(
                onTap: () {
                  Get.to(() => const EditProfile());
                },
                text: 'Edit Profile',
                fontSize: 15.sp,
                height: 45.h,
                width: 130.w,
              ),
            ),
            SizedBox(height: 30.h),
            Divider(
                color: isDarkMode(context)
                    ? AppColors.kWhite.withOpacity(0.5)
                    : AppColors.kBlack.withOpacity(0.1)),
            const Spacer(),
            Center(child: LogoutButton(onTap: () => _handleLogout(context)))
          ],
        ),
      ),
    );
  }

  Future<Object?> _handleLogout(BuildContext context) {
    return showGeneralDialog(
        barrierLabel: "Label",
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 200),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: LogoutDialog(cancel: () {
                Get.back();
              }, onPressedOk: () async {
                await AuthService().signOut();
                Get.back();
                Get.back();
              }));
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
              position:
                  Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                      .animate(anim1),
              child: child);
        });
  }
}

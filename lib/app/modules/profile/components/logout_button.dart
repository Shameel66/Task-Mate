import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/widgets/animation/bouncing_animation.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;
  const LogoutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return BouncingAnimation(
      onTap: onTap,
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
            color: AppColors.kPrimary,
            borderRadius: BorderRadius.circular(30.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppAssets.kLogout, color: AppColors.kWhite),
            SizedBox(width: 12.w),
            Text('Logout',
                style: AppTypography.kRegular16.copyWith(color: Colors.white))
          ],
        ),
      ),
    );
  }
}

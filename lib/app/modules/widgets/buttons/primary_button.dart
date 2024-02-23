import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/widgets/animation/bouncing_animation.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? color;
  final Color? borderColor;
  final double? height;
  final double? width;
  final Color? textColor;
  final double? fontSize;
  final bool isBorder;
  const PrimaryButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.color,
      this.textColor,
      this.borderColor,
      this.fontSize,
      this.isBorder = false,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return BouncingAnimation(
        onTap: onTap,
        child: Container(
          height: height ?? 50.h,
          width: width ?? double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: color ?? AppColors.kPrimary,
              border: isBorder
                  ? Border.all(color: borderColor ?? AppColors.kWhite)
                  : null),
          child: Text(text,
              style: AppTypography.kBold18.copyWith(
                  color: textColor ?? AppColors.kWhite, fontSize: fontSize)),
        ));
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_mate/app/data/constants/constants.dart';

class SettingTile extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final String icon;
  final Color iconColor;
  final bool isSwitch;
  final Function(bool)? onSwitch;
  final Widget? child;
  const SettingTile(
      {super.key,
      required this.onTap,
      required this.iconColor,
      required this.title,
      required this.icon,
      this.onSwitch,
      this.child,
      this.isSwitch = false});

  @override
  State<SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
            color: isDarkMode(context)
                ? AppColors.kBlack
                : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5.r)),
        child: Row(
          children: [
            Container(
              height: 36.h,
              width: 36.w,
              padding: EdgeInsets.all(8.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: widget.iconColor),
              child: SvgPicture.asset(widget.icon, color: AppColors.kBlack),
            ),
            SizedBox(width: 14.w),
            Text(widget.title, style: AppTypography.kRegular16),
            const Spacer(),
            widget.isSwitch
                ? widget.child!
                : Icon(Icons.arrow_forward_ios_rounded, size: 15.h)
          ],
        ),
      ),
    );
  }
}

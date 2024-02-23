import 'package:flutter/material.dart';
import 'package:task_mate/app/data/constants/constants.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? textColor;
  const CustomTextButton(
      {super.key, required this.onTap, required this.text, this.textColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft),
        child: Text(text,
            style: AppTypography.kRegular14.copyWith(
                color: textColor ?? AppColors.kBlack.withOpacity(0.6))));
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/app/data/constants/app_typography.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final String? Function(String?)? validator;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.maxLines,
    required this.hintText, this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: AppTypography.kLight14,
      decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(18.h),
          hintStyle: AppTypography.kLight14),
    );
  }
}

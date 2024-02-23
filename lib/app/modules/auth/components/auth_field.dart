import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_mate/app/data/constants/constants.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? icon;
  final String hintText;
  final bool isPassword;
  final void Function(String)? onChanged;
  const AuthField({
    super.key,
    required this.controller,
    this.validator,
    this.icon,
    required this.hintText,
    this.isPassword = false,
    this.onChanged,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? isObscure : false,
      style: AppTypography.kRegular14,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.icon != null
            ? Padding(
                padding: EdgeInsets.all(13.h),
                child: SvgPicture.asset(
                  widget.icon!,
                  colorFilter:
                      ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
                ),
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.kWhite.withOpacity(0.6)))
            : null,
      ),
    );
  }
}

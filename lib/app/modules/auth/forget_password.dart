import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/auth/components/auth_field.dart';
import 'package:task_mate/app/modules/widgets/buttons/primary_button.dart';
import 'package:task_mate/app/service/auth_service.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({
    super.key,
  });

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController emailTextFieldController =
      TextEditingController();
  final _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text('Forgot Your Password?',
                      style: AppTypography.kReallyBold22)),
              Center(
                  child: Text(
                      "No problem! Enter your email account to start the recovery process",
                      textAlign: TextAlign.center,
                      style: AppTypography.kRegular14
                          .copyWith(color: AppColors.kWhite.withOpacity(0.6)))),
              SizedBox(height: 36.h),
              AuthField(
                hintText: "Email",
                icon: AppAssets.kMail,
                controller: emailTextFieldController,
                validator: (val) {
                  if (val!.isEmpty) return "Email cannot be empty";
                  if (!val.isEmail) return "Invalid Email";
                  return null;
                },
              ),
              SizedBox(height: 36.h),
              PrimaryButton(
                text: "Send",
                onTap: () async {
                  if (emailTextFieldController.text.isNotEmpty) {
                    await _authService
                        .sendPasswordResetEmail(emailTextFieldController.text);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

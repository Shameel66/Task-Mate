import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/auth/components/auth_field.dart';
import 'package:task_mate/app/modules/auth/forget_password.dart';
import 'package:task_mate/app/modules/widgets/buttons/custom_text_button.dart';
import 'package:task_mate/app/modules/widgets/buttons/primary_button.dart';
import 'package:task_mate/app/service/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController passwordTextFieldController =
      TextEditingController();
  final TextEditingController emailTextFieldController =
      TextEditingController();
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.h),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text('Welcome Back!',
                      style: AppTypography.kReallyBold22)),
              Center(
                  child: Text("We’ve missed you! Log in with your email",
                      style: AppTypography.kLight14)),
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
              SizedBox(height: 12.h),
              AuthField(
                controller: passwordTextFieldController,
                hintText: "Password",
                isPassword: true,
                icon: AppAssets.kLock,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                    onTap: () {
                      Get.to(() => const ForgotPasswordView());
                    },
                    textColor: AppColors.kPrimary,
                    text: 'Forgot Password?'),
              ),
              SizedBox(height: 36.h),
              PrimaryButton(
                text: "Login",
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    await _authService.signInWithEmailAndPassword(
                        email: emailTextFieldController.text,
                        password: passwordTextFieldController.text);
                    Get.back();
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

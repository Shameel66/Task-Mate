import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/auth/components/auth_field.dart';
import 'package:task_mate/app/modules/widgets/buttons/primary_button.dart';
import 'package:task_mate/app/service/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController passwordTextFieldController =
      TextEditingController();
  final TextEditingController emailTextFieldController =
      TextEditingController();
  final TextEditingController fullNameTextFieldController =
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
                  child: Text('Create Account',
                      style: AppTypography.kReallyBold22)),
              Center(
                  child: Text('Create your account with your email',
                      style: AppTypography.kLight14)),
              SizedBox(height: 36.h),
              AuthField(
                hintText: "Your Name",
                icon: AppAssets.kUsername,
                controller: fullNameTextFieldController,
                validator: (val) {
                  if (val!.isEmpty) return "Name cannot be empty";
                  return null;
                },
              ),
              SizedBox(height: 12.h),
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
              SizedBox(height: 36.h),
              PrimaryButton(
                text: "Sign Up",
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    await _authService.signUpWithEmailAndPassword(
                      name: fullNameTextFieldController.text.trim(),
                      emailAddress: emailTextFieldController.text.trim(),
                      password: passwordTextFieldController.text.trim(),
                    );
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

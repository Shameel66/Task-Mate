import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/controllers/auth_controller.dart';
import 'package:task_mate/app/controllers/user_controller.dart';
import 'package:task_mate/app/modules/home/home_page.dart';
import 'package:task_mate/app/modules/onboarding/onboarding_page.dart';

class AuthWrapperPage extends GetWidget<AuthController> {
  const AuthWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var user = controller.user;

      if (user == null || user.isAnonymous) {
        return const OnboardingPage();
      }

      UserController uc = Get.put(UserController(), permanent: true);

      var myUser = uc.currentUser.value;

      if (myUser == null) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.red,
        ));
      }

      return const HomePage();
    });
  }
}

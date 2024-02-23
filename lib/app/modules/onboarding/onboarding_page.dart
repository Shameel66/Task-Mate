import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/model/onboarding_model.dart';
import 'package:task_mate/app/modules/auth/signin_page.dart';
import 'package:task_mate/app/modules/auth/signup_page.dart';
import 'package:task_mate/app/modules/widgets/buttons/primary_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.kOnboardingImage),
                fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12.r),
              ),
              color: AppColors.kWhite.withOpacity(0.8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              SizedBox(
                  height: 160.h,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        _currentIndex = value;
                      });
                    },
                    itemCount: onboardingList.length,
                    itemBuilder: (ctx, i) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            onboardingList[i].title,
                            style: AppTypography.kReallyBold22,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            onboardingList[i].description,
                            style: AppTypography.kLight14,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  )),
              DotsIndicator(
                dotsCount: onboardingList.length,
                position: _currentIndex,
                decorator: DotsDecorator(
                    activeColor: AppColors.kPrimary,
                    activeSize: Size(12.h, 12.h),
                    size: Size(12.h, 12.h)),
              ),
              SizedBox(height: 20.h),
              PrimaryButton(
                  onTap: () {
                    Get.to(() => const SignUpPage());
                  },
                  text: 'Get Started'),
              SizedBox(height: 20.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: AppTypography.kRegular14.copyWith(color: AppColors.kBlack),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Sign In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const SignInPage());
                          },
                        style: AppTypography.kBold14
                            .copyWith(color: AppColors.kPrimary)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

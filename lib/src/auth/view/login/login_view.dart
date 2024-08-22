// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/divider/auth_divider.dart';
import 'package:hi_coach/core/common/widget/heading/heading.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/app_images.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/conifg/strings.dart';
import 'package:hi_coach/core/utils/validators/vallidators.dart';
import 'package:hi_coach/src/auth/controller/login_controller.dart';
import 'package:hi_coach/src/auth/view/signup/who_you_are.dart';
import 'package:hi_coach/src/auth/widget/auth_button.dart';
import 'package:hi_coach/src/auth/widget/auth_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isLoading.value,
          progressIndicator: circularProgress(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
            child: ListView(
              children: [
                SizedBox(height: 12.h),
                TitleSubtitle(
                  title: AppStrings.login,
                  subtitle: Text(
                    AppStrings.loginSubtitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 50.h),
                Form(
                    key: controller.loginFormKey.value,
                    child: Column(
                      children: [
                        AuthField(
                          validator: (value) => TValidator.validateEmail(value),
                          controller: controller.email.value,
                          hintText: 'Enter your email',
                          suffixIcon: const Icon(Icons.phone_android_rounded),
                        ),
                        SizedBox(height: 12.h),
                        AuthField(
                          validator: (value) =>
                              TValidator.validatePassword(value),
                          controller: controller.password.value,
                          hintText: 'Enter your Password',
                          obsecure: controller.obsecure.value,
                          suffixIcon: const Icon(Icons.visibility_sharp),
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5.w),
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: AppColors.border)),
                    ),
                    Text(
                      AppStrings.rememberMe,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColors.hintText),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                              color: const Color(0xffFF3951), fontSize: 12.sp),
                        )),
                  ],
                ),
                SizedBox(height: 50.h),
                const AuthDivider(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.google),
                    SizedBox(width: 30.w),
                    Image.asset(AppImages.facebook),
                  ],
                ),
                SizedBox(height: 30.h),
                AuthButton(
                  label: 'Continue',
                  onPressed: () {
                    if (controller.loginFormKey.value.currentState!
                        .validate()) {
                      controller.loginWithEmailPassword();
                    }
                  },
                ),
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don’t have an account? ',
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.sp),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => const WhoYouAre(
                                  isSocialLogin: false,
                                )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: ListView(
              children: [
                const SizedBox(height: 12),
                TitleSubtitle(
                  title: AppStrings.login,
                  subtitle: Text(
                    AppStrings.loginSubtitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 50),
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
                        const SizedBox(height: 12),
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
                      margin: const EdgeInsets.only(right: 5),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
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
                        child: const Text(
                          'Forget Password?',
                          style:
                              TextStyle(color: Color(0xffFF3951), fontSize: 12),
                        )),
                  ],
                ),
                const SizedBox(height: 50),
                const AuthDivider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.google),
                    const SizedBox(width: 30),
                    Image.asset(AppImages.facebook),
                  ],
                ),
                const SizedBox(height: 30),
                AuthButton(
                  label: 'Continue',
                  onPressed: () {
                    if (controller.loginFormKey.value.currentState!
                        .validate()) {
                      controller.loginWithEmailPassword();
                    }
                  },
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Don’t have an account? ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 18),
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

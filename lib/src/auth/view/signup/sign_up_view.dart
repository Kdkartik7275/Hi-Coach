import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/date/date_picker.dart';
import 'package:hi_coach/core/common/widget/heading/heading.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/conifg/strings.dart';
import 'package:hi_coach/core/utils/validators/vallidators.dart';
import 'package:hi_coach/src/auth/controller/signup_controller.dart';
import 'package:hi_coach/src/auth/widget/auth_button.dart';
import 'package:hi_coach/src/auth/widget/auth_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final String userType = Get.arguments ?? '';
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: Obx(
        () => LoadingOverlay(
          progressIndicator: circularProgress(context),
          isLoading: controller.registering.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: ListView(
              children: [
                TitleSubtitle(title: AppStrings.signup),
                const SizedBox(height: 30),

                // REGISTER USER FORM

                Form(
                    key: controller.formKey.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FULL NAME
                        Text(
                          'Full Name',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.hintText),
                        ),
                        AuthField(
                            hintText: 'Enter your full name',
                            validator: (value) => TValidator.validateEmptyText(
                                'Full Name', value),
                            controller: controller.fullName.value),

                        const SizedBox(height: 14),
                        // EMAIL
                        Text(
                          'Email',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.hintText),
                        ),
                        AuthField(
                            hintText: 'Enter your email',
                            validator: (value) =>
                                TValidator.validateEmail(value),
                            controller: controller.email.value),
                        const SizedBox(height: 14),
                        // PASSWORD

                        Text(
                          'Password',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.hintText),
                        ),
                        AuthField(
                            validator: (value) =>
                                TValidator.validatePassword(value),
                            obsecure: controller.obsecure.value,
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                                onPressed: () => controller.toggleObsecure(),
                                icon: Icon(controller.obsecure.value
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            controller: controller.password.value),
                        const SizedBox(height: 14),
                        // PHONE NUMBER

                        Text(
                          'Phone Number',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.hintText),
                        ),
                        Row(
                          children: [
                            Container(
                                height: 54,
                                width: 80,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: AppColors.border)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "+${controller.selectedCountry.value!.phoneCode}"),
                                    GestureDetector(
                                        onTap: () {
                                          showCountryPicker(
                                              context: context,
                                              onSelect: (country) {
                                                controller.selectedCountry
                                                    .value = country;
                                              });
                                        },
                                        child:
                                            const Icon(Icons.arrow_drop_down))
                                  ],
                                )),
                            const SizedBox(width: 15),
                            Expanded(
                                child: AuthField(
                                    hintText: '',
                                    validator: (value) =>
                                        TValidator.validatePhoneNumber(value),
                                    controller: controller.phone.value)),
                          ],
                        ),
                      ],
                    )),

                const SizedBox(height: 14),
                Text(
                  'DOB',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.hintText),
                ),

                DatePicker(
                  date: (date) => controller.date.value = date!,
                  month: (month) => controller.month.value = month!,
                  year: (year) => controller.year.value = year!,
                ),
                const SizedBox(height: 30),
                AuthButton(
                  label: 'Register',
                  onPressed: () {
                    controller.registerUser(userType);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

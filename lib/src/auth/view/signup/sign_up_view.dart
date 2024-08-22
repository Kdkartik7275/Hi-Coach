import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
            child: ListView(
              children: [
                TitleSubtitle(title: AppStrings.signup),
                SizedBox(height: 30.h),

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

                        SizedBox(height: 14.h),
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
                        SizedBox(height: 14.h),
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
                        SizedBox(height: 14.h),
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
                                height: 54.h,
                                width: 80.w,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border:
                                        Border.all(color: AppColors.border)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "+${controller.selectedCountry.value!.phoneCode}",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
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
                            SizedBox(width: 15.w),
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

                SizedBox(height: 14.h),
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
                SizedBox(height: 30.h),
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

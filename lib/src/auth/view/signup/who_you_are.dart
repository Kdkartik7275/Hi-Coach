// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/conifg/app_pages.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/conifg/strings.dart';

class WhoYouAre extends StatelessWidget {
  final bool isSocialLogin;
  const WhoYouAre({
    super.key,
    required this.isSocialLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200.h),
            Text('I am a', style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 50.h),
            InkWell(
              onTap: () {
                if (isSocialLogin) {
                } else {
                  Get.toNamed(Routes.SIGN_UP, arguments: 'Student');
                }
              },
              child: Container(
                height: 61.h,
                width: 271.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.filled.withOpacity(0.5)),
                child: Center(
                  child: Text(
                    'Student',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                if (isSocialLogin) {
                } else {
                  Get.toNamed(Routes.SIGN_UP, arguments: 'Coach');
                }
              },
              child: Container(
                height: 61.h,
                width: 271.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.primary),
                child: Center(
                  child: Text(
                    'Coach',
                    style: TextStyle(color: AppColors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

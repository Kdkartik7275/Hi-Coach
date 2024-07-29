// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/conifg/app_pages.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/conifg/strings.dart';

class WhoYouAre extends StatelessWidget {
  final bool isSocialLogin;
  const WhoYouAre({
    Key? key,
    required this.isSocialLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200),
            Text('I am a', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                if (isSocialLogin) {
                } else {
                  Get.toNamed(Routes.SIGN_UP, arguments: 'Student');
                }
              },
              child: Container(
                height: 61,
                width: 271,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.filled.withOpacity(0.5)),
                child: const Center(
                  child: Text(
                    'Student',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                if (isSocialLogin) {
                } else {
                  Get.toNamed(Routes.SIGN_UP, arguments: 'Coach');
                }
              },
              child: Container(
                height: 61,
                width: 271,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary),
                child: const Center(
                  child: Text(
                    'Coach',
                    style: TextStyle(color: AppColors.white, fontSize: 16),
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

import 'package:flutter/material.dart';

import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/conifg/strings.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text(
          AppStrings.appName,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: AppColors.white, letterSpacing: 1.0),
        ),
      ),
    );
  }
}

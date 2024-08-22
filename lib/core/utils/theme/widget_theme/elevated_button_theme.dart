import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_coach/core/conifg/colors.dart';

/* -- Light & Dark Elevated Button Themes -- */
class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.filled,
      disabledBackgroundColor: AppColors.filled,
      side: const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.all(10),
      textStyle: GoogleFonts.raleway().copyWith(
          fontSize: 16.sp, color: AppColors.white, fontWeight: FontWeight.w700),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
    ),
  );
}

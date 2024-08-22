import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_coach/core/conifg/colors.dart';

/// Custom Class for Light & Dark Text Themes
class TTextTheme {
  TTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.raleway().copyWith(
        fontSize: 32.0.sp, fontWeight: FontWeight.w900, color: AppColors.black),
    headlineMedium: GoogleFonts.raleway().copyWith(
        fontSize: 30.sp, fontWeight: FontWeight.w700, color: AppColors.black),
    headlineSmall: GoogleFonts.raleway().copyWith(
        fontSize: 24.0.sp, fontWeight: FontWeight.w500, color: AppColors.black),
    titleLarge: GoogleFonts.raleway().copyWith(
        fontSize: 16.0.sp, fontWeight: FontWeight.w500, color: AppColors.black),
    titleMedium: GoogleFonts.raleway().copyWith(
        fontSize: 19.0.sp, fontWeight: FontWeight.w700, color: AppColors.black),
    titleSmall: GoogleFonts.raleway().copyWith(
        fontSize: 14.0.sp, fontWeight: FontWeight.w600, color: AppColors.black),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: const Color.fromRGBO(0, 0, 0, 0.5),
    suffixIconColor: const Color.fromRGBO(0, 0, 0, 0.5),
    labelStyle: GoogleFonts.raleway(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.hintText),
    hintStyle: GoogleFonts.raleway(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.hintText),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(width: 1, color: AppColors.border),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(width: 1, color: AppColors.border),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(width: 1, color: AppColors.focusedBorder),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(width: 1, color: Colors.orange),
    ),
  );
}

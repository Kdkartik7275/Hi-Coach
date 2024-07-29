import 'package:flutter/material.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/utils/theme/widget_theme/appbar_theme.dart';
import 'package:hi_coach/core/utils/theme/widget_theme/elevated_button_theme.dart';
import 'package:hi_coach/core/utils/theme/widget_theme/textfield_theme.dart';
import 'package:hi_coach/core/utils/theme/widget_theme/texttheme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.primary,
        elevation: 0,
      ));
}

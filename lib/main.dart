import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/splash/controller/splash_controller.dart';
import 'firebase_options.dart';
import 'package:hi_coach/core/conifg/app_pages.dart';
import 'package:hi_coach/core/conifg/strings.dart';
import 'package:hi_coach/core/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    Get.put(ProfileController());
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

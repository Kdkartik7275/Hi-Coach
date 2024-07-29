import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/network/connection_checker.dart';
import 'package:hi_coach/services/authentication/login_services.dart';
import 'package:hi_coach/src/bottom_nav_bar/views/bottom_navbar_view.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class LoginController extends GetxController {
  var email = Rx<TextEditingController>(TextEditingController());
  var password = Rx<TextEditingController>(TextEditingController());

  var loginFormKey = Rx<GlobalKey<FormState>>(GlobalKey());

  // Observable variables

  var obsecure = true.obs;
  var isLoading = false.obs;

  // Services
  final services = LoginServices();
  final connectionChecker = ConnectionCheckerImpl(InternetConnection());

  toggleObsecure() {
    obsecure.value = !obsecure.value;
  }

  void loginWithEmailPassword() async {
    try {
      isLoading.value = true;
      final credential = await services.loginWithEmailAndPassword(
          email: email.value.text, password: password.value.text);

      if (credential.user != null) {
        isLoading.value = false;
        Get.offAll(() => const BottomNavbarView());
      }
    } catch (e) {
      isLoading.value = false;

      Get.snackbar("Login Error", e.toString());
    }
  }
}

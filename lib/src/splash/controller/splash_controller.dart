import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/conifg/app_pages.dart';
import 'package:hi_coach/src/bottom_nav_bar/views/bottom_navbar_view.dart';

class SplashController extends GetxController {
  late Rx<User?> _user;

  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        _user = Rx<User?>(FirebaseAuth.instance.currentUser);
        _user.bindStream(FirebaseAuth.instance.authStateChanges());
        ever(_user, _setInitialView);
      },
    );
  }

  _setInitialView(User? user) async {
    if (user == null) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.offAll(() => const BottomNavbarView());
    }
  }
}

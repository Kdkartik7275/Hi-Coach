import 'package:get/get.dart';
import 'package:hi_coach/src/bottom_nav_bar/controller/bottom_navbar_controller.dart';

class BottomNavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavBarController>(() => BottomNavBarController());
  }
}

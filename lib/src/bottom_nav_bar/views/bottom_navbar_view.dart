import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/src/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:hi_coach/src/bottom_nav_bar/views/coach_bootm_navbar_view.dart';
import 'package:hi_coach/src/bottom_nav_bar/views/student_bottom_navbar_view.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';

class BottomNavbarView extends StatefulWidget {
  const BottomNavbarView({super.key});

  @override
  State<BottomNavbarView> createState() => _BottomNavbarViewState();
}

class _BottomNavbarViewState extends State<BottomNavbarView> {
  final controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.fetchCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavBarController());
    return Obx(
      () => Scaffold(
        body: LoadingOverlay(
            isLoading: controller.profileLoading.value,
            progressIndicator: circularProgress(context),
            child: controller.user != null
                ? controller.user!.userType == 'Student'
                    ? const StudentBottomNavbarView()
                    : const CoachBootmNavbarView()
                : const SizedBox()),
      ),
    );
  }
}

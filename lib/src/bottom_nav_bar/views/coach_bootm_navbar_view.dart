import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/controllers/location_controller.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/bottom_nav_bar/controller/bottom_navbar_controller.dart';

class CoachBootmNavbarView extends GetView<BottomNavBarController> {
  const CoachBootmNavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('HiCoach'),
        ),
        body: controller.coachPages[controller.selectedIndex.value],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.border,
            onTap: controller.onItemTapped,
            elevation: 0,
            iconSize: 30,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}

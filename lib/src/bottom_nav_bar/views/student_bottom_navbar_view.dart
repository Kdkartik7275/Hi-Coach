import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/conifg/app_images.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/conifg/strings.dart';
import 'package:hi_coach/src/bottom_nav_bar/controller/bottom_navbar_controller.dart';

class StudentBottomNavbarView extends GetView<BottomNavBarController> {
  const StudentBottomNavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.appName)),
        body: controller.studentPages[controller.selectedIndex.value],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(AppIcons.home),
                activeIcon:
                    Image.asset(AppIcons.home, color: AppColors.primary),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppIcons.search),
                activeIcon:
                    Image.asset(AppIcons.search, color: AppColors.primary),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppIcons.book),
                activeIcon:
                    Image.asset(AppIcons.book, color: AppColors.primary),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppIcons.favourite),
                activeIcon:
                    Image.asset(AppIcons.favourite, color: AppColors.primary),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppIcons.profile),
                activeIcon:
                    Image.asset(AppIcons.profile, color: AppColors.primary),
                label: '',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.border,
            onTap: controller.onItemTapped,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}

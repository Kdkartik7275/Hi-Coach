import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/conifg/strings.dart';
import 'package:hi_coach/core/utils/constants/sports.dart';
import 'package:hi_coach/src/bottom_nav_bar/views/bottom_navbar_view.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/search/controller/search_controller.dart';
import 'package:hi_coach/src/search/views/nearby_coaches.dart';

class CategoryView extends StatefulWidget {
  bool isSearchScreen;
  CategoryView({
    super.key,
    this.isSearchScreen = false,
  });

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    if (widget.isSearchScreen) {
      Get.put(SearchCoachesController());
    }
    return Scaffold(
      appBar: widget.isSearchScreen
          ? null
          : AppBar(
              title: const Text(AppStrings.appName),
            ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  'Find the right coach for you',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 20.h),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  children: List.generate(
                      categories.length,
                      (index) => GestureDetector(
                            onTap: () {
                              if (widget.isSearchScreen) {
                                Get.find<SearchCoachesController>()
                                    .selectedSport
                                    .value = categories[index].sport;
                                Get.to(() => const NearbyCoaches());
                              } else {
                                controller.updatingStudentInfo(
                                    {
                                      'sport': FieldValue.arrayUnion(
                                          [categories[index].sport])
                                    },
                                    () => Get.offAll(
                                        () => const BottomNavbarView()));
                              }
                            },
                            child: Container(
                              height: 110.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: AppColors.primary),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(categories[index].iconData),
                                  Text(
                                    categories[index].sport,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                          )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

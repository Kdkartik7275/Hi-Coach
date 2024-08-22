// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/image/pick_image.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/conifg/strings.dart';
import 'package:hi_coach/core/utils/constants/sports.dart';
import 'package:hi_coach/src/auth/view/signup/coach_profile.dart';
import 'package:hi_coach/src/auth/widget/auth_button.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CoachInitialization extends StatefulWidget {
  final String fullName;
  const CoachInitialization({
    super.key,
    required this.fullName,
  });

  @override
  State<CoachInitialization> createState() => _CoachInitializationState();
}

class _CoachInitializationState extends State<CoachInitialization> {
  List<String> selectedSports = [];

  selectSports(String sport) {
    if (selectedSports.contains(sport)) {
      setState(() {
        selectedSports.remove(sport);
      });
    } else {
      setState(() {
        selectedSports.add(sport);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.updatingInfo.value,
          progressIndicator: circularProgress(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 30.h),
              child: Center(
                child: Column(
                  children: [
                    const PickImage(),
                    SizedBox(height: 10.h),
                    Text(
                      widget.fullName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 60.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sport',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.hintText),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 30,
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15),
                      children: List.generate(
                        sportsName.length,
                        (index) => GestureDetector(
                          onTap: () {
                            selectSports(sportsName[index]);
                          },
                          child: Container(
                            width: 110.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color:
                                    selectedSports.contains(sportsName[index])
                                        ? AppColors.primary
                                        : AppColors.filled),
                            child: Center(
                              child: Text(
                                sportsName[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    AuthButton(
                      label: 'Done',
                      onPressed: () {
                        controller.setUserProfilePicture('Coach', () {
                          if (selectedSports.isEmpty) {
                            Get.snackbar('Error', "Please select sport");
                          } else {
                            controller.updatingCoachInfo({
                              'sports': FieldValue.arrayUnion(selectedSports)
                            }, () {
                              Get.offAll(() => const CoachProfile());
                            });
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

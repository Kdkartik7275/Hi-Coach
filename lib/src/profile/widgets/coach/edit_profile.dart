import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/views/coach/coach_edit_profile.dart';

class EditAndShareProfileButton extends StatelessWidget {
  const EditAndShareProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // EDIT PROFILE
        GestureDetector(
          onTap: () => Get.to(() => const CoachEditProfileView()),
          child: TRoundedContainer(
            backgroundColor: AppColors.text,
            height: 30.h,
            width: 100.w,
            radius: 5.r,
            child: const Center(
                child: Text(
              'Edit Profile',
              style: TextStyle(color: AppColors.white),
            )),
          ),
        ),
        SizedBox(width: 10.w),
        // SHARE PROFILE
        GestureDetector(
          onTap: () => Get.to(() => const CoachEditProfileView()),
          child: TRoundedContainer(
            backgroundColor: AppColors.filled,
            height: 30.h,
            width: 100.w,
            radius: 5.r,
            child: const Center(
                child: Text(
              'Share Profile',
              style: TextStyle(color: AppColors.black),
            )),
          ),
        ),
      ],
    );
  }
}

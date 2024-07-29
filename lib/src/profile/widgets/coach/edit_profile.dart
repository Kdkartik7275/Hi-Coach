import 'package:flutter/material.dart';
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
          child: const TRoundedContainer(
            backgroundColor: AppColors.text,
            height: 30,
            width: 100,
            radius: 5,
            child: Center(
                child: Text(
              'Edit Profile',
              style: TextStyle(color: AppColors.white),
            )),
          ),
        ),
        const SizedBox(width: 10),
        // SHARE PROFILE
        GestureDetector(
          onTap: () => Get.to(() => const CoachEditProfileView()),
          child: const TRoundedContainer(
            backgroundColor: AppColors.filled,
            height: 30,
            width: 100,
            radius: 5,
            child: Center(
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

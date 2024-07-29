import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class PickImage extends GetView<ProfileController> {
  const PickImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.filled,
            backgroundImage: controller.profilePic.value != null
                ? FileImage(File(controller.profilePic.value!.path))
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                controller.pickProfileImage();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.white),
                child: const Center(
                  child: Icon(Icons.add_a_photo_outlined),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

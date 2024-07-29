// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/dialog/family_dialog.dart';
import 'package:hi_coach/core/common/widget/image/pick_image.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/conifg/strings.dart';
import 'package:hi_coach/src/auth/widget/auth_button.dart';
import 'package:hi_coach/src/category_view.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';

class StudentInitialization extends GetView<ProfileController> {
  final String fullName;
  const StudentInitialization({
    Key? key,
    required this.fullName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Column(
                  children: [
                    const PickImage(),
                    const SizedBox(height: 10),
                    Text(
                      fullName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 60),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Family',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.hintText),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AddFamilyDialog();
                            });
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.filled),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Add Family'),
                            SizedBox(width: 5),
                            Icon(Icons.add_circle_outline)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    AuthButton(
                      label: 'Done',
                      onPressed: () {
                        if (controller.profilePic.value != null) {
                          controller.setUserProfilePicture('Student', () {
                            controller.profilePic.value = null;
                            Get.offAll(() => CategoryView());
                          });
                        } else {
                          Get.offAll(() => CategoryView());
                        }
                      },
                    ),
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

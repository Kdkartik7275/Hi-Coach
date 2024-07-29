// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/edit_profile_controller.dart';
import 'package:hi_coach/src/profile/widgets/coach/add_package_dialog.dart';
import 'package:hi_coach/src/profile/widgets/coach/add_price_dialog.dart';
import 'package:hi_coach/src/profile/widgets/coach/coach_info_tab.dart';
import 'package:hi_coach/src/profile/widgets/coach/location_search_field.dart';
import 'package:hi_coach/src/profile/widgets/coach/packages.dart';
import 'package:hi_coach/src/profile/widgets/coach/pricings.dart';
import 'package:hi_coach/src/profile/widgets/key_value.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CoachEditProfileView extends GetView<EditProfileController> {
  const CoachEditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
              onPressed: () {
                controller.updateCoachProfileInfo();
              },
              child: Text(
                'Done',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: const Color(0xff2A76BC)),
              ))
        ],
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.loading.value,
          progressIndicator: circularProgress(context),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -------------- COACH PROFILE IMAGES ------------
                  SizedBox(
                      height: 150,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Row(
                              children: List.generate(
                                  controller.profiles.value.length,
                                  (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: TCachedNetworkImage(
                                            radius: 0,
                                            profileURL: controller
                                                .profiles.value[index],
                                            height: 150,
                                            width: 120),
                                      )),
                            ),
                            TRoundedContainer(
                              height: 150,
                              width: 120,
                              backgroundColor: AppColors.filled,
                              child: Center(
                                child: IconButton(
                                  onPressed: () =>
                                      controller.uploadNewProfile(),
                                  icon: const Icon(
                                    Icons.add,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 20),

                  // --------- COACH DETAILS --------------
                  KeyValue(
                      hintText: 'Full Name',
                      title: 'Name',
                      controller: controller.name),
                  const SizedBox(height: 10),
                  KeyValue(
                      hintText: 'Phone No.',
                      title: 'Contact',
                      controller: controller.phone),
                  const SizedBox(height: 10),
                  KeyValue(
                    hintText: 'Postal Code (For nearby students)',
                    title: 'Location',
                    controller: controller.location,
                  ),
                  const SizedBox(height: 20),

                  // COACHING AREAS

                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500.0,
                    ),
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      alignment: WrapAlignment.start,
                      children: List.generate(
                          controller.coachingAreas.value.length, (index) {
                        return TRoundedContainer(
                          height: 35,
                          width: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          backgroundColor: AppColors.primary,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.coachingAreas.value[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 16),
                          ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(
                      height:
                          controller.coachingAreas.value.isNotEmpty ? 20 : 0),

                  // ----------- LOCATION SEARCH FIELD --------------

                  SearchAreasField(controller: controller),

                  // SUGGESTIONS

                  if (controller.suggestions.value.isNotEmpty)
                    ...List.generate(
                      controller.suggestions.value.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            controller
                                .addAreas(controller.suggestions.value[index]);
                          },
                          child: TRoundedContainer(
                            height: 30,
                            // backgroundColor: AppColors.filled,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            margin: const EdgeInsets.only(top: 10),
                            radius: 0,
                            child: Text(controller.suggestions.value[index],
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 40),
                  CoachInfoTab(
                      hintText:
                          'Tell us about yourself and your teaching style...',
                      title: 'Bio',
                      controller: controller.bio),
                  CoachInfoTab(
                    hintText: 'Tell us about the level you were playing at...',
                    title: 'Playing Experience',
                    controller: controller.playExperience,
                  ),
                  CoachInfoTab(
                      hintText: 'Tell us about your coaching experience...',
                      title: 'Coaching Experience',
                      controller: controller.coachingExperience),
                  Text('Certifications',
                      style: Theme.of(context).textTheme.titleMedium!),

                  // --------------- ADD CERTIFICATIONS BUTTON -----------------
                  SizedBox(
                      height: 150,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Row(
                              children: List.generate(
                                  controller.certifications.value.length,
                                  (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: TCachedNetworkImage(
                                            profileURL: controller
                                                .certifications.value[index],
                                            radius: 0,
                                            height: 150,
                                            width: 120),
                                      )),
                            ),
                            TRoundedContainer(
                              height: 150,
                              width: 120,
                              backgroundColor: AppColors.filled,
                              child: Center(
                                child: IconButton(
                                  onPressed: () =>
                                      controller.uploadNewCertification(),
                                  icon: const Icon(
                                    Icons.add,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

                  // --------------- PRICING ------------------

                  const SizedBox(height: 20),
                  Text('Pricing',
                      style: Theme.of(context).textTheme.titleMedium!),
                  const SizedBox(height: 10),

                  // SHOW ALL PRICINGS
                  Pricings(controller: controller),
                  const SizedBox(height: 10),

                  // BUTTON TO ADD PRICING
                  ElevatedButton(
                    onPressed: () {
                      Get.dialog(AddPricingDialog(controller: controller));
                    },
                    child: const Text(
                      'Add Pricing',
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),

                  // ---------------- PACKAGES --------------------

                  const SizedBox(height: 20),
                  if (controller.initialPrices.value.isNotEmpty) ...[
                    Text('Packages',
                        style: Theme.of(context).textTheme.titleMedium!),
                    const SizedBox(height: 10),

                    // SHOW ALL PACKAGES
                    Packages(controller: controller),
                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {
                        Get.dialog(AddPackageDialog(controller: controller));
                      },
                      child: const Text(
                        'Add Package',
                        style: TextStyle(color: AppColors.black),
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

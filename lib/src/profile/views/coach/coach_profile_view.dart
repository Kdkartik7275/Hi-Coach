// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/profile/widgets/coach/about_tabs.dart';
import 'package:hi_coach/src/profile/widgets/coach/coach_pricings.dart';
import 'package:hi_coach/src/profile/widgets/coach/edit_profile.dart';
import 'package:hi_coach/src/profile/widgets/coach/info.dart';
import 'package:hi_coach/src/profile/widgets/coach/profile_header.dart';
import 'package:hi_coach/src/profile/widgets/coach/reviews.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CoachProfileView extends StatefulWidget {
  const CoachProfileView({
    super.key,
  });

  @override
  State<CoachProfileView> createState() => _CoachProfileViewState();
}

class _CoachProfileViewState extends State<CoachProfileView> {
  late double height, width;

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final coach = controller.user!;

    final size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.updatingInfo.value,
          progressIndicator: circularProgress(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // --------- PROFILE HEADER ---------------
                CoachProfileHeader(coach: coach, controller: controller),
                const SizedBox(height: 25),

                // ------------ PROFILE BUTTONS
                const EditAndShareProfileButton(),

                // ---------- COACH INFORMATION TABS ---------------
                CoachAboutTabs(controller: controller),

                // TAB BAR BODY
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: controller.coachInfoSelectedIndex.value == 0
                      ? CoachResumeWidget(coach: coach)
                      : controller.coachInfoSelectedIndex.value == 1
                          ? CoachPricingWidget(
                              controller: controller, coachID: coach.id)
                          : const CoachReviewWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserReview extends StatelessWidget {
  const UserReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(radius: 25.r),
          title: const Text('Kartik Dhiman'),
          subtitle: Row(
            children: [
              Row(
                children: List.generate(
                    5,
                    (index) =>
                        const Icon(Icons.star, color: Colors.amber, size: 15)),
              ),
              const SizedBox(width: 5),
              const Text('2 min ago')
            ],
          ),
          trailing: IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
        ),
        const Text(
          'Consequat velit qui adipisicing sunt do rependerit ad laborum tempor ullamco exercitation. Ullamco tempor adipisicing et voluptate duis sit esse aliqua',
        ),
        const SizedBox(height: 6),
        const Divider(
          color: AppColors.filled,
        ),
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/buttons/profile_button.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/app_pages.dart';
import 'package:hi_coach/models/coach.dart';

import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/profile/widgets/coach/about_tabs.dart';
import 'package:hi_coach/src/profile/widgets/coach/coach_pricings.dart';
import 'package:hi_coach/src/profile/widgets/coach/contact_info_buttons.dart';
import 'package:hi_coach/src/profile/widgets/coach/info.dart';
import 'package:hi_coach/src/profile/widgets/coach/profile_header.dart';
import 'package:hi_coach/src/profile/widgets/coach/reviews.dart';

class CoachProfileStudentView extends StatelessWidget {
  CoachProfileStudentView({
    super.key,
    required this.coachID,
  });
  final String coachID;

  late double height, width;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    final size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: FutureBuilder<Coach?>(
          future: controller.fetchCoachByID(coachID),
          builder: (context, AsyncSnapshot<Coach?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: circularProgress(context));
            }
            if (snapshot.hasData) {
              final coach = snapshot.data!;
              return Obx(
                () => SingleChildScrollView(
                    child: Column(
                  children: [
                    // --------- PROFILE HEADER ---------------
                    CoachProfileHeader(
                        coach: coach,
                        controller: controller,
                        backRequired: true),
                    SizedBox(height: 25.h),

                    // ONLY STUDENT CAN SEE THESE
                    const CoachContactInfoButtons(),
                    SizedBox(height: 25.h),
                    ProfileButton(
                        size: Size(width * 0.85.w, height * 0.075.h),
                        label: 'Book Now',
                        onPressed: () =>
                            Get.toNamed(Routes.SELECTDATE, arguments: {
                              'coach': coach,
                              'rating': 0 // AVERAGE RATING OF COACH
                            })),
                    SizedBox(height: 25.h),

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
                )),
              );
            }
            return const SizedBox();
          }),
    );
  }
}

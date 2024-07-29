import 'package:flutter/material.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/profile/widgets/coach/info_text.dart';

class CoachAboutTabs extends StatelessWidget {
  const CoachAboutTabs({
    super.key,
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //  TAB BARS
          InfoText(
            isSelected: controller.coachInfoSelectedIndex.value == 0,
            label: 'Resume',
            onpressed: () => controller.updateCoachInfoIndex(0),
          ),
          InfoText(
            isSelected: controller.coachInfoSelectedIndex.value == 1,
            label: 'Pricing',
            onpressed: () => controller.updateCoachInfoIndex(1),
          ),
          InfoText(
            isSelected: controller.coachInfoSelectedIndex.value == 2,
            label: 'Reviews',
            onpressed: () => controller.updateCoachInfoIndex(2),
          ),
        ],
      ),
    );
  }
}

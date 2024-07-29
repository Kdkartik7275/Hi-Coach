import 'package:flutter/material.dart';
import 'package:hi_coach/core/common/widget/buttons/profile_info_button.dart';
import 'package:hi_coach/core/conifg/app_images.dart';

class CoachContactInfoButtons extends StatelessWidget {
  const CoachContactInfoButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileInfoButton(
          title: 'Call',
          child: Image.asset(AppIcons.call),
        ),
        const SizedBox(width: 25),
        ProfileInfoButton(
          title: 'Message',
          child: Image.asset(AppIcons.message),
        ),
        const SizedBox(width: 25),
        ProfileInfoButton(
          title: 'Share',
          child: Image.asset(AppIcons.share),
        ),
      ],
    );
  }
}

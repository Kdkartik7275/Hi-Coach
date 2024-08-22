import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        SizedBox(width: 25.w),
        ProfileInfoButton(
          title: 'Message',
          child: Image.asset(AppIcons.message),
        ),
        SizedBox(width: 25.w),
        ProfileInfoButton(
          title: 'Share',
          child: Image.asset(AppIcons.share),
        ),
      ],
    );
  }
}

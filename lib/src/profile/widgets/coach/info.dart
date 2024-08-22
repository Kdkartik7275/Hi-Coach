import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_coach/core/common/widget/heading/heading.dart';
import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/models/coach.dart';

class CoachResumeWidget extends StatelessWidget {
  const CoachResumeWidget({
    super.key,
    required this.coach,
  });
  final Coach coach;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleSubtitle(padding: EdgeInsets.zero, title: 'Bio'),
        Text(coach.bio,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.text)),
        SizedBox(height: 20.h),
        TitleSubtitle(padding: EdgeInsets.zero, title: 'Playing Experience'),
        Text(coach.playingExperience!,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.text)),
        SizedBox(height: 20.h),
        TitleSubtitle(padding: EdgeInsets.zero, title: 'Certifications'),
        Row(
          children: List.generate(coach.certifications!.length, (index) {
            return SizedBox(
              child: TCachedNetworkImage(
                  profileURL: coach.certifications![index],
                  height: 100.h,
                  radius: 0,
                  boxFit: BoxFit.contain,
                  width: 100.w),
            );
          }),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}

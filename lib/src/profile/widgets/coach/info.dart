import 'package:flutter/material.dart';
import 'package:hi_coach/core/common/widget/heading/heading.dart';
import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/models/user.dart';

class CoachResumeWidget extends StatelessWidget {
  const CoachResumeWidget({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleSubtitle(padding: EdgeInsets.zero, title: 'Bio'),
        Text(user.bio,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.text)),
        const SizedBox(height: 20),
        TitleSubtitle(padding: EdgeInsets.zero, title: 'Playing Experience'),
        Text(user.playingExperience!,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.text)),
        const SizedBox(height: 20),
        TitleSubtitle(padding: EdgeInsets.zero, title: 'Certifications'),
        Row(
          children: List.generate(user.certifications!.length, (index) {
            return SizedBox(
              child: TCachedNetworkImage(
                  profileURL: user.certifications![index],
                  height: 100,
                  radius: 0,
                  boxFit: BoxFit.contain,
                  width: 100),
            );
          }),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

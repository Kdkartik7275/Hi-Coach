import 'package:flutter/material.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class ProfileInfoButton extends StatelessWidget {
  final Widget child;
  final String title;
  const ProfileInfoButton({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          height: 60,
          width: 60,
          radius: 10,
          backgroundColor: AppColors.primary,
          child: Center(
            child: child,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: const Color(0xff3F3F3F)),
        ),
      ],
    );
  }
}

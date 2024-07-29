import 'package:flutter/material.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.size = const Size(271, 61),
      this.backgroundColor = AppColors.primary});

  final Size size;
  final String label;
  Function()? onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: size,
            backgroundColor: backgroundColor,
            side: BorderSide(color: backgroundColor)),
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: AppColors.white),
        ));
  }
}

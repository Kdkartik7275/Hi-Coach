import 'package:flutter/material.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.size = const Size(271, 61),
      this.backgroundColor = AppColors.primary,
      this.borderColor = AppColors.white,
      this.labelColor = AppColors.white});

  final Size size;
  final String label;
  Function()? onPressed;
  final Color backgroundColor;
  final Color labelColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: size,
            backgroundColor: backgroundColor,
            side: BorderSide(color: borderColor)),
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: labelColor),
        ));
  }
}

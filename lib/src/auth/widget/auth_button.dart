import 'package:flutter/material.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class AuthButton extends StatelessWidget {
  final String label;
  Function()? onPressed;
  final Size size;
  AuthButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.size = const Size(271, 61),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: size),
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

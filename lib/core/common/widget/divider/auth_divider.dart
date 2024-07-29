import 'package:flutter/material.dart';
import 'package:hi_coach/core/conifg/strings.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 70, child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(AppStrings.signInMethod),
        ),
        SizedBox(width: 70, child: Divider()),
      ],
    );
  }
}

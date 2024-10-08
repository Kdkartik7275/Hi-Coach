import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class KeyValue extends StatelessWidget {
  const KeyValue({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w400)),
        SizedBox(width: 30.w),
        Expanded(
            child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w300),
            border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border)),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border)),
            disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border)),
          ),
        )),
      ],
    );
  }
}

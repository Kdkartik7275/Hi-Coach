import 'package:flutter/material.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class CoachInfoTab extends StatelessWidget {
  const CoachInfoTab({
    Key? key,
    this.controller,
    required this.title,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController? controller;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!,
        ),
        const SizedBox(height: 5),
        Container(
          height: 150,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: AppColors.filled),
          child: TextField(
            maxLines: null,
            maxLength: null,
            controller: controller,
            decoration: InputDecoration(
                hintText: hintText,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoText extends StatelessWidget {
  InfoText({
    super.key,
    required this.label,
    required this.isSelected,
    this.onpressed,
  });

  final String label;
  Function()? onpressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Text(label,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 20.sp,
              decoration: isSelected ? TextDecoration.underline : null)),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/models/student.dart';

class InvitedStudentTile extends StatelessWidget {
  const InvitedStudentTile({
    super.key,
    required this.student,
    this.onTap,
    this.onLongPress,
    this.isNameRequired = true,
  });

  final Student student;
  final Function()? onTap;
  final Function()? onLongPress;
  final bool isNameRequired;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: TCachedNetworkImage(
                profileURL: student.profileURL![0],
                height: 60.h,
                width: 60.w,
              ),
            ),
            SizedBox(height: 10.h),
            if (isNameRequired)
              Flexible(
                child: Text(
                  student.fullName,
                  style: Theme.of(context).textTheme.titleSmall!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

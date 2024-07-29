// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/models/user.dart';

class InvitedStudentTile extends StatelessWidget {
  const InvitedStudentTile({
    super.key,
    required this.student,
    this.onTap,
    this.onLongPress,
    this.isNameRequired = true,
  });

  final UserModel student;
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
              borderRadius: BorderRadius.circular(100),
              child: TCachedNetworkImage(
                profileURL: student.profileURL![0],
                height: 60,
                width: 60,
              ),
            ),
            const SizedBox(height: 10),
            if (isNameRequired)
              Flexible(
                child: Text(
                  student.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.white),
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

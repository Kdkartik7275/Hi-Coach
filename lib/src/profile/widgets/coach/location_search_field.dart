// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/edit_profile_controller.dart';

class SearchAreasField extends StatelessWidget {
  const SearchAreasField({
    super.key,
    required this.controller,
  });
  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 40.h,
      width: 150.w,
      backgroundColor: AppColors.filled,
      borderColor: AppColors.black,
      showBorder: true,
      radius: 5.r,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      child: TextField(
        onChanged: (value) {
          controller.searchAreas(value);
        },
        decoration: InputDecoration(
            hintText: 'Search Areas',
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 14.sp),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none),
      ),
    );
  }
}

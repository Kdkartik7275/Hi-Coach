// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_coach/core/common/widget/buttons/profile_button.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';

import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/utils/constants/constants.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Booking',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30.h),
            const _BookingInfo(
                title: 'Date', value: 'Tuesday, 18 Oct     01:30pm'),
            SizedBox(height: 23.h),
            const _BookingInfo(
                title: 'Sport', value: 'Tuesday, 18 Oct     01:30pm'),
            SizedBox(height: 23.h),
            const _BookingInfo(
                title: 'Total', value: 'Tuesday, 18 Oct     01:30pm'),
            SizedBox(height: 30.h),
            Text('Address',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.hintText, fontSize: 18.sp)),
            SizedBox(height: 10.h),
            const TextField(
              decoration: InputDecoration(hintText: 'Enter Session Location'),
            ),
            SizedBox(height: 20.h),
            Text('Pax',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.hintText, fontSize: 18.sp)),
            SizedBox(height: 10.h),
            TRoundedContainer(
              height: 54.h,
              width: 60.w,
              radius: 10.r,
              borderColor: AppColors.border,
              alignment: Alignment.center,
              showBorder: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: '1',
                  dropdownColor: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  items: List.generate(
                      4,
                      (index) => DropdownMenuItem(
                            value: (index + 1).toString(),
                            child: Text(
                              (index + 1).toString(),
                            ),
                          )),
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Repeat',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppColors.hintText, fontSize: 18.sp)),
                TRoundedContainer(
                  height: 36.h,
                  radius: 10.w,
                  width: 150,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'Every Day',
                      items: List.generate(
                        repeat.length,
                        (index) => DropdownMenuItem(
                          value: repeat[index],
                          child: Text(
                            repeat[index],
                          ),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  label: 'Cancel',
                  borderColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  backgroundColor: AppColors.white,
                  onPressed: () {},
                )),
                SizedBox(width: 12.w),
                Expanded(
                    child: CustomButton(label: 'Confirm', onPressed: () {})),
              ],
            ),
            SizedBox(height: 10.h)
          ],
        ),
      ),
    );
  }
}

class _BookingInfo extends StatelessWidget {
  const _BookingInfo({
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.hintText, fontSize: 18.sp)),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.text))
      ],
    );
  }
}

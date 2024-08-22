// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class CoachPackageInfo extends StatelessWidget {
  CoachPackageInfo({
    Key? key,
    required this.label,
    required this.discountedPrice,
    required this.actualPrice,
    required this.hours,
  }) : super(key: key);

  final String label;
  final int discountedPrice;
  final int actualPrice;
  final int hours;
  Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: double.infinity,
      height: 80.h,
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      backgroundColor: AppColors.filled,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$hours Hours $label',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 17.sp, color: AppColors.text)),
              Row(
                children: [
                  Text('\$$actualPrice',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 17.sp,
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.text)),
                  SizedBox(width: 10.w),
                  Text('\$$discountedPrice',
                      style:
                          Theme.of(context).textTheme.titleMedium!.copyWith()),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: onpressed,
            child: TRoundedContainer(
              height: 70.h,
              width: 70.w,
              backgroundColor: AppColors.primary,
              radius: 10.r,
              child: Center(
                child: Text(
                  'Book Now',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 17.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

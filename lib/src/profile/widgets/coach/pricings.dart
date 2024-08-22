// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/edit_profile_controller.dart';

class Pricings extends StatelessWidget {
  const Pricings({
    super.key,
    required this.controller,
  });
  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        itemCount: controller.initialPrices.value.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final price = controller.initialPrices.value[index];
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text('${index + 1}. ',
                    style: Theme.of(context).textTheme.titleMedium),
                Text('Title', style: Theme.of(context).textTheme.titleMedium),
                SizedBox(width: 6.w),
                TRoundedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 35.h,
                  width: 120.w,
                  alignment: Alignment.centerLeft,
                  backgroundColor: AppColors.filled,
                  child: Text(price.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 16.sp)),
                ),
                SizedBox(width: 6.w),
                Text('Pax',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 16.sp, fontWeight: FontWeight.w700)),
                SizedBox(width: 6.w),
                TRoundedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  height: 35.h,
                  alignment: Alignment.center,
                  backgroundColor: AppColors.filled,
                  child: Text(price.pax.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 16.sp)),
                ),
                SizedBox(width: 6.w),
                Text('Price', style: Theme.of(context).textTheme.titleMedium),
                SizedBox(width: 6.w),
                TRoundedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  height: 35.h,
                  // width: 50,
                  radius: 10.r,
                  alignment: Alignment.centerLeft,
                  backgroundColor: AppColors.filled,
                  child: Text('\$ ${price.price.toString()}',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 16.sp)),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 15.h);
        },
      ),
    );
  }
}

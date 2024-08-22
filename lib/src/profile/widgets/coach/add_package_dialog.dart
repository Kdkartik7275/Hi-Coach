// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/utils/validators/vallidators.dart';
import 'package:hi_coach/src/profile/controller/edit_profile_controller.dart';

class AddPackageDialog extends StatelessWidget {
  const AddPackageDialog({
    super.key,
    required this.controller,
  });
  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 400.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.white,
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --------------- CLOSE BUTTON ------------------
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),

              // -------------- PACKAGE FORM -----------------
              Form(
                key: controller.packageFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE FOR PACKAGE
                    Row(
                      children: [
                        Text('Title',
                            style: Theme.of(context).textTheme.titleMedium),
                        SizedBox(width: 30.w),
                        Expanded(
                          child: Container(
                            height: 45.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            color: AppColors.filled,
                            child: Row(
                              mainAxisAlignment: controller.prices.value.isEmpty
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.packageFor.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                PopupMenuButton(
                                    initialValue: controller
                                        .initialPrices.value.first.title,
                                    color: AppColors.white,
                                    child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.arrow_drop_down,
                                            size: 30)),
                                    itemBuilder: (context) {
                                      return List.generate(
                                          controller.initialPrices.value.length,
                                          (index) {
                                        final title = controller
                                            .initialPrices.value[index].title;
                                        return PopupMenuItem(
                                            onTap: () => controller
                                                .packageFor.value = title,
                                            value: title,
                                            child: Text(title));
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // HOURS OF SESSION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hours ',
                            style: Theme.of(context).textTheme.titleMedium),
                        PopupMenuButton(
                            color: AppColors.white,
                            child: TRoundedContainer(
                              height: 40.h,
                              width: 70.w,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              backgroundColor: AppColors.filled,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(controller.pax.value.toString()),
                                  const Icon(Icons.arrow_drop_down, size: 30),
                                ],
                              ),
                            ),
                            itemBuilder: (context) {
                              return List.generate(
                                10,
                                (index) => PopupMenuItem(
                                  value: index + 1,
                                  onTap: () =>
                                      controller.hours.value = index + 1,
                                  child: Text('${index + 1}'),
                                ),
                              );
                            }),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // DISCOUNT IN %
                    Row(
                      children: [
                        Text('Discount (in %)',
                            style: Theme.of(context).textTheme.titleMedium),
                        SizedBox(width: 30.w),
                        Expanded(
                          child: TextFormField(
                            controller: controller.discount,
                            validator: (value) =>
                                TValidator.validateEmptyText('Discount', value),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Enter Discount Value',
                                filled: true,
                                fillColor: AppColors.filled,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // --------------  ADD BUTTON --------------------
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => controller.addPackage(),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: TRoundedContainer(
                      width: 80.h,
                      height: 40.w,
                      backgroundColor: AppColors.primary,
                      alignment: Alignment.center,
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/utils/validators/vallidators.dart';
import 'package:hi_coach/src/profile/controller/edit_profile_controller.dart';

class AddPricingDialog extends StatelessWidget {
  const AddPricingDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 400,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ),
              Form(
                key: controller.pricingFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title',
                        style: Theme.of(context).textTheme.titleMedium),
                    TextFormField(
                      controller: controller.title,
                      validator: (value) =>
                          TValidator.validateEmptyText('Title', value),
                      decoration: const InputDecoration(
                          hintText: 'Enter Title',
                          filled: true,
                          fillColor: AppColors.filled,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pax (No. of Students)',
                            style: Theme.of(context).textTheme.titleMedium),
                        PopupMenuButton(
                            color: AppColors.white,
                            child: TRoundedContainer(
                              height: 40,
                              width: 70,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                                100,
                                (index) => PopupMenuItem(
                                  value: index + 1,
                                  onTap: () => controller.pax.value = index + 1,
                                  child: Text('${index + 1}'),
                                ),
                              );
                            }),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Price',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(width: 30),
                        Expanded(
                          child: TextFormField(
                            controller: controller.price,
                            validator: (value) =>
                                TValidator.validateEmptyText('Price', value),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Enter Price in Rs.',
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
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => controller.addPricing(),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: TRoundedContainer(
                      width: 80,
                      height: 40,
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/edit_profile_controller.dart';

class Pricings extends StatelessWidget {
  const Pricings({
    Key? key,
    required this.controller,
  }) : super(key: key);
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
                const SizedBox(width: 6),
                TRoundedContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 35,
                  width: 120,
                  alignment: Alignment.centerLeft,
                  backgroundColor: AppColors.filled,
                  child: Text(price.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 16)),
                ),
                const SizedBox(width: 6),
                Text('Pax',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(width: 6),
                TRoundedContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 35,
                  alignment: Alignment.center,
                  backgroundColor: AppColors.filled,
                  child: Text(price.pax.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 16)),
                ),
                const SizedBox(width: 6),
                Text('Price', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(width: 6),
                TRoundedContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 35,
                  // width: 50,
                  radius: 10,
                  alignment: Alignment.centerLeft,
                  backgroundColor: AppColors.filled,
                  child: Text('\$ ${price.price.toString()}',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 16)),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 15);
        },
      ),
    );
  }
}

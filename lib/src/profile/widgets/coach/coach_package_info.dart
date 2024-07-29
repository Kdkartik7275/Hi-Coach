// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
      height: 80,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      .copyWith(fontSize: 17, color: AppColors.text)),
              Row(
                children: [
                  Text('\$$actualPrice',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 17,
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.text)),
                  const SizedBox(width: 10),
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
              height: 70,
              width: 70,
              backgroundColor: AppColors.primary,
              radius: 10,
              child: Center(
                child: Text(
                  'Book Now',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 17),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

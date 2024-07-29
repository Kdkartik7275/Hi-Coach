import 'package:flutter/material.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class CoachPriceContainer extends StatelessWidget {
  const CoachPriceContainer({
    Key? key,
    required this.label,
    required this.ratePerHr,
  }) : super(key: key);

  final String label;
  final int ratePerHr;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 100,
      width: 100,
      margin: const EdgeInsets.only(right: 7),
      backgroundColor: AppColors.filled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400, fontSize: 18),
          ),
          Text(
            '\$ $ratePerHr/hr',
            style: Theme.of(context).textTheme.titleSmall!,
          )
        ],
      ),
    );
  }
}

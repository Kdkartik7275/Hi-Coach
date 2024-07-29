import 'package:flutter/material.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class AverageUsersRating extends StatelessWidget {
  const AverageUsersRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('4.0', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5,
              (index) => const Icon(Icons.star, color: Colors.amber, size: 15)),
        ),
        const SizedBox(height: 8),
        Text('52 Reviews',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.text, fontWeight: FontWeight.w400))
      ],
    );
  }
}

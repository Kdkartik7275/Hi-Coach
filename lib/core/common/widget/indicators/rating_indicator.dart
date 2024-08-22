import 'package:flutter/material.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';

class LinearRatingIndicator extends StatelessWidget {
  const LinearRatingIndicator({
    super.key,
    required this.rating,
    required this.width,
  });
  final int rating;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$rating'),
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 15,
        ),
        TRoundedContainer(
          width: width,
          height: 6,
          backgroundColor: Colors.green.shade900,
        ),
      ],
    );
  }
}

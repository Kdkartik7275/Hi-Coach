import 'package:flutter/material.dart';
import 'package:hi_coach/core/common/widget/buttons/profile_button.dart';
import 'package:hi_coach/core/common/widget/indicators/rating_indicator.dart';
import 'package:hi_coach/core/common/widget/ratings/average_user_rating.dart';
import 'package:hi_coach/src/profile/views/coach/coach_profile_view.dart';

class CoachReviewWidget extends StatelessWidget {
  const CoachReviewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearRatingIndicator(rating: 5, width: 200),
                LinearRatingIndicator(rating: 4, width: 150),
                LinearRatingIndicator(rating: 3, width: 100),
                LinearRatingIndicator(rating: 2, width: 70),
                LinearRatingIndicator(rating: 1, width: 20),
              ],
            ),
            AverageUsersRating(),
          ],
        ),
        const SizedBox(height: 20),
        ProfileButton(
            label: 'Wrtie Review',
            size: const Size(280, 45),
            backgroundColor: Colors.green.shade500,
            onPressed: () {}),

        const SizedBox(height: 20),

        // COMMENTS

        const UserReview(),
        const UserReview(),
        const SizedBox(height: 50),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/containers/circular_container.dart';
import 'package:hi_coach/core/common/widget/effects/shimmer.dart';
import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/models/pricing.dart';
import 'package:hi_coach/models/user.dart';
import 'package:hi_coach/services/profile/profile_services.dart';
import 'package:hi_coach/src/profile/views/student/cp_student_view.dart';

class SearchedCoachTile extends StatelessWidget {
  const SearchedCoachTile({
    super.key,
    required this.coach,
  });

  final UserModel coach;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Future.delayed(Duration.zero, () {
          Get.to(() => CoachProfileStudentView(coachID: coach.id));
        });
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 30, 10),
            child: Row(
              crossAxisAlignment: coach.bio != ""
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    TCircularContainer(
                      height: 80,
                      width: 80,
                      backgroundColor: AppColors.filled,
                      child: TCachedNetworkImage(
                        profileURL: coach.profileURL!.first,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    const SizedBox(height: 10),
                    PriceText(coach: coach),
                  ],
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            coach.fullName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemSize: 15,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 1),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        coach.bio,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.textLighter),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class PriceText extends StatelessWidget {
  const PriceText({
    super.key,
    required this.coach,
  });

  final UserModel coach;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pricing>>(
        future: ProfileServices().getCoachPricings(coach.id),
        builder: (context, AsyncSnapshot<List<Pricing>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const TShimmerEffect(height: 20, width: 80);
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            if (snapshot.data == []) {
              return const SizedBox();
            } else {
              final price = snapshot.data!.first;
              return Text(
                '\$ ${price.price}/hr',
                style: Theme.of(context).textTheme.titleMedium,
              );
            }
          }
          if (!snapshot.hasData) return const SizedBox();

          return const SizedBox();
        });
  }
}

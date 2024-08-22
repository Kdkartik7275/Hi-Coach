// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_coach/core/common/widget/containers/price_container.dart';
import 'package:hi_coach/core/common/widget/effects/shimmer.dart';
import 'package:hi_coach/core/common/widget/heading/heading.dart';
import 'package:hi_coach/models/package.dart';
import 'package:hi_coach/models/pricing.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/profile/widgets/coach/coach_package_info.dart';

class CoachPricingWidget extends StatelessWidget {
  const CoachPricingWidget({
    super.key,
    required this.controller,
    required this.coachID,
  });
  final ProfileController controller;
  final String coachID;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- PRICINGS --------------
        TitleSubtitle(padding: EdgeInsets.zero, title: 'Single Classes'),

        // FETCH ALL THE PRICINGS
        FutureBuilder<List<Pricing>?>(
          future: controller.getCoachPricings(coachID),
          builder: (context, AsyncSnapshot<List<Pricing>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return TShimmerEffect(
                  height: 100.h, width: double.infinity, radius: 15.r);
            }
            if (snapshot.hasData) {
              final prices = snapshot.data!;
              if (snapshot.data == []) {
                return const SizedBox();
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      prices.length,
                      (index) => CoachPriceContainer(
                          label: prices[index].title,
                          ratePerHr: prices[index].price)),
                );
              }
            }
            return const SizedBox();
          },
        ),
        // ----------- PACKAGES ----------------
        SizedBox(height: 20.h),
        TitleSubtitle(padding: EdgeInsets.zero, title: 'Packages'),

        // FETCH ALL THE PACKAGES

        FutureBuilder<List<Package>?>(
          future: controller.getCoachPackages(coachID),
          builder: (context, AsyncSnapshot<List<Package>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return TShimmerEffect(
                  height: 80.h, width: double.infinity, radius: 20.r);
            }
            if (snapshot.hasData) {
              if (snapshot.data == []) {
                return const SizedBox();
              } else {
                final packages = snapshot.data!;

                return Column(
                  children: List.generate(packages.length, (index) {
                    int discountedPrice = packages[index].actualPrice.toInt() -
                        (packages[index].actualPrice.toInt() *
                                (packages[index].discount / 100))
                            .toInt();

                    return CoachPackageInfo(
                        label: packages[index].packageFor,
                        hours: packages[index].hours,
                        actualPrice: packages[index].actualPrice,
                        discountedPrice: discountedPrice);
                  }),
                );
              }
            }
            return const SizedBox();
          },
        ),

        SizedBox(height: 50.h)
      ],
    );
  }
}

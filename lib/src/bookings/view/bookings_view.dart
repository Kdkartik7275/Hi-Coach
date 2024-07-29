import 'package:flutter/material.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BOOKING TEXT
              const SizedBox(height: 15),
              Text('Your Bookings',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 22)),
              const SizedBox(height: 35),

              // ---------------- BOOKINGS TAB BAR -------------------
              const TabBar(
                dividerColor: AppColors.white,
                indicatorColor: AppColors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w700),
                unselectedLabelStyle: TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w700),
                labelPadding: EdgeInsets.only(bottom: 10),
                tabs: [
                  Text('Past'),
                  Text('Upcoming'),
                ],
              ),

              // ---------- TAB BAR BODY ------------------
              Expanded(
                child: TabBarView(children: [
                  // PAST BOOKINGS

                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // BOOKING DETAILS
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SPORT
                                Text('Tennis',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),

                                // COACH NAME & DISTANCE BETWEEN USER AND COACH

                                Row(
                                  children: [
                                    Text('Joshua Tan',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    const SizedBox(width: 4),
                                    const Text('•', // Middle dot character
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 4),
                                    Text('5.0km',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                  ],
                                ),

                                // TIMING OF CLASS

                                Text('2pm - 4pm',
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                Text('2hr',
                                    style:
                                        Theme.of(context).textTheme.titleLarge),

                                // DATE AND PRICE
                                const SizedBox(height: 3),

                                Row(
                                  children: [
                                    Text('8 March 2024',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600)),
                                    const SizedBox(width: 4),
                                    Text('•', // Middle dot character
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600)),
                                    const SizedBox(width: 4),
                                    Text('\$${200}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ],
                            ),

                            // VIEW BOOKING BUTTON

                            const TRoundedContainer(
                              height: 55,
                              width: 55,
                              radius: 10,
                              backgroundColor: AppColors.filledTextField,
                              alignment: Alignment.center,
                              child: Text('View'),
                            )
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

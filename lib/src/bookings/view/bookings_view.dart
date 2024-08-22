import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BOOKING TEXT
              SizedBox(height: 15.h),
              Text('Your Bookings',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 22.sp)),
              SizedBox(height: 35.h),

              // ---------------- BOOKINGS TAB BAR -------------------
              TabBar(
                dividerColor: AppColors.white,
                indicatorColor: AppColors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 15.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w700),
                unselectedLabelStyle: TextStyle(
                    color: AppColors.text,
                    fontSize: 15.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w700),
                labelPadding: EdgeInsets.only(bottom: 10.h),
                tabs: const [
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
                        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
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
                                    SizedBox(width: 4.w),
                                    Text('•', // Middle dot character
                                        style: TextStyle(
                                            fontSize: 16.0.sp,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(width: 4.w),
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
                                SizedBox(height: 3.h),

                                Row(
                                  children: [
                                    Text('8 March 2024',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600)),
                                    SizedBox(width: 4.w),
                                    Text('•', // Middle dot character
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600)),
                                    SizedBox(width: 4.w),
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

                            TRoundedContainer(
                              height: 55.h,
                              width: 55.w,
                              radius: 10.r,
                              backgroundColor: AppColors.filledTextField,
                              alignment: Alignment.center,
                              child: const Text('View'),
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

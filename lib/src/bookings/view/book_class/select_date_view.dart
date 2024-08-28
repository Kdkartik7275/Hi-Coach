// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/buttons/profile_button.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/app_pages.dart';

import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/utils/helpers/functions.dart';
import 'package:hi_coach/models/coach.dart';
import 'package:hi_coach/src/bookings/controller/booking_controller.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateView extends GetView<BookingController> {
  const SelectDateView({super.key});

  @override
  Widget build(BuildContext context) {
    final coach = Get.arguments['coach'] as Coach;
    final rating = Get.arguments['rating'];

    controller.fetchCoachTimings(coach, controller.selectedDay.value);
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.loading.value,
          progressIndicator: circularProgress(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _Header(key, coach, rating),
                Divider(color: Colors.grey.shade300),
                TableCalendar(
                  firstDay: DateTime.utc(2024, 1, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  daysOfWeekHeight: 30.h,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: Theme.of(context).textTheme.titleMedium!,
                    weekendStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.red),
                    dowTextFormatter: (date, locale) {
                      return DateFormat.E(locale).format(date)[0];
                    },
                  ),
                  focusedDay: controller.focusedDay.value,
                  selectedDayPredicate: (day) {
                    return isSameDay(controller.selectedDay.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.selectedDay.value = selectedDay;
                    controller.focusedDay.value = focusedDay;
                    controller.fetchCoachTimings(coach, selectedDay);
                  },
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: HeaderStyle(
                    headerMargin: EdgeInsets.zero,
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: Theme.of(context).textTheme.titleMedium!,
                  ),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 18.sp),
                    isTodayHighlighted: true,
                    selectedDecoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: Theme.of(context).textTheme.titleLarge!,
                    weekendTextStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                            fontSize: 18.sp, color: const Color(0xffFF3B30)),
                    outsideDaysVisible: false,
                  ),
                ),

                // TIMINGS

                if (controller.times.value != null)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.times.value!.timings.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 27 / 8,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12),
                        itemBuilder: (context, index) {
                          final time = controller.times.value!.timings[index];
                          bool isSelected = controller.selectedTime.value !=
                                  {} &&
                              (time['start'] ==
                                      controller.selectedTime.value['start'] &&
                                  time['end'] ==
                                      controller.selectedTime.value['end']);
                          return GestureDetector(
                            onTap: () => controller.selectTime(time),
                            child: TRoundedContainer(
                              width: 150.w,
                              height: 60.h,
                              showBorder: true,
                              borderColor: isSelected
                                  ? AppColors.primary
                                  : AppColors.border,
                              radius: 10.r,
                              child: Column(
                                children: [
                                  Text(formatTime(time['start']),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : AppColors.textLighter)),
                                  Text('@ Any',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontSize: 12.sp,
                                              color: AppColors.textLighter))
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                if (controller.times.value != null)
                  CustomButton(
                      label: 'Book Now',
                      onPressed: () => Get.toNamed(Routes.BOOKINGCONFIRMATION,
                              arguments: {
                                'coach': coach,
                                'timing': controller.selectedTime.value
                              })),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(
    Key? key,
    this.coach,
    this.rating,
  ) : super(key: key);

  final Coach coach;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(coach.fullName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w600)),
        Text(coach.sports[0],
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.textLighter)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber),
            Text(rating.toString(),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        )
      ],
    );
  }
}

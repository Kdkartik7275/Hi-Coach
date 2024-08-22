import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/models/coach.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/schedule/controllers/timings_controller.dart';
import 'package:hi_coach/src/schedule/widgets/timings.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';

class ScheduleSetter extends StatefulWidget {
  const ScheduleSetter({super.key});

  @override
  State<ScheduleSetter> createState() => _ScheduleSetterState();
}

class _ScheduleSetterState extends State<ScheduleSetter> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TimingsController>();
    final coach = Get.find<ProfileController>().user as Coach;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => controller.saveTimings(coach.id),
              child: const Text('Done'))
        ],
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.loading.value,
          progressIndicator: circularProgress(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Calender
                TRoundedContainer(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 10.0,
                    ),
                  ],
                  child: Column(
                    children: [
                      _Calender(controller: controller),
                      SizedBox(
                          width: 60.w,
                          child: const Divider(
                            thickness: 3,
                            color: AppColors.black,
                          )),
                    ],
                  ),
                ),

                // Timings Setter
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    children: [
                      // HEAD
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Set Schedule',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              ScheduleSwitch(
                                onChanged: (value) =>
                                    controller.setHoliday(value),
                                value: controller.isHoliday.value,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Holiday',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          )
                        ],
                      ),

                      // TIMINGS

                      ...List.generate(
                          controller.selectedDates.value.length,
                          (index) => GestureDetector(
                              onTap: () {
                                controller.currentIndex.value = index;
                              },
                              child: Timing(
                                isExpanded:
                                    controller.currentIndex.value == index,
                                index: index,
                                time: controller.selectedDates.value[index],
                              ))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Calender extends StatelessWidget {
  const _Calender({
    required this.controller,
  });

  final TimingsController controller;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: controller.calendarFormat.value,
      formatAnimationCurve: Curves.linear,
      // formatAnimationDuration: const Duration(milliseconds: 800),
      onFormatChanged: (format) {
        controller.calendarFormat.value = format;
      },
      selectedDayPredicate: (day) =>
          controller.selectedDates.value.contains(day),
      onDaySelected: (day, focuseday) =>
          controller.onDaySelected(day, focuseday),
      calendarStyle: CalendarStyle(
          defaultTextStyle: Theme.of(context).textTheme.titleSmall!,
          weekendTextStyle: Theme.of(context).textTheme.titleSmall!,
          outsideTextStyle: Theme.of(context).textTheme.titleSmall!),
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: Theme.of(context).textTheme.titleMedium!),
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2025, 12, 31),
      focusedDay: DateTime.now(),
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) {
            return DateFormat.E(locale).format(date)[0];
          },
          weekdayStyle: Theme.of(context).textTheme.titleSmall!,
          weekendStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.red)),
    );
  }
}

class ScheduleTimings extends StatelessWidget {
  const ScheduleTimings({
    super.key,
    required this.startingtime,
    required this.endingtime,
    this.onSelectStartingtime,
    this.onSelectEndingtime,
  });

  final String startingtime;
  final String endingtime;
  final Function()? onSelectStartingtime;
  final Function()? onSelectEndingtime;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SelectTimeWidget(
              onPressed: onSelectStartingtime, time: startingtime),
          Text('to', style: Theme.of(context).textTheme.titleMedium),
          _SelectTimeWidget(onPressed: onSelectEndingtime, time: endingtime),
        ],
      ),
    );
  }
}

class _SelectTimeWidget extends StatelessWidget {
  const _SelectTimeWidget({
    required this.time,
    required this.onPressed,
  });

  final String time;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 40.h,
      borderColor: AppColors.border,
      showBorder: true,
      padding: EdgeInsets.only(left: 8.w),
      radius: 10.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 16.sp)),
          IconButton(
              onPressed: onPressed, icon: const Icon(Icons.arrow_drop_down))
        ],
      ),
    );
  }
}

class ScheduleSwitch extends StatelessWidget {
  const ScheduleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.white,
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.border,
        inactiveThumbColor: AppColors.white,
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
    );
  }
}

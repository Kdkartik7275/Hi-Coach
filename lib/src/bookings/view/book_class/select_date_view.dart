// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/models/coach.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateView extends StatefulWidget {
  const SelectDateView({super.key});

  @override
  State<SelectDateView> createState() => _SelectDateViewState();
}

class _SelectDateViewState extends State<SelectDateView> {
  final DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final coach = Get.arguments['coach'] as Coach;
    final rating = Get.arguments['rating'];
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            _Header(widget.key, coach, rating),
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
                  dowTextFormatter: (date, locale) =>
                      date.weekday == DateTime.sunday
                          ? 'S'
                          : date.weekday == DateTime.saturday
                              ? 'S'
                              : date.weekday == DateTime.friday
                                  ? 'F'
                                  : date.weekday == DateTime.thursday
                                      ? 'T'
                                      : date.weekday == DateTime.wednesday
                                          ? 'W'
                                          : date.weekday == DateTime.tuesday
                                              ? 'T'
                                              : 'M'),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                // setState(() {
                //   _selectedDay = selectedDay;
                //   _focusedDay = focusedDay;
                // });
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
                    .copyWith(fontSize: 18),
                isTodayHighlighted: true,
                selectedDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 18, color: const Color(0xffFF3B30)),
                outsideDaysVisible: false,
              ),
            ),
          ],
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

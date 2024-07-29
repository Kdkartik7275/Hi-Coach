// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/conifg/strings.dart';
import 'package:hi_coach/models/schedule.dart';

class ListingClasses extends StatelessWidget {
  const ListingClasses({
    super.key,
    required this.isPastClass,
    required this.schedule,
  });

  final bool isPastClass;
  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                const Icon(Icons.arrow_back, color: AppColors.primary),
                const SizedBox(width: 5),
                Text(DateFormat('d MMM').format(schedule.startTime!.toDate()),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColors.primary))
              ],
            ),
          ),
        ),
        title: const Text(AppStrings.appName),
        leadingWidth: 100,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text('Edit',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.primary)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // SCHEDULE INFORMATION

            InfoTab(title: 'Title', value: schedule.title!),
            InfoTab(title: 'Location', value: schedule.location!),
            InfoTab(
                title: 'Date',
                value: DateFormat('d MMM yyyy')
                    .format(schedule.startTime!.toDate())),
            InfoTab(
                title: 'Pax',
                value: '${schedule.confirmedStudents!.length}/${schedule.pax}'),

            // CANCEL / REFUND BUTTON
          ],
        ),
      ),
    );
  }
}

class InfoTab extends StatelessWidget {
  const InfoTab({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w700)),
        Text(
          ': $value',
          style: Theme.of(context).textTheme.titleMedium!,
        ),
      ],
    );
  }
}

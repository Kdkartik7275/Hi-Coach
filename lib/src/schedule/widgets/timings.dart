// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/utils/helpers/functions.dart';
import 'package:hi_coach/src/schedule/controllers/timings_controller.dart';
import 'package:hi_coach/src/schedule/views/schedule_setter.dart';

class Timing extends GetView<TimingsController> {
  const Timing({
    super.key,
    required this.isExpanded,
    required this.time,
    required this.index,
  });
  final bool isExpanded;
  final DateTime time;
  final int index;

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('EEEE').format(time);
    var timings = controller.schedule.value[index]['timings'];

    String allTimings = timings.map((timing) {
      String start = formatTimeOfDay(timing['start']);
      String end = formatTimeOfDay(timing['end']);
      return '$start - $end';
    }).join(', ');

    return TRoundedContainer(
      margin: const EdgeInsets.only(bottom: 10),
      radius: 12.r,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      borderColor: isExpanded ? AppColors.primary : AppColors.border,
      showBorder: true,
      child: Column(
        children: [
          Row(
            children: [
              ScheduleSwitch(
                  value: controller.schedule.value[index]['value'],
                  onChanged: (value) {
                    controller.updateActiveValue(index, value);
                  }),
              SizedBox(width: 10.w),
              Text(formattedTime,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
              SizedBox(width: 10.w),
              if (!isExpanded)
                Expanded(
                  child: Text(allTimings,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14.sp, color: AppColors.textLighter)),
                ),
            ],
          ),
          if (isExpanded)
            ...List.generate(timings.length, (i) {
              String startingtime = formatTimeOfDay(timings[i]['start']);
              String endigtime = formatTimeOfDay(timings[i]['end']);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ScheduleTimings(
                      startingtime: startingtime,
                      endingtime: endigtime,
                      onSelectStartingtime: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialEntryMode: TimePickerEntryMode.input,
                            initialTime: TimeOfDay.now());
                        if (selectedTime != null) {
                          controller.updateTiming(controller.currentIndex.value,
                              i, 'start', selectedTime);
                        }
                      },
                      onSelectEndingtime: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialEntryMode: TimePickerEntryMode.input,
                            initialTime: TimeOfDay.now());
                        if (selectedTime != null) {
                          controller.updateTiming(controller.currentIndex.value,
                              i, 'end', selectedTime);
                        }
                      },
                    ),
                    Row(
                      children: [
                        i != 0
                            ? const InkWell(
                                //  onTap: () => controller.addNewTiming,
                                child: Icon(Icons.delete_outline,
                                    color: Colors.red))
                            : const SizedBox(),
                        InkWell(
                            onTap: () => controller.addNewTiming(index),
                            child: const Icon(Icons.add_circle_outline)),
                      ],
                    )
                  ],
                ),
              );
            })
        ],
      ),
    );
  }
}

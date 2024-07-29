import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/schedule/controllers/schedule_controller.dart';
import 'package:hi_coach/src/schedule/views/add_schedule_view.dart';
import 'package:hi_coach/src/schedule/views/listing_class.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleController());
    final user = Get.find<ProfileController>().user!;
    controller.fetchSchedules(user.id);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, color: AppColors.primary)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: AppColors.primary)),
          IconButton(
              onPressed: () {
                Get.to(() => const AddScheduleView());
              },
              icon: const Icon(Icons.add, color: AppColors.primary)),
        ],
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.loading.value,
          progressIndicator: circularProgress(context),
          child: SfCalendar(
            view: CalendarView.week,
            headerStyle:
                const CalendarHeaderStyle(backgroundColor: AppColors.white),
            showDatePickerButton: true,
            todayHighlightColor: AppColors.primary,
            timeSlotViewSettings: const TimeSlotViewSettings(
              startHour: 7,
              endHour: 23,
              timeIntervalHeight: 40,
              timeTextStyle: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            onTap: (details) {
              if (details.appointments != null) {
                final schedule = controller.schedules.value.where((sch) =>
                    sch.startTime!.toDate() ==
                        details.appointments!.first.from &&
                    sch.endTime!.toDate() == details.appointments!.first.to);
                if (schedule.first.requests!.isNotEmpty) {
                  // SHOW REQUESTS DIALOG
                  // print(true);
                } else {
                  bool isPastClass = schedule.first.startTime!
                      .toDate()
                      .isBefore(DateTime.now());

                  Get.to(() => ListingClasses(
                      isPastClass: isPastClass, schedule: schedule.first));
                }
              }
            },
            dataSource: MeetingDataSource(controller.meetings.value),
            cellEndPadding: 0,
            appointmentBuilder: (context, details) {
              return TRoundedContainer(
                backgroundColor: details.appointments.first.color,
                radius: 5,
                child: Center(
                  child: Text(
                    details.appointments.first.eventName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.color);

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color color;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }
}

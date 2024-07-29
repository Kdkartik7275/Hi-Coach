import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/schedule/controllers/schedule_controller.dart';
import 'package:hi_coach/src/schedule/views/add_schedule_view.dart';
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
              timeIntervalHeight: 50,
              timeTextStyle: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            dataSource: MeetingDataSource(controller.getMeetingDataSource()),
            appointmentBuilder: (context, details) {
              return Container(
                decoration: BoxDecoration(
                  color: details.appointments.first.color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(details.appointments.first.eventName),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting('Meeting', startTime, endTime, Colors.red));
  meetings.add(Meeting('Workout', startTime.add(const Duration(days: 1)),
      endTime.add(const Duration(days: 1)), Colors.blue));
  return meetings;
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_coach/src/schedule/controllers/timings_controller.dart';
import 'package:hi_coach/src/schedule/views/schedule_setter.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/schedule/controllers/schedule_controller.dart';
import 'package:hi_coach/src/schedule/views/add_schedule_view.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleController());
    Get.put(TimingsController());
    final user = Get.find<ProfileController>().user!;
    controller.fetchSchedules(user.id);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const ScheduleSetter()),
              icon: const Icon(Icons.timer_outlined, color: AppColors.primary)),
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

            timeSlotViewSettings: TimeSlotViewSettings(
              startHour: 7,
              endHour: 23,
              timeIntervalHeight: 40,
              timeTextStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
              ),
            ),
            onTap: (details) {},
            //  dataSource: MeetingDataSource(controller.meetings.value),
            cellEndPadding: 0,
            // appointmentBuilder: (context, details) {
            //   return TRoundedContainer(
            //     backgroundColor: details.appointments.first.color,
            //     radius: 5.r,
            //     child: Center(
            //       child: Text(
            //         details.appointments.first.eventName,
            //         textAlign: TextAlign.center,
            //         style: const TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   );
            // },
          ),
        ),
      ),
    );
  }
}

// class RequestsDialogWidget extends StatelessWidget {
//   const RequestsDialogWidget({
//     super.key,
//     required this.schedule,
//   });

//   final Schedule schedule;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: const EdgeInsets.symmetric(horizontal: 12),
//       child: TRoundedContainer(
//         height: 400.h,
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         backgroundColor: AppColors.border,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Requests',
//                     style: Theme.of(context).textTheme.titleMedium),
//                 IconButton(
//                   padding: EdgeInsets.zero,
//                   onPressed: () {},
//                   icon:
//                       const Icon(Icons.close, color: AppColors.black, size: 30),
//                 ),
//               ],
//             ),

//             // STUDENTS LISTS

//             ...List.generate(
//               schedule.requests.length,
//               (index) {
//                 final studentID = schedule.requests[index];
//                 final session = schedule;
//                 return RequestStudentTile(
//                     session: session, studentID: studentID);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RequestStudentTile extends StatelessWidget {
//   const RequestStudentTile({
//     super.key,
//     required this.studentID,
//     required this.session,
//   });
//   final String studentID;
//   final Schedule session;

//   @override
//   Widget build(BuildContext context) {
//     return TRoundedContainer(
//       height: 120.h,
//       width: double.infinity,
//       radius: 10.r,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: FutureBuilder<Student?>(
//           future: Get.find<ProfileController>().fetchStudentByID(studentID),
//           builder: (context, AsyncSnapshot<Student?> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return TShimmerEffect(
//                 height: 100.h,
//                 width: double.infinity,
//                 radius: 10.r,
//               );
//             }
//             if (snapshot.hasData) {
//               final student = snapshot.data!;
//               return Row(
//                 children: [
//                   // PROFILE

//                   Column(
//                     children: [
//                       TCachedNetworkImage(
//                           profileURL: student.profileURL![0],
//                           height: 60.h,
//                           width: 60.w),
//                       Text(student.fullName,
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleSmall!
//                               .copyWith(fontSize: 14.sp)),
//                     ],
//                   ),

//                   // CLASS DETAILS
//                   SizedBox(width: 10.w),

//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(session.sport,
//                           style: Theme.of(context).textTheme.titleMedium),
//                       Text(session.location,
//                           style: Theme.of(context).textTheme.titleSmall),
//                       Text(
//                           '${DateFormat.jm().format(session.startTime.toDate())} - ${DateFormat.jm().format(session.endTime.toDate())}',
//                           style: Theme.of(context).textTheme.titleSmall),
//                       Text('2 pax',
//                           style: Theme.of(context).textTheme.titleSmall)
//                     ],
//                   ),

//                   // ACCEPT / REJECT BUTTON

//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: TCircularContainer(
//                       height: 35.h,
//                       width: 35.w,
//                       margin: const EdgeInsets.only(right: 10),
//                       backgroundColor: Colors.green.shade400,
//                       child: IconButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () {},
//                           icon: const Icon(Icons.done,
//                               color: AppColors.white, size: 20)),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: TCircularContainer(
//                       height: 35.h,
//                       width: 35.w,
//                       backgroundColor: Colors.red.shade400,
//                       child: IconButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () {},
//                           icon: const Icon(Icons.close,
//                               color: AppColors.white, size: 20)),
//                     ),
//                   )
//                 ],
//               );
//             }
//             return const SizedBox();
//           }),
//     );
//   }
// }

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

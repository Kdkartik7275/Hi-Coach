// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
// import 'package:hi_coach/models/student.dart';
// import 'package:hi_coach/src/profile/controller/profile_controller.dart';
// import 'package:hi_coach/src/schedule/widgets/student_tile.dart';
// import 'package:intl/intl.dart';
// import 'dart:ui' as ui;

// import 'package:hi_coach/core/conifg/colors.dart';
// import 'package:hi_coach/core/conifg/strings.dart';
// import 'package:hi_coach/models/schedule.dart';

// class ListingClasses extends StatelessWidget {
//   const ListingClasses({
//     super.key,
//     required this.isPastClass,
//     required this.schedule,
//   });

//   final bool isPastClass;
//   final Schedule schedule;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 8),
//           child: GestureDetector(
//             onTap: () => Get.back(),
//             child: Row(
//               children: [
//                 const Icon(Icons.arrow_back, color: AppColors.primary),
//                 const SizedBox(width: 5),
//                 Text(DateFormat('d MMM').format(schedule.startTime.toDate()),
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleMedium!
//                         .copyWith(color: AppColors.primary))
//               ],
//             ),
//           ),
//         ),
//         title: const Text(AppStrings.appName),
//         leadingWidth: 100,
//         actions: [
//           TextButton(
//               onPressed: () {},
//               child: Text('Edit',
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleMedium!
//                       .copyWith(color: AppColors.primary)))
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             // SCHEDULE INFORMATION

//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InfoTab(title: 'Title', value: schedule.title),
//                 InfoTab(title: 'Location', value: schedule.location),
//                 InfoTab(
//                     title: 'Date',
//                     value: DateFormat('d MMM yyyy')
//                         .format(schedule.startTime.toDate())),
//                 InfoTab(
//                     title: 'Pax',
//                     value:
//                         '${schedule.confirmedStudents.length}/${schedule.pax}'),
//                 SizedBox(height: 15.h),
//                 Text('Participants:',
//                     style: Theme.of(context).textTheme.titleMedium),
//                 SizedBox(height: 15.h),
//                 // SingleChildScrollView(
//                 //     scrollDirection: Axis.horizontal,
//                 //     child: Row(
//                 //         children: _buildParticipantTiles(context, schedule))),
//               ],
//             ),
//             // CANCEL / REFUND BUTTON
//             SizedBox(
//               width: double.infinity,
//               height: 60.h,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: Text(isPastClass ? 'Refund Class' : 'Cancel Booking',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleMedium!
//                         .copyWith(color: AppColors.white, letterSpacing: 1.5)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// // List<Widget> _buildParticipantTiles(BuildContext context, Schedule schedule) {
// //   final allStudents = List.from(schedule.confirmedStudents)
// //     ..addAll(schedule.invited);

// //   final limitedStudents = allStudents.take(schedule.pax).toList();

// //   return List.generate(limitedStudents.length, (index) {
// //     final id = limitedStudents[index];
// //     return FutureBuilder<Student?>(
// //         future: Get.find<ProfileController>().fetchStudentByID(id),
// //         builder: (context, AsyncSnapshot<Student?> snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return circularProgress(context);
// //           }
// //           if (snapshot.hasData) {
// //             final student = snapshot.data!;
// //             return InvitedStudentTile(student: student, isNameRequired: true);
// //           }
// //           return const SizedBox();
// //         });
// //   });
// // }

// class InfoTab extends StatelessWidget {
//   const InfoTab({
//     super.key,
//     required this.title,
//     required this.value,
//   });

//   final String title;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Text(
//               title,
//               textDirection: ui.TextDirection.ltr,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleMedium!
//                   .copyWith(fontWeight: FontWeight.w700),
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             flex: 2,
//             child: Text(
//               ': $value',
//               textDirection: ui.TextDirection.ltr,
//               style: Theme.of(context).textTheme.titleMedium!,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

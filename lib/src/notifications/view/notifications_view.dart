// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_coach/core/common/widget/containers/circular_container.dart';
import 'package:hi_coach/models/coach.dart';
import 'package:hi_coach/models/invitation.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/notifications/contnroller/notification_controller.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class NotificationsView extends GetView<NotificationController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: LoadingOverlay(
        isLoading: controller.loading.value,
        progressIndicator: circularProgress(context),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            // REQUESTS

            if (controller.classInvitations.value != [])
              ...List.generate(controller.classInvitations.value.length,
                  (index) {
                final invitation = controller.classInvitations.value[index];
                return ClassInvitationWidget(invitation: invitation);
              }),

            const Divider(),

            // NOTIFICATIONS
          ],
        ),
      ),
    );
  }
}

class ClassInvitationWidget extends GetView<NotificationController> {
  const ClassInvitationWidget({
    super.key,
    required this.invitation,
  });

  final Invitation invitation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: FutureBuilder<Coach?>(
        future:
            Get.find<ProfileController>().fetchCoachByID(invitation.coachID),
        builder: (context, AsyncSnapshot<Coach?> snapshot) {
          if (snapshot.hasData) {
            final coach = snapshot.data!;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coach Profile Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: TCachedNetworkImage(
                    profileURL: coach.profileURL![0],
                    height: 70.h,
                    width: 70.w,
                  ),
                ),
                SizedBox(width: 10.w),
                // Class Info AND Accept/Reject Button
                // Expanded(
                //   child: FutureBuilder<Schedule?>(
                //     future: controller.scheduleById(invitation.classID),
                //     builder: (context, AsyncSnapshot<Schedule?> snapshot) {
                //       if (snapshot.hasData) {
                //         final schedule = snapshot.data!;
                //         return Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             // INFO
                //             Text(
                //               '${coach.fullName} has invited you for a session',
                //               style: GoogleFonts.roboto(
                //                 fontSize: 14.sp,
                //                 fontWeight: FontWeight.w700,
                //               ),
                //             ),
                //             SizedBox(height: 6.h),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Expanded(
                //                   child: _Info(schedule: schedule),
                //                 ),
                //                 const ConfirmButtons(),
                //               ],
                //             ),
                //           ],
                //         );
                //       }
                //       return const SizedBox();
                //     },
                //   ),
                // ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class ConfirmButtons extends StatelessWidget {
  const ConfirmButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TCircularContainer(
          height: 40.h,
          width: 40.w,
          backgroundColor: AppColors.green,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check, color: AppColors.white)),
        ),
        SizedBox(height: 10.h),
        TCircularContainer(
          height: 40.h,
          width: 40.w,
          backgroundColor: Colors.red,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close, color: AppColors.white)),
        )
      ],
    );
  }
}

// class _Info extends StatelessWidget {
//   const _Info({
//     required this.schedule,
//   });

//   final Schedule schedule;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InvitationKeyValue(label: 'Sport: ', value: schedule.sport),
//         SizedBox(height: 3.h),
//         InvitationKeyValue(label: 'Pax: ', value: schedule.pax.toString()),
//         SizedBox(height: 3.h),
//         InvitationKeyValue(
//             label: 'Date: ',
//             value:
//                 DateFormat('d MMM yyyy').format(schedule.startTime.toDate())),
//         SizedBox(height: 3.h),
//         InvitationKeyValue(
//           label: 'Time: ',
//           value:
//               '${DateFormat.jm().format(schedule.startTime.toDate())} - ${DateFormat.jm().format(schedule.endTime.toDate())}',
//         ),
//       ],
//     );
//   }
// }

class InvitationKeyValue extends StatelessWidget {
  const InvitationKeyValue({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            textDirection: ui.TextDirection.ltr,
            style: GoogleFonts.roboto(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black)),
        //  const SizedBox(width: 10),
        Text(value,
            textDirection: ui.TextDirection.ltr,
            style: GoogleFonts.roboto(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.text)),
      ],
    );
  }
}

import 'dart:developer';

import 'package:get/get.dart';
import 'package:hi_coach/models/invitation.dart';
import 'package:hi_coach/services/notifications/notification_services.dart';
import 'package:hi_coach/services/schedule/schedule_services.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class NotificationController extends GetxController {
  // Variables

  var classInvitations = Rx<List<Invitation>>([]);
  var loading = false.obs;

  // Services

  final _services = NotificationServices();
  final _scheduleServices = ScheduleServices();

  // Current User

  final _user = Get.find<ProfileController>().user;

  @override
  void onInit() {
    super.onInit();
    getInvitations(_user!.id);
  }

  Future<void> getInvitations(String studentID) async {
    try {
      loading.value = true;
      final invitations = await _services.getClassInvitations(studentID);

      if (invitations != []) {
        classInvitations.value = invitations;
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      log(e.toString());
    }
  }

  // Future<Schedule?> scheduleById(String classID) async {
  //   try {
  //     final schedule = await _scheduleServices.classById(classID);
  //     return schedule;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return null;
  // }
}

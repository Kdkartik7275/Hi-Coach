import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/models/schedule.dart';
import 'package:hi_coach/models/user.dart';
import 'package:hi_coach/services/schedule/schedule_services.dart';
import 'package:hi_coach/src/schedule/views/calender_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ScheduleController extends GetxController {
  List repeat = ['Every Day', 'Every Week', 'One Time'];

  // CONTROLLERS

  final title = TextEditingController();
  final location = TextEditingController();
  final desciption = TextEditingController();

  // VARIABLES
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  var startTime = TimeOfDay.now().obs;
  var endTime = TimeOfDay.now().obs;

  var loading = false.obs;
  var selectedSport = ''.obs;
  var repeatValue = 'Every Day'.obs;
  var pax = '1'.obs;
  var minAge = '3'.obs;
  var maxAge = '3'.obs;

  var selectedStudents = Rx<List<UserModel>>([]);
  var invitedStudents = Rx<List<UserModel>>([]);
  var searchedStudents = Rx<List<UserModel>>([]);

  var schedules = Rx<List<Schedule>>([]);

  // SERVICES

  final services = ScheduleServices();

  // SET DATE AND TIME FUNCTION

  void setStartDate(DateTime date) {
    startDate.value = date;
  }

  void setEndDate(DateTime date) {
    endDate.value = date;
  }

  void setStartTime(TimeOfDay time) {
    startTime.value = time;
  }

  void setEndTime(TimeOfDay time) {
    endTime.value = time;
  }

  // GETTER FOR FORMATTED DATE AND TIME

  String get formattedStartDate =>
      DateFormat('d MMMM yyyy').format(startDate.value);
  String get formattedEndDate =>
      DateFormat('d MMMM yyyy').format(endDate.value);
  String get formattedStartTime => formatTimeOfDay(startTime.value);
  String get formattedEndTime => formatTimeOfDay(endTime.value);

  // FETCH SCHEDULES

  void fetchSchedules(String coachID) async {
    try {
      loading.value = true;
      final list = await services.getAllSchedules(coachID);
      schedules.value = list;
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  // Get Meeting Data Source
  List<Meeting> getMeetingDataSource() {
    List<Meeting> meetings = [];
    loading.value = true;
    for (var schedule in schedules.value) {
      DateTime startTime = schedule.startTime!.toDate();
      DateTime endTime = schedule.endTime!.toDate();
      Color color =
          Colors.blue; // You can customize this based on your criteria
      meetings.add(Meeting(schedule.title!, startTime, endTime, color));
    }
    loading.value = false;
    return meetings;
  }

  // ADD SCHEDULE FUNCTION

  void addSchedule(String coachID) async {
    if (title.text.isNotEmpty && location.text.isNotEmpty) {
      try {
        loading.value = true;
        String scheduleID = const Uuid().v4();
        List<String> ids =
            invitedStudents.value.map((student) => student.id).toList();

        DateTime classStartTime =
            _getClassTime(startDate.value, startTime.value);
        DateTime classEndTime = _getClassTime(endDate.value, endTime.value);
        Schedule newSchedule = Schedule(
            id: scheduleID,
            title: title.text,
            location: location.text,
            sport: selectedSport.value,
            startTime: Timestamp.fromDate(classStartTime),
            endTime: Timestamp.fromDate(classEndTime),
            repeat: repeatValue.value,
            pax: int.parse(pax.value),
            minAge: int.parse(minAge.value),
            maxAge: int.parse(maxAge.value),
            students: ids,
            description: desciption.text);
        await services.addSchedule(newSchedule, coachID);
        if (invitedStudents.value != []) {
          // SEND JOINING REQUESTS TO STUDENTS
          await inviteStudents(ids, newSchedule, coachID);
        }

        loading.value = false;
        Get.snackbar('Successfull', 'Class uploaded ',
            backgroundColor: AppColors.green);
      } catch (e) {
        //
        loading.value = false;
      }
    } else {
      Get.snackbar('', '',
          backgroundColor: AppColors.filled,
          titleText: Text('Error',
              style: Theme.of(Get.context!).textTheme.titleMedium),
          messageText: Text('All Fields are Required',
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.red)));
    }
  }

  Future<void> inviteStudents(
      List<String> studentIDs, Schedule schedule, String coachID) async {
    try {
      loading.value = true;

      await services.requrestToStudents(studentIDs, schedule, coachID);
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  void selectStudent(UserModel student) {
    if (selectedStudents.value.contains(student)) {
      loading.value = true;
      selectedStudents.value.removeWhere((st) => st.id == student.id);
      searchedStudents.value = [];
    } else {
      loading.value = true;
      selectedStudents.value.add(student);
      searchedStudents.value = [];
    }

    loading.value = false;
  }

  void addStudentsToInvites(List<UserModel> students) {
    if (students != []) {
      loading.value = true;
      invitedStudents.value.addAll(students);
      selectedStudents.value = [];
    }
    loading.value = false;
    Get.back();
  }

  void removeStudentFromInvites(UserModel student) {
    if (invitedStudents.value.contains(student)) {
      loading.value = true;
      invitedStudents.value.removeWhere((st) => st.id == student.id);
    }
    loading.value = false;
    Get.back();
  }

  void searchStudents(String query) async {
    try {
      loading.value = true;
      if (query != '') {
        final students = await services.searchStudents(query);
        if (students != []) {
          searchedStudents.value = students;
        }
      } else {
        searchedStudents.value = [];
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  DateTime _getClassTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}

String formatTimeOfDay(TimeOfDay time) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  final format = DateFormat.jm(); // 'jm' will format to '1:38 AM' or '1:38 PM'
  return format.format(dt);
}

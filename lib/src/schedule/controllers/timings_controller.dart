import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/models/timings.dart';
import 'package:hi_coach/services/profile/profile_services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TimingsController extends GetxController {
  var loading = false.obs;
  var isHoliday = false.obs;
  var currentIndex = 0.obs;
  var schedule = Rx<List<Map<String, dynamic>>>([]);
  var selectedDates = Rx<List<DateTime>>([]);

  var calendarFormat = CalendarFormat.month.obs;

  final services = ProfileServices();

  void onDaySelected(DateTime day, DateTime focusedDay) {
    loading.value = true;
    var existingEntry = schedule.value.firstWhere(
      (entry) =>
          DateFormat('yyyy-MM-dd').format(entry['date']) ==
          DateFormat('yyyy-MM-dd').format(day),
      orElse: () => {},
    );
    if (selectedDates.value.contains(day)) {
      selectedDates.value.remove(day);
      schedule.value.remove(existingEntry);
    } else {
      selectedDates.value.add(day);
      schedule.value.add({
        'date': day,
        'value': true,
        'timings': [
          {'start': TimeOfDay.now(), 'end': TimeOfDay.now()}
        ],
      });
    }
    loading.value = false;
  }

  void addNewTiming(int index) {
    loading.value = true;
    schedule.value[index]['timings']
        .add({'start': TimeOfDay.now(), 'end': TimeOfDay.now()});
    loading.value = false;
  }

  void updateTiming(int index, int timingIndex, String key, TimeOfDay time) {
    loading.value = true;
    schedule.value[index]['timings'][timingIndex][key] = time;
    loading.value = false;
  }

  void updateActiveValue(int index, bool value) {
    loading.value = true;
    schedule.value[index]['value'] = value;
    loading.value = false;
  }

  void setHoliday(bool value) {
    loading.value = true;
    isHoliday.value = value;

    if (value) {
      for (var entry in schedule.value) {
        entry['value'] = false;
      }
      schedule.refresh();
    }

    loading.value = false;
  }

  // Method to save all timings in Firebase
  Future<void> saveTimings(String coachId) async {
    loading.value = true;

    try {
      List<Timings> timingsList = schedule.value.map((entry) {
        return Timings(
          address: "Coaching Area Address",
          date: Timestamp.fromDate(entry['date']),
          isHoliday: isHoliday.value,
          timings:
              List<Map<String, dynamic>>.from(entry['timings'].map((timing) {
            return {
              'start': _convertTimeOfDayToString(timing['start']),
              'end': _convertTimeOfDayToString(timing['end']),
            };
          })),
        );
      }).toList();

      await services.updateCoachData({
        'timings': timingsList.map((timing) => timing.toMap()).toList(),
      }, coachId);
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to save timings: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      loading.value = false;
    }
  }

  String _convertTimeOfDayToString(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dateTime);
  }
}

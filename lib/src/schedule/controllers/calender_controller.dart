import 'package:get/get.dart';

class CalenderController extends GetxController {
  // OBSERVABLE VARIABLES
  var selectedDate = Rx<DateTime>(DateTime.now());

  // Time slots for the day
  final List<String> timeSlots = List.generate(15, (index) {
    final hour = 8 + index;
    final period = hour < 12 ? 'am' : 'pm';
    final adjustedHour = hour <= 12 ? hour : hour - 12;
    return '$adjustedHour $period';
  });

  void onDateSelect(DateTime time) {
    selectedDate.value = time;
  }

  void selectWeek(int index) {
    selectedDate.value = DateTime.now().add(Duration(days: (index - 0) * 7));
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

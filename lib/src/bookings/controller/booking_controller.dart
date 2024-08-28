import 'package:get/get.dart';
import 'package:hi_coach/models/coach.dart';
import 'package:hi_coach/models/timings.dart';
import 'package:intl/intl.dart';

class BookingController extends GetxController {
  var times = Rx<Timings?>(null);

  var loading = false.obs;

  var focusedDay = Rx<DateTime>(DateTime.now());
  var selectedDay = Rx<DateTime>(DateTime.now());

  var selectedTime = Rx<Map<String, dynamic>>({});

  void fetchCoachTimings(Coach coach, DateTime selectedDate) async {
    loading.value = true;

    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    final timings = coach.timings!.firstWhereOrNull((time) =>
        DateFormat('yyyy-MM-dd').format(time.date.toDate()) == formattedDate &&
        time.isHoliday == false);

    times.value = timings;

    loading.value = false;
  }

  void selectTime(Map<String, dynamic> time) {
    loading.value = true;

    bool alreadyExist = time['start'] == selectedTime.value['start'] &&
        time['end'] == selectedTime.value['end'];
    if (alreadyExist) {
      selectedTime.value = {};
    } else {
      selectedTime.value = time;
    }

    loading.value = false;
  }
}

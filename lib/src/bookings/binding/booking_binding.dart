import 'package:get/get.dart';
import 'package:hi_coach/src/bookings/controller/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingController>(() => BookingController());
  }
}

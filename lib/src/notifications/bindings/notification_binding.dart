import 'package:get/get.dart';
import 'package:hi_coach/src/notifications/contnroller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}

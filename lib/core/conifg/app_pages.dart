import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hi_coach/src/bookings/binding/booking_binding.dart';
import 'package:hi_coach/src/bookings/view/book_class/confirmation_view.dart';
import 'package:hi_coach/src/bookings/view/book_class/select_date_view.dart';
import 'package:hi_coach/src/bookings/view/bookings_view.dart';
import 'package:hi_coach/src/notifications/bindings/notification_binding.dart';
import 'package:hi_coach/src/notifications/view/notifications_view.dart';
import 'package:hi_coach/src/splash/view/splash_view.dart';
import 'package:hi_coach/src/auth/binding/login_binding.dart';
import 'package:hi_coach/src/auth/binding/signup_binding.dart';
import 'package:hi_coach/src/auth/view/login/login_view.dart';
import 'package:hi_coach/src/auth/view/signup/sign_up_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: _Paths.SPLASH, page: () => const SplashView()),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.BOOKINGS,
      page: () => const BookingsView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.SELECTDATE,
      page: () => const SelectDateView(),
    ),
    GetPage(
      name: _Paths.BOOKINGCONFIRMATION,
      page: () => const ConfirmationView(),
    ),
  ];
}

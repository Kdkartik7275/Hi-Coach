import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/src/bookings/view/bookings_view.dart';
import 'package:hi_coach/src/category_view.dart';
import 'package:hi_coach/src/favourite/views/student/favorite_coaches_view.dart';
import 'package:hi_coach/src/home/coach/coach_home_view.dart';
import 'package:hi_coach/src/home/student/views/student_home_view.dart';
import 'package:hi_coach/src/profile/views/coach/coach_profile_view.dart';
import 'package:hi_coach/src/profile/views/student/student_profile_view.dart';
import 'package:hi_coach/src/schedule/views/calender_view.dart';

class BottomNavBarController extends GetxController {
  List studentPages = [
    const StudentHomeView(),
    CategoryView(isSearchScreen: true),
    const BookingsView(),
    const FavouriteCoachesView(),
    const StudentProfileView(),
  ];

  List coachPages = [
    const CoachHomeView(),
    const SizedBox(),
    ScheduleView(),
    const SizedBox(),
    const CoachProfileView()
  ];
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}

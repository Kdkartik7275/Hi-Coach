import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/conifg/app_images.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/favourite/controller/favourite_controller.dart';
import 'package:hi_coach/src/home/student/widgets/coach_drawer.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class CoachHomeView extends StatelessWidget {
  const CoachHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<ProfileController>().user!;
    Get.put(FavouriteController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: RichText(
          text: TextSpan(
            text: 'Hi',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                  text: ' ${user.fullName.split(' ').first}',
                  style: const TextStyle(color: AppColors.primary)),
              const TextSpan(
                text: ' ,',
              ),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Image.asset(AppIcons.messages)),
        ],
      ),
      drawer: const CoachDrawer(),
    );
  }
}

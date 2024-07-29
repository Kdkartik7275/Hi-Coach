import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/controllers/location_controller.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/common/widget/heading/heading.dart';
import 'package:hi_coach/core/conifg/app_images.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/favourite/controller/favourite_controller.dart';
import 'package:hi_coach/src/home/student/widgets/drawer.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class StudentHomeView extends GetView<ProfileController> {
  const StudentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = controller.user!;
    Get.put(FavouriteController());

    Get.put(LocationController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: RichText(
          text: TextSpan(
            text: 'Hi',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 24, fontWeight: FontWeight.w700),
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
          IconButton(
              onPressed: () {}, icon: Image.asset(AppIcons.notifications)),
          IconButton(onPressed: () {}, icon: Image.asset(AppIcons.messages)),
        ],
      ),
      drawer: const StudentDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleSubtitle(title: 'Slot Openings', padding: EdgeInsets.zero),
            TRoundedContainer(
              height: 75,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20),
              backgroundColor: AppColors.primary,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.hourglass_bottom,
                      size: 40,
                      color: AppColors.white,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Flexible(
                      child: Text(
                        'Get more sessions in with your favourite coaches!',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 16),
                      ),
                    )
                  ]),
            ),
            const SizedBox(height: 40),
            TitleSubtitle(title: 'Featured Coaches', padding: EdgeInsets.zero),
          ],
        ),
      ),
    );
  }
}

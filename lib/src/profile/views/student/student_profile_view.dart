// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/models/student.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:hi_coach/core/common/widget/buttons/profile_info_button.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/common/widget/heading/heading.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/app_images.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final user = controller.user;
    return Scaffold(
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.profileLoading.value,
          progressIndicator: circularProgress(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PROFILE HEADER

                  StudentProfileHeader(
                    student: user!,
                    age: controller.calculateAge(user.dob!),
                  ),

                  // EDIT PROFILE BUTTON AND (CONTACT AND PROGESS BUTTON)

                  // BUTTON
                  SizedBox(height: 30.h),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 25.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ),

                  // CONATCT AND PROGRESS BUTTONS
                  SizedBox(height: 15.h),

                  const ContactAndProgressButtons(),

                  // SPORTS
                  SizedBox(height: 15.h),

                  Row(
                    children: List.generate(
                        user.sports.length,
                        (index) => TRoundedContainer(
                              radius: 10.r,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 4.h),
                              margin: EdgeInsets.only(right: 10.w),
                              backgroundColor: AppColors.filledTextField,
                              child: Center(
                                child: Text(
                                  user.sports[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                  ),

                  // BIO
                  SizedBox(height: 25.h),
                  TitleSubtitle(padding: EdgeInsets.zero, title: 'Bio'),
                  Text(
                      'Consequat velit qui adipisicing sunt do rependerit ad laborum tempor ullamco exercitation. Ullamco tempor adipisicing et voluptate duis sit esse aliqua',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColors.text)),

                  // UPCOMING CLASSES
                  SizedBox(height: 25.h),
                  TitleSubtitle(padding: EdgeInsets.zero, title: 'Upcoming'),
                  const SizedBox(height: 10),

                  const UpcomingClassWidget(),
                  const UpcomingClassWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UpcomingClassWidget extends StatelessWidget {
  const UpcomingClassWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15.h),
      backgroundColor: AppColors.filled,
      child: Row(
        children: [
          // DATE
          TRoundedContainer(
            height: 85.h,
            width: 100.w,
            backgroundColor: AppColors.primary,
            child: Center(
              child: Text(
                '19\nOct',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.white),
              ),
            ),
          ),
          // SPORT AND STATUS

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tennis',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColors.text, fontSize: 16.sp),
                    ),
                    Text(
                      'with Patty',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.text, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Tuesday, 4:30 pm',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.text),
                    )
                  ],
                ),
                Text(
                  'Pending',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.text,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContactAndProgressButtons extends StatelessWidget {
  const ContactAndProgressButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ProfileInfoButton(
          title: 'Call',
          child: Image.asset(AppIcons.call),
        ),
        ProfileInfoButton(
          title: 'Message',
          child: Image.asset(AppIcons.message),
        ),
        const ProfileInfoButton(
          title: 'Progress',
          child: Icon(Icons.leaderboard_outlined),
        ),
        ProfileInfoButton(
          title: 'Share',
          child: Image.asset(AppIcons.share),
        ),
      ],
    );
  }
}

class StudentProfileHeader extends StatelessWidget {
  const StudentProfileHeader({
    super.key,
    required this.student,
    required this.age,
  });

  final Student student;
  final int age;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.filled,
          ),
          child: student.profileURL!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: TCachedNetworkImage(
                      profileURL: student.profileURL!.first,
                      height: 100.h,
                      width: 100.w),
                )
              : Center(
                  child: Text(student.fullName.substring(0, 2).toUpperCase()),
                ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(student.fullName,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 5),
            _profileHeaderInfo(context, age.toString(), 'yrs'),
            const SizedBox(height: 5),
            _profileHeaderInfo(context, '3', 'Months on App'),
            const SizedBox(height: 5),
            _profileHeaderInfo(context, '0', 'Classes Taken'),
          ],
        )
      ],
    );
  }
}

Widget _profileHeaderInfo(BuildContext context, String title, String subtitle) {
  return Row(
    children: [
      Text(title,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w700)),
      const SizedBox(width: 5),
      Text(subtitle,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w400)),
    ],
  );
}

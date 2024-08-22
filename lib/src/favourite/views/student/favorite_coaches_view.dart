import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/models/coach.dart';
import 'package:hi_coach/src/favourite/controller/favourite_controller.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/profile/views/student/cp_student_view.dart';

class FavouriteCoachesView extends GetView<FavouriteController> {
  const FavouriteCoachesView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                'My Coaches',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 30.h),
              TRoundedContainer(
                padding: EdgeInsets.only(left: 15.w),
                height: 40.h,
                width: double.infinity,
                radius: 12.r,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 10.0,
                  ),
                ],
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      size: 20,
                      color: AppColors.text,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Search',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.text,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text('Favourites',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 15.sp)),
                  const SizedBox(width: 5),
                  const Icon(Icons.favorite, color: Colors.red, size: 20)
                ],
              ),
              SizedBox(height: 20.h),
              ListView.separated(
                shrinkWrap: true,
                itemCount: controller.favoriteCoaches.value.length,
                itemBuilder: (context, index) {
                  final id = controller.favoriteCoaches.value[index];
                  return FutureBuilder<Coach?>(
                      future: profileController.fetchCoachByID(id),
                      builder: (context, AsyncSnapshot<Coach?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        if (snapshot.hasData) {
                          final coach = snapshot.data!;
                          return FavCoachTile(coach: coach);
                        }
                        if (snapshot.hasError) {
                          Text(snapshot.error.toString());
                        }
                        return const SizedBox();
                      });
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FavCoachTile extends StatelessWidget {
  const FavCoachTile({
    super.key,
    required this.coach,
  });

  final Coach coach;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => CoachProfileStudentView(coachID: coach.id)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: TCachedNetworkImage(
                  profileURL: coach.profileURL![0], height: 50.h, width: 50.w),
            ),
            SizedBox(width: 20.w),
            Text(coach.fullName,
                style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
          ],
        ),
      ),
    );
  }
}

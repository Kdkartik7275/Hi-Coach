import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/models/user.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'My Coaches',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              TRoundedContainer(
                padding: const EdgeInsets.only(left: 15),
                height: 40,
                width: double.infinity,
                radius: 12,
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
                    const SizedBox(width: 10),
                    Text(
                      'Search',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text('Favourites',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 15)),
                  const SizedBox(width: 5),
                  const Icon(Icons.favorite, color: Colors.red, size: 20)
                ],
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemCount: controller.favoriteCoaches.value.length,
                itemBuilder: (context, index) {
                  final id = controller.favoriteCoaches.value[index];
                  return FutureBuilder<UserModel?>(
                      future: profileController.fetchUserById(id),
                      builder: (context, AsyncSnapshot<UserModel?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        if (snapshot.hasData) {
                          final coach = snapshot.data!;
                          return FavCoachTile(coach: coach);
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

  final UserModel coach;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => CoachProfileStudentView(coachID: coach.id)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: TCachedNetworkImage(
                  profileURL: coach.profileURL![0], height: 50, width: 50),
            ),
            const SizedBox(width: 20),
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

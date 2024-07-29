import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class CoachDrawer extends StatelessWidget {
  const CoachDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final user = controller.user!;
    return Drawer(
      width: 200,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(
        // Avoid splash and highlight effects on list tiles
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.filled,
                  ),
                  child: user.profileURL!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: TCachedNetworkImage(
                              profileURL: user.profileURL!.first,
                              height: 80,
                              width: 80),
                        )
                      : Center(
                          child:
                              Text(user.fullName.substring(0, 2).toUpperCase()),
                        ),
                ),
                const SizedBox(height: 12),
                Text(
                  user.fullName,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'My Earnings',
              style: TextStyle(color: AppColors.white),
            ),
            onTap: () {
              // Handle the tap event
              Navigator.pop(context);
            },
            splashColor: Colors.transparent,
          ),
          ListTile(
            title: const Text(
              'My Schedule',
              style: TextStyle(color: AppColors.white),
            ),
            onTap: () {
              // Handle the tap event
              Navigator.pop(context);
            },
            splashColor: Colors.transparent,
          ),
          ListTile(
            title: const Text(
              'My Students',
              style: TextStyle(color: AppColors.white),
            ),
            onTap: () {
              // Handle the tap event
              Navigator.pop(context);
            },
            splashColor: Colors.transparent,
          ),
          ListTile(
            title: const Text(
              'Progress Report',
              style: TextStyle(color: AppColors.white),
            ),
            onTap: () {
              // Handle the tap event
              Navigator.pop(context);
            },
            splashColor: Colors.transparent,
          ),
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyle(color: AppColors.white),
            ),
            onTap: () {
              // Handle the tap event
              Navigator.pop(context);
            },
            splashColor: Colors.transparent,
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: AppColors.white),
            ),
            onTap: () {
              // Handle the tap event
              controller.logoutUser();
            },
            splashColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

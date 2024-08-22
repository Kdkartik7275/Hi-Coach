import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final user = controller.user!;
    return Drawer(
      width: 200.w,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.filled,
                  ),
                  child: user.profileURL!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: TCachedNetworkImage(
                              profileURL: user.profileURL!.first,
                              height: 80.h,
                              width: 80.w),
                        )
                      : Center(
                          child:
                              Text(user.fullName.substring(0, 2).toUpperCase()),
                        ),
                ),
                SizedBox(height: 12.h),
                Text(
                  user.fullName,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'My Progress',
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
              'Privacy',
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

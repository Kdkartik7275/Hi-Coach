// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/containers/circular_container.dart';
import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/common/widget/image/network_image.dart';
import 'package:hi_coach/core/conifg/app_images.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/models/user.dart';
import 'package:hi_coach/src/favourite/controller/favourite_controller.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class CoachProfileHeader extends StatefulWidget {
  const CoachProfileHeader({
    super.key,
    required this.coach,
    required this.controller,
    this.backRequired = false,
  });

  final UserModel coach;
  final ProfileController controller;
  final bool backRequired;

  @override
  State<CoachProfileHeader> createState() => _CoachProfileHeaderState();
}

class _CoachProfileHeaderState extends State<CoachProfileHeader> {
  int currentIndex = 0;
  bool isFav = false;

  final favController = Get.find<FavouriteController>();

  toggleFav() {
    setState(() {
      isFav = !isFav;
    });
  }

  @override
  void initState() {
    super.initState();

    isFav = favController.favoriteCoaches.value.contains(widget.coach.id)
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return SizedBox(
      height: height * 0.30,
      width: width,
      child: Stack(
        children: [
          // USER PROFILE IMAGES
          Swiper(
            pagination: const SwiperPagination(builder: SwiperPagination.rect),
            itemCount: widget.coach.profileURL?.length ?? 0,
            onIndexChanged: (index) => setState(() {
              currentIndex = index;
            }),
            itemBuilder: (context, index) {
              return TCachedNetworkImage(
                profileURL: widget.coach.profileURL![index],
                height: height * 0.28,
                radius: 0,
                width: width,
              );
            },
          ),

          // USERNAME AND COACHING AREAS
          Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.coach.fullName,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w900),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300.0),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 5,
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      widget.coach.coachingAreas?.length ?? 0,
                      (index) {
                        return TRoundedContainer(
                          height: 22,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          radius: 5,
                          child: Text(
                            '${widget.coach.coachingAreas![index]}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 14),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // IMAGES INDEX
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.coach.profileURL?.length ?? 0,
                (index) => TRoundedContainer(
                  margin: const EdgeInsets.only(right: 10, bottom: 10),
                  height: 15,
                  width: index == currentIndex ? 30 : 15,
                  borderWidth: index == currentIndex ? 3 : 1,
                  showBorder: true,
                  borderColor: index == currentIndex
                      ? AppColors.primary
                      : AppColors.white,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),

          // ADD TO FAVOURITE ICON
          widget.coach.id == widget.controller.user?.id
              ? const SizedBox()
              : Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      favController.addCoachToFav(
                          widget.controller.user!.id, widget.coach.id);
                      toggleFav();
                    },
                    child: TCircularContainer(
                        margin: const EdgeInsets.only(right: 10, bottom: 15),
                        height: 50,
                        width: 50,
                        child: isFav
                            ? const Icon(Icons.favorite,
                                color: AppColors.primary, size: 30)
                            : Image.asset(AppIcons.favourite)),
                  ),
                ),

          widget.backRequired
              ? Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/utils/constants/sports.dart';
import 'package:hi_coach/src/search/controller/search_controller.dart';

class SelectSports extends StatelessWidget {
  const SelectSports({
    Key? key,
    required this.size,
    required this.controller,
    required this.location,
  }) : super(key: key);

  final Size size;
  final SearchCoachesController controller;
  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sportsName.length,
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  controller.selectedSport.value = sportsName[index];
                  controller.selectSportAndSearchCoaches(
                      sportsName[index], location);
                },
                child: Container(
                  width: 110,
                  height: 30,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: controller.selectedSport.value == sportsName[index]
                          ? AppColors.primary
                          : AppColors.filled),
                  child: Center(
                    child: Text(
                      sportsName[index],
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

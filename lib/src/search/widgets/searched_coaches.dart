// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hi_coach/core/common/widget/containers/circular_container.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/conifg/app_images.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/utils/constants/sort.dart';
import 'package:hi_coach/src/search/controller/search_controller.dart';
import 'package:hi_coach/src/search/widgets/searched_coach_tile.dart';

class SearchedCoachesList extends StatelessWidget {
  final SearchCoachesController controller;
  SearchedCoachesList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.08,
      minChildSize: 0.08,
      maxChildSize: 0.7,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  height: 20,
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 10),
                  child: Image.asset(AppImages.line),
                ),
                controller.coaches.isEmpty
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            "${controller.coaches.length} Coaches",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(width: 30),
                          PopupMenuButton(
                              color: AppColors.white,
                              elevation: 0,
                              child: const TRoundedContainer(
                                height: 30,
                                width: 80,
                                radius: 5,
                                borderColor: AppColors.black,
                                showBorder: true,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Sort'),
                                    Icon(Icons.sort),
                                  ],
                                ),
                              ),
                              itemBuilder: (context) {
                                return List.generate(
                                  soritngItems.length,
                                  (index) => PopupMenuItem(
                                    value: index,
                                    child: Row(
                                      children: [
                                        const TCircularContainer(
                                          height: 10,
                                          width: 10,
                                          showBorder: true,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(soritngItems[index])
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(width: 30),
                        ],
                      ),
                ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: controller.coaches.length,
                  itemBuilder: (context, index) {
                    final coach = controller.coaches[index];

                    return SearchedCoachTile(coach: coach);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

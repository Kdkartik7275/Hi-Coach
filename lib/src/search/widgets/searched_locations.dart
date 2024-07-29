import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hi_coach/core/common/controllers/location_controller.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/search/controller/search_controller.dart';
import 'package:hi_coach/src/search/views/nearby_coaches.dart';

class SearchedLocationList extends StatelessWidget {
  const SearchedLocationList({
    Key? key,
    required this.size,
    required this.searchController,
    required this.widget,
    required this.searchNode,
    required this.locationController,
  }) : super(key: key);

  final Size size;
  final SearchCoachesController searchController;
  final NearbyCoaches widget;

  final FocusNode searchNode;
  final LocationController locationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 2,
      width: size.width,
      color: AppColors.white,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: searchController.suggestions.value.length,
          itemBuilder: (context, index) {
            final place = searchController.suggestions.value[index];

            return ListTile(
              onTap: () async {
                searchNode.unfocus();
                LatLng? location = await searchController
                    .getLocationAndSearchCoaches(place.description);
                if (location != null) {
                  locationController.googleMapController.animateCamera(
                      CameraUpdate.newLatLngZoom(location, 14.0));
                }
              },
              title: Text(place.description),
              subtitle: Text(place.types.first),
            );
          }),
    );
  }
}

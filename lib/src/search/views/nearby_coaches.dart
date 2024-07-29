// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hi_coach/src/search/widgets/searched_locations.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:hi_coach/core/common/controllers/location_controller.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/app_images.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/search/controller/search_controller.dart';
import 'package:hi_coach/src/search/widgets/searched_coaches.dart';
import 'package:hi_coach/src/search/widgets/sports.dart';

class NearbyCoaches extends StatefulWidget {
  const NearbyCoaches({
    Key? key,
  }) : super(key: key);

  @override
  State<NearbyCoaches> createState() => _NearbyCoachesState();
}

class _NearbyCoachesState extends State<NearbyCoaches> {
  final searchController = Get.find<SearchCoachesController>();
  final locationController = Get.find<LocationController>();
  final searchFocusNode = FocusNode();

  @override
  void initState() {
    searchController.searchCoaches(
        searchController.selectedSport.value,
        locationController.currentPosition.value!.latitude,
        locationController.currentPosition.value!.longitude);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.restetAllFields();
    searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => locationController.locationLoading.value
          ? Scaffold(body: circularProgress(context))
          : Scaffold(
              body: LoadingOverlay(
                isLoading: searchController.searching.value,
                progressIndicator: circularProgress(context),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // GOOGLE MAP
                    locationController.locationLoading.value
                        ? circularProgress(context)
                        : GoogleMap(
                            initialCameraPosition:
                                locationController.initialPosition.value!,
                            mapType: MapType.terrain,
                            markers: locationController.markers,
                            onMapCreated: (GoogleMapController controller) {
                              locationController.googleMapController =
                                  controller;
                            },
                            zoomControlsEnabled: false,
                          ),

                    // SEARCH FIELD AND FILTER BUTTON
                    Positioned(
                      top: 30,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              searchController.restetAllFields();
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back,
                                color: AppColors.black, size: 30),
                          ),
                          SearchField(
                            focusNode: searchFocusNode,
                            onChanged: (value) {
                              if (value != '') {
                                searchController.getLocationSuggestions(
                                    query: value);
                              } else {
                                searchController.clearSugestions();
                              }
                            },
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                              onPressed: () {},
                              icon: Image.asset(AppIcons.filter))
                        ],
                      ),
                    ),

                    // SEARCHED LOCATION SUGGESTIONS
                    if (searchController.fetchingSuggestions.value)
                      circularProgress(context),
                    if (searchController.suggestions.value.isNotEmpty)
                      Positioned(
                        top: 120,
                        child: SearchedLocationList(
                          size: size,
                          searchController: searchController,
                          widget: widget,
                          locationController: locationController,
                          searchNode: searchFocusNode,
                        ),
                      ),

                    // SPORTS CHIP
                    Positioned(
                        top: 90,
                        child: SelectSports(
                          size: size,
                          controller: searchController,
                          location: LatLng(
                              locationController
                                  .currentPosition.value!.latitude,
                              locationController
                                  .currentPosition.value!.longitude),
                        )),

                    // SEARCHED COACHES LIST
                    searchController.coaches.isEmpty
                        ? const SizedBox()
                        : SearchedCoachesList(controller: searchController),
                  ],
                ),
              ),
            ),
    );
  }
}

class SearchField extends StatelessWidget {
  Function(String)? onChanged;
  final FocusNode focusNode;
  SearchField({
    Key? key,
    this.onChanged,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      height: 40,
      child: TextField(
        onChanged: onChanged,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          fillColor: AppColors.white,
          filled: true,
          hintText: 'Search Area or Postal Code',
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(25)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(25)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(25)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hi_coach/core/common/services/location_services.dart';
import 'package:hi_coach/core/conifg/app_images.dart';
import 'package:hi_coach/core/utils/helpers/functions.dart';

import 'package:hi_coach/models/placemodel.dart';

class LocationController extends GetxController {
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  BitmapDescriptor? userLocationIcon;
  BitmapDescriptor? defaultCoachIcon;

  var initialPosition = Rx<CameraPosition?>(null);
  var currentPosition = Rx<LatLng?>(null);
  var mapStyle = ''.obs;
  var locationLoading = false.obs;

  final services = LocationServices();

  @override
  void onInit() {
    super.onInit();

    _initializeController();
  }

  void _initializeController() {
    getMyLocation();
    loadMapStyle();
    loadCustomIcons();
  }

  Future<void> getMyLocation() async {
    try {
      locationLoading.value = true;
      final location = await getCurrentLocation();
      if (location != null) {
        _updateCurrentPosition(LatLng(location.latitude, location.longitude));
        _updateInitialPosition(location);
        setUserLocation(LatLng(location.latitude, location.longitude));
      }

      locationLoading.value = false;
    } catch (e) {
      locationLoading.value = false;
      _handleLocationError(e);
    }
  }

  void _updateCurrentPosition(LatLng location) {
    currentPosition.value = location;
  }

  void _updateInitialPosition(Position location) {
    initialPosition.value = CameraPosition(
      target: LatLng(location.latitude, location.longitude),
      zoom: 16.0,
    );
  }

  void _handleLocationError(dynamic error) {
    Get.snackbar('Location Error', error.toString());
  }

  void loadMapStyle() {
    rootBundle.loadString('assets/json/map_style.json').then((style) {
      mapStyle.value = style;
    });
  }

  Future<void> loadCustomIcons() async {
    userLocationIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      AppImages.location,
    );
    defaultCoachIcon = BitmapDescriptor.defaultMarker;
  }

  void setUserLocation(LatLng position) {
    _addMarker(
      markerId: 'user_location',
      position: position,
      icon: userLocationIcon ?? BitmapDescriptor.defaultMarker,
    );
  }

  void addCoachMarker(LatLng position, String coachId) {
    _addMarker(
      markerId: coachId,
      position: position,
      icon: defaultCoachIcon ?? BitmapDescriptor.defaultMarker,
    );
  }

  void _addMarker({
    required String markerId,
    required LatLng position,
    required BitmapDescriptor icon,
  }) {
    markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        icon: icon,
      ),
    );
  }

  void clearCoachesMarker() {
    markers.removeWhere((marker) => marker.markerId.value != 'user_location');
  }

  Future<List<PlaceModel>> getSuggestions(
      {required String input, required String sessionToken}) async {
    try {
      final list = await services.getSuggestions(
          input: input, sessionToken: sessionToken);
      return list;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List> getAreas(String input) async {
    try {
      return await services.getAreas(input);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<LatLng?> getLatLngFromAddress(String address) async {
    return await services.getLatLngFromAddress(address);
  }
}

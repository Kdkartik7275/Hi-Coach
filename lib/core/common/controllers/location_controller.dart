import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hi_coach/core/conifg/app_images.dart';
import 'package:hi_coach/core/conifg/keys.dart';
import 'package:hi_coach/core/utils/helpers/functions.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:hi_coach/models/placemodel.dart';
import 'package:uuid/uuid.dart';

class LocationController extends GetxController {
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  BitmapDescriptor? userLocationIcon;
  BitmapDescriptor? defaultCoachIcon;

  var initialPosition = Rx<CameraPosition?>(null);
  var currentPosition = Rx<LatLng?>(null);
  var mapStyle = ''.obs;
  var locationLoading = false.obs;

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

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth radius in kilometers
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  Future<List<PlaceModel>> getSuggestions(
      {required String input, required String sessionToken}) async {
    try {
      String kGooglePlacesAPI = Keys.googleApiKey;
      String baseURL =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request =
          '$baseURL?input=$input&key=$kGooglePlacesAPI&sessiontoken=$sessionToken';

      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var predictions = jsonDecode(response.body)['predictions'] as List;
        List<PlaceModel> places = predictions.map((prediction) {
          print(prediction['structured_formatting']['main_text']);
          return PlaceModel(
            description: prediction['description'],
            placeID: prediction['place_id'],
            types: prediction['types'],
          );
        }).toList();
        return places;
      } else {
        throw "Something went wrong. Please try again later";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List> getAreas(String input) async {
    try {
      String kGooglePlacesAPI = "AIzaSyCjKpwObSb4JnJZxTbeYzgAN_Ttn8f2zOU";
      String baseURL =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request =
          '$baseURL?input=$input&key=$kGooglePlacesAPI&sessiontoken=${const Uuid().v4()}';

      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var predictions = jsonDecode(response.body)['predictions'] as List;

        final areas = predictions.map((prediction) {
          return prediction['structured_formatting']['main_text'];
        }).toList();
        return areas;
      } else {
        throw "Something went wrong. Please try again later";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<LatLng?> getLatLngFromAddress(String address) async {
    String kGoogleGeocodingAPI =
        "AIzaSyCjKpwObSb4JnJZxTbeYzgAN_Ttn8f2zOU"; // Replace with your Geocoding API key
    String baseURL = "https://maps.googleapis.com/maps/api/geocode/json";
    String request = '$baseURL?address=$address&key=$kGoogleGeocodingAPI';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var results = jsonDecode(response.body)['results'] as List;
      if (results.isNotEmpty) {
        var geometry = results[0]['geometry'];
        var location = geometry['location'];
        double lat = location['lat'];
        double lng = location['lng'];

        return LatLng(lat, lng);
      } else {
        throw "No results found";
      }
    } else {
      throw "Something went wrong. Please try again later";
    }
  }
}

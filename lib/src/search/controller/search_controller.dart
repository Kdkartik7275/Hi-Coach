import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hi_coach/core/common/controllers/location_controller.dart';
import 'package:hi_coach/models/coach.dart';
import 'package:hi_coach/models/coaching_area.dart';
import 'package:hi_coach/models/placemodel.dart';
import 'package:hi_coach/services/search/search_services.dart';
import 'package:uuid/uuid.dart';

class SearchCoachesController extends GetxController {
  // OBSERVABLE VARIABLES
  var searching = false.obs;
  var fetchingSuggestions = false.obs;

  var selectedSport = ''.obs;
  var suggestions = Rx<List<PlaceModel>>([]);

  // SERVICES AND LISTS
  final services = SearchServices();
  final locationController = Get.find<LocationController>();
  List<Coach> coaches = [];
  List<CoachingArea> areas = [];

  // SEARCH COACHES

  Future<void> searchCoaches(
      String sport, double userLat, double userLon) async {
    try {
      searching.value = true;
      final coachesData =
          await services.searchCoachesBySprt(sport, userLat, userLon);

      coaches = coachesData['coaches'];
      areas = coachesData['areas'];

      _addMarkers(coaches, areas);

      searching.value = false;
    } catch (e) {
      searching.value = false;
    }
  }

  // FETCH LOCATION SUGGESTIONS

  getLocationSuggestions({required String query}) async {
    try {
      fetchingSuggestions.value = true;
      final list = await locationController.getSuggestions(
          input: query, sessionToken: const Uuid().v4());
      suggestions.value = list;

      fetchingSuggestions.value = false;
    } catch (e) {
      fetchingSuggestions.value = false;
      Get.snackbar("Error Occured", e.toString());
    }
  }

  // GET LOCATION FROM SEARCH FIELD AND SEARCH COACHES

  Future<LatLng?> getLocationAndSearchCoaches(String place) async {
    try {
      final location = await locationController.getLatLngFromAddress(place);

      if (location != null) {
        clearSugestions();
        coaches = [];

        locationController.clearCoachesMarker();

        searching.value = true;
        locationController.currentPosition.value =
            LatLng(location.latitude, location.longitude);
        locationController.googleMapController.animateCamera(
          CameraUpdate.newLatLng(locationController.currentPosition.value!),
        );
        final coachesData = await services.searchCoachesBySprt(
            selectedSport.value, location.latitude, location.longitude);

        coaches = coachesData['coaches'];
        areas = coachesData['areas'];

        _addMarkers(coaches, areas);
      }
      searching.value = false;
      return location;
    } catch (e) {
      searching.value = false;
    }
    return null;
  }

  // SELECT SPORT AND SEARCH

  void selectSportAndSearchCoaches(String sport, LatLng location) async {
    try {
      locationController.clearCoachesMarker();

      searching.value = true;
      final coachesData = await services.searchCoachesBySprt(
          selectedSport.value, location.latitude, location.longitude);

      coaches = coachesData['coaches'];
      areas = coachesData['areas'];

      _addMarkers(coaches, areas);

      searching.value = false;
    } catch (e) {
      searching.value = false;
      //
    }
  }

  clearSugestions() {
    suggestions.value = [];
    fetchingSuggestions.value = false;
  }

  _addMarkers(List<Coach> coachesData, List<CoachingArea> areas) {
    for (int i = 0; i <= coachesData.length; i++) {
      locationController.addCoachMarker(
          LatLng(areas[i].latitude, areas[i].longitude), coachesData[i].id);
    }
  }

  restetAllFields() {
    clearSugestions();
    coaches = [];
    selectedSport.value = '';
    final userLocation = locationController.markers
        .where((marker) => marker.markerId.value == 'user_location');

    locationController.currentPosition.value = userLocation.first.position;
  }
}

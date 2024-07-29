import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hi_coach/core/common/controllers/location_controller.dart';
import 'package:hi_coach/models/placemodel.dart';
import 'package:hi_coach/models/user.dart';
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
  List<UserModel> coaches = [];

  // SEARCH COACHES

  Future<void> searchCoaches(
      String sport, double userLat, double userLon) async {
    try {
      searching.value = true;
      final coachesData =
          await services.searchCoachesBySprt(sport, userLat, userLon);

      coaches = coachesData;

      _addMarkers(coachesData);

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
        final coachesData = await services.searchCoachesBySprt(
            selectedSport.value, location.latitude, location.longitude);

        coaches = coachesData;

        _addMarkers(coachesData);
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

      coaches = coachesData;

      _addMarkers(coachesData);

      searching.value = false;
    } catch (e) {
      searching.value = false;
      //
    }
  }

  // void sortCoaches(int sortBy) {
  //   switch (sortBy) {
  //     case 0:
  //     //  coaches.sort((a, b) => a.rating.compareTo(b.rating));
  //       break;
  //     case 1:
  //       coaches.sort((a, b) => a.distance.compareTo(b.distance));
  //       break;
  //     case 2:
  //       coaches.sort((a, b) => b.distance.compareTo(a.distance));
  //       break;
  //     case 3:
  //       coaches.sort((a, b) => b.price.compareTo(a.price));
  //       break;
  //     case 4:
  //       coaches.sort((a, b) => a.price.compareTo(b.price));
  //       break;
  //     default:
  //       // Default sorting method, e.g., by rating
  //       coaches.sort((a, b) => a.rating.compareTo(b.rating));
  //   }
  //   update(); // Notify GetX to update the UI
  // }

  clearSugestions() {
    suggestions.value = [];
    fetchingSuggestions.value = false;
  }

  _addMarkers(List<UserModel> coachesData) {
    for (var coach in coachesData) {
      locationController.addCoachMarker(
          LatLng(double.parse(coach.coachingLocation!['latitude']),
              double.parse(coach.coachingLocation!['longitude'])),
          coach.id);
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

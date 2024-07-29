import 'package:get/get.dart';
import 'package:hi_coach/services/profile/profile_services.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class FavouriteController extends GetxController {
  // OBSERVABLE VARIABLES

  var loading = false.obs;

  var favoriteCoaches = Rx<List<String>>([]);
  var favoriteStudents = Rx<List<String>>([]);

  // SERVICES
  final services = ProfileServices();

  // CONTROLLER
  final user = Get.find<ProfileController>().user!;

  // INIT METHOD
  @override
  void onInit() {
    super.onInit();
    fetchFavCoaches(user.id);
  }

  void addCoachToFav(String studentID, String coachID) async {
    try {
      await services.addCoachToFavorite(studentID, coachID);
      if (favoriteCoaches.value.contains(coachID)) {
        favoriteCoaches.value.remove(coachID);
      } else {
        favoriteCoaches.value.add(coachID);
      }
    } catch (e) {
      //
    }
  }

  void fetchFavCoaches(String studentID) async {
    try {
      final coaches = await services.getFavoriteCoaches(studentID);
      favoriteCoaches.value.assignAll(coaches);
    } catch (e) {
      //
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/controllers/location_controller.dart';
import 'package:hi_coach/models/user.dart';

class SearchServices {
  final _firestore = FirebaseFirestore.instance;

  final locationController = Get.find<LocationController>();

  Future<List<UserModel>> searchCoachesBySprt(
      String sport, double userLat, double userLon) async {
    final List<UserModel> allCoaches = await _getAllCoachesBySport(sport);
    print('ALL COACHES --------------------------------');
    print(allCoaches);

    final List<UserModel> nearbyCoaches = [];

    for (var coach in allCoaches) {
      if (coach.coachingLocation != null) {
        double coachLat = double.parse(coach.coachingLocation!['latitude']);
        double coachLon = double.parse(coach.coachingLocation!['longitude']);

        // Calculate distance
        double distance = locationController.calculateDistance(
            userLat, userLon, coachLat, coachLon);

        // Check if the distance is within 50 km
        if (distance <= 50) {
          nearbyCoaches.add(coach);
        }
      }
    }
    print('NEARBY COACHES --------------------------------');
    print(nearbyCoaches);

    return nearbyCoaches;
  }

// Mock function to fetch coaches
  Future<List<UserModel>> _getAllCoachesBySport(String sport) async {
    final coachesSnapshot = await _firestore
        .collection('Coaches')
        .where('sports', arrayContainsAny: [sport]).get();

    return coachesSnapshot.docs
        .map((doc) => UserModel.fromMap(doc.data()))
        .toList();
  }
}

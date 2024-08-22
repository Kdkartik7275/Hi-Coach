import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hi_coach/core/utils/helpers/functions.dart';
import 'package:hi_coach/models/coach.dart';
import 'package:hi_coach/models/coaching_area.dart';

class SearchServices {
  final _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> searchCoachesBySprt(
      String sport, double userLat, double userLon) async {
    final List<Coach> allCoaches = await _getAllCoachesBySport(sport);

    final List<Coach> nearbyCoaches = [];
    final List<CoachingArea> areas = [];

    for (var coach in allCoaches) {
      if (coach.coachingAreas != null && coach.coachingAreas!.isNotEmpty) {
        bool isWithinRange = false;

        for (var area in coach.coachingAreas!) {
          double areaLat = area.latitude;
          double areaLon = area.longitude;

          // Calculate distance
          double distance =
              calculateDistance(userLat, userLon, areaLat, areaLon);

          // Check if the distance is within 50 km
          if (distance <= 50) {
            isWithinRange = true;
            areas.add(area);
            break; // No need to check other areas, as we found one in range
          }
        }

        if (isWithinRange) {
          nearbyCoaches.add(coach);
        }
      }
    }
    // print('NEARBY COACHES --------------------------------');
    // print(nearbyCoaches);

    return {'coaches': nearbyCoaches, 'areas': areas};
  }

  // Mock function to fetch coaches
  Future<List<Coach>> _getAllCoachesBySport(String sport) async {
    final coachesSnapshot = await _firestore
        .collection('Coaches')
        .where('sports', arrayContainsAny: [sport]).get();

    return coachesSnapshot.docs
        .map((doc) => Coach.fromMap(doc.data()))
        .toList();
  }
}

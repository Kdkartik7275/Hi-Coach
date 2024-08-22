import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hi_coach/models/invitation.dart';

class NotificationServices {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Invitation>> getClassInvitations(String studentID) async {
    try {
      final invitationsRef = await _firestore
          .collection('Requests')
          .where('studentID', isEqualTo: studentID)
          .where('isInvited', isEqualTo: true)
          .get();

      return invitationsRef.docs
          .map((invitation) => Invitation.fromMap(invitation.data()))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}

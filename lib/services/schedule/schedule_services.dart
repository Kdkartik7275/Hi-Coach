import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hi_coach/models/invitation.dart';
import 'package:hi_coach/models/session.dart';
import 'package:hi_coach/models/student.dart';
import 'package:hi_coach/models/timings.dart';
import 'package:uuid/uuid.dart';

class ScheduleServices {
  final _firestore = FirebaseFirestore.instance;

  // Future<List<Schedule>> getAllSchedules(String coachID) async {
  //   try {
  //     final schedulesRef = await _firestore
  //         .collection('Schedules')
  //         .where('coachID', isEqualTo: coachID)
  //         .get();

  //     List<Schedule> schedules = schedulesRef.docs
  //         .map((schedule) => Schedule.fromMap(schedule.data()))
  //         .toList();

  //     return schedules;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  Future<Timings> addTimings(String id, Timings timing) async {
    try {
      await _firestore.collection('Coaches').doc(id).update({
        'timings': FieldValue.arrayUnion([timing])
      });
      return timing;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Session> addCoachingSession(Session session) async {
    try {
      await _firestore
          .collection('Classes')
          .doc(session.id)
          .set(session.toMap());

      return session;
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<Schedule> addSchedule(Schedule schedule) async {
  //   try {
  //     await _firestore
  //         .collection('Schedules')
  //         .doc(schedule.id)
  //         .set(schedule.toMap());
  //     return schedule;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  Future<void> inviteStudents(List<String> studentIDs, String sessionID,
      String coachID, int pax) async {
    try {
      final scheduleRef = _firestore.collection('Classes').doc(sessionID);

      for (var studentID in studentIDs) {
        String id = const Uuid().v4();
        Invitation newInvitation = Invitation(
            id: id,
            classID: sessionID,
            coachID: coachID,
            studentID: studentID,
            isInvited: true,
            pax: pax);
        await _firestore
            .collection('Requests')
            .doc(id)
            .set(newInvitation.toMap());
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Student>> searchStudents(String fullName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(
              'Students') // Assuming your collection is named 'students'
          .where('fullName', isGreaterThanOrEqualTo: fullName)
          .get();

      List<Student> students = querySnapshot.docs.map((doc) {
        return Student.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return students;
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<Schedule?> classById(String classID) async {
  //   try {
  //     final schedule =
  //         await _firestore.collection('Schedules').doc(classID).get();

  //     return Schedule.fromMap(schedule.data()!);
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hi_coach/models/request.dart';
import 'package:hi_coach/models/schedule.dart';
import 'package:hi_coach/models/user.dart';
import 'package:uuid/uuid.dart';

class ScheduleServices {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Schedule>> getAllSchedules(String coachID) async {
    try {
      final schedulesCollection = await _firestore
          .collection('Coaches')
          .doc(coachID)
          .collection('Schedules')
          .get();

      List<Schedule> schedules = schedulesCollection.docs
          .map((schedule) => Schedule.fromMap(schedule.data()))
          .toList();
      return schedules;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Schedule> addSchedule(Schedule schedule, String coachID) async {
    try {
      await _firestore
          .collection('Coaches')
          .doc(coachID)
          .collection('Schedules')
          .doc(schedule.id)
          .set(schedule.toMap());
      return schedule;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> inviteStudents(
      List<String> studentIDs, Schedule schedule, String coachID) async {
    try {
      final scheduleRef = _firestore
          .collection('Coaches')
          .doc(coachID)
          .collection('Schedules')
          .doc(schedule.id);

      await scheduleRef.update({
        'invited': FieldValue.arrayUnion(studentIDs),
      });

      for (var student in studentIDs) {
        String id = const Uuid().v4();
        ClassRequest newRequest = ClassRequest(
            requestID: id,
            classId: schedule.id!,
            classFrom: coachID,
            studentID: student,
            isAccepted: false,
            denied: false);
        await _firestore
            .collection('Students')
            .doc(student)
            .collection('Requests')
            .doc(id)
            .set(newRequest.toMap());
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<UserModel>> searchStudents(String fullName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(
              'Students') // Assuming your collection is named 'students'
          .where('fullName', isGreaterThanOrEqualTo: fullName)
          .get();

      List<UserModel> students = querySnapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return students;
    } catch (e) {
      throw e.toString();
    }
  }
}

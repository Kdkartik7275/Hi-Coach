import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  String? id;
  String? title;
  String? location;
  String? sport;
  Timestamp? startTime;
  Timestamp? endTime;

  String? repeat;
  int? pax;
  int? minAge;
  int? maxAge;
  List<String>? students;
  String? description;

  Schedule({
    this.id,
    required this.title,
    required this.location,
    required this.sport,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.pax,
    required this.minAge,
    required this.maxAge,
    required this.students,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'sport': sport,
      'startTime': startTime,
      'endTime': endTime,
      'repeat': repeat,
      'pax': pax,
      'minAge': minAge,
      'maxAge': maxAge,
      'students': students,
      'description': description,
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      id: map['id'],
      title: map['title'],
      location: map['location'],
      sport: map['sport'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      repeat: map['repeat'],
      pax: map['pax'],
      minAge: map['minAge'],
      maxAge: map['maxAge'],
      students: List<String>.from(map['students']),
      description: map['description'],
    );
  }
}

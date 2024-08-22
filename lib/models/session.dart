// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Session {
  final String id;
  final String title;
  final String coachID;
  final String location;
  final String sport;
  final Timestamp startTime;
  final Timestamp endTime;
  final String repeat;
  final int pax;
  final int minAge;
  final int maxAge;
  final List students;
  final String description;
  Session({
    required this.id,
    required this.title,
    required this.coachID,
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

  Session copyWith({
    String? id,
    String? title,
    String? coachID,
    String? location,
    String? sport,
    Timestamp? startTime,
    Timestamp? endTime,
    String? repeat,
    int? pax,
    int? minAge,
    int? maxAge,
    List? students,
    String? description,
  }) {
    return Session(
      id: id ?? this.id,
      title: title ?? this.title,
      coachID: coachID ?? this.coachID,
      location: location ?? this.location,
      sport: sport ?? this.sport,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      repeat: repeat ?? this.repeat,
      pax: pax ?? this.pax,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      students: students ?? this.students,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'coachID': coachID,
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

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'] as String,
      title: map['title'] as String,
      coachID: map['coachID'] as String,
      location: map['location'] as String,
      sport: map['sport'] as String,
      startTime: map['startTime'],
      endTime: map['endTime'],
      repeat: map['repeat'] as String,
      pax: map['pax'] as int,
      minAge: map['minAge'] as int,
      maxAge: map['maxAge'] as int,
      students: map['students'],
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Session(id: $id, title: $title, coachID: $coachID, location: $location, sport: $sport, startTime: $startTime, endTime: $endTime, repeat: $repeat, pax: $pax, minAge: $minAge, maxAge: $maxAge, students: $students, description: $description)';
  }

  @override
  bool operator ==(covariant Session other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.coachID == coachID &&
        other.location == location &&
        other.sport == sport &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.repeat == repeat &&
        other.pax == pax &&
        other.minAge == minAge &&
        other.maxAge == maxAge &&
        listEquals(other.students, students) &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        coachID.hashCode ^
        location.hashCode ^
        sport.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        repeat.hashCode ^
        pax.hashCode ^
        minAge.hashCode ^
        maxAge.hashCode ^
        students.hashCode ^
        description.hashCode;
  }
}

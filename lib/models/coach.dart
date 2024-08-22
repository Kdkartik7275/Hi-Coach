// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:hi_coach/models/coaching_area.dart';
import 'package:hi_coach/models/timings.dart';

class Coach {
  final String id;
  final String email;
  final String fullName;
  final String phone;
  final String bio;
  String? gender;
  String? userType;
  List? profileURL;
  String? dob;
  final List sports;
  Timestamp? createdAt;
  List<CoachingArea>? coachingAreas;
  String? playingExperience;
  String? coachingExperience;
  List? certifications;
  List<Timings>? timings;
  Coach({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.bio,
    this.gender,
    this.userType,
    this.profileURL,
    this.dob,
    required this.sports,
    this.createdAt,
    this.coachingAreas,
    this.playingExperience,
    this.coachingExperience,
    this.certifications,
    this.timings,
  });

  Coach copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    String? bio,
    String? gender,
    String? userType,
    List? profileURL,
    String? dob,
    List? sports,
    Timestamp? createdAt,
    List<CoachingArea>? coachingAreas,
    String? playingExperience,
    String? coachingExperience,
    List? certifications,
    List<Timings>? timings,
  }) {
    return Coach(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      userType: userType ?? this.userType,
      profileURL: profileURL ?? this.profileURL,
      dob: dob ?? this.dob,
      sports: sports ?? this.sports,
      createdAt: createdAt ?? this.createdAt,
      coachingAreas: coachingAreas ?? this.coachingAreas,
      playingExperience: playingExperience ?? this.playingExperience,
      coachingExperience: coachingExperience ?? this.coachingExperience,
      certifications: certifications ?? this.certifications,
      timings: timings ?? this.timings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'bio': bio,
      'gender': gender,
      'userType': userType,
      'profileURL': profileURL,
      'dob': dob,
      'sports': sports,
      'createdAt': createdAt,
      'coachingAreas': coachingAreas?.map((x) => x.toMap()).toList(),
      'playingExperience': playingExperience,
      'coachingExperience': coachingExperience,
      'certifications': certifications,
      'timings': timings?.map((x) => x.toMap()).toList(),
    };
  }

  factory Coach.fromMap(Map<String, dynamic> map) {
    return Coach(
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      phone: map['phone'] as String,
      bio: map['bio'] as String,
      gender: map['gender'] != null ? map['gender'] as String : null,
      userType: map['userType'] != null ? map['userType'] as String : null,
      profileURL: map['profileURL'],
      dob: map['dob'] != null ? map['dob'] as String : null,
      sports: map['sports'],
      createdAt: map['createdAt'],
      coachingAreas: map['coachingAreas'] != null
          ? List<CoachingArea>.from(
              map['coachingAreas'].map<CoachingArea>(
                (x) => CoachingArea.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      playingExperience: map['playingExperience'] != null
          ? map['playingExperience'] as String
          : null,
      coachingExperience: map['coachingExperience'] != null
          ? map['coachingExperience'] as String
          : null,
      certifications: map['certifications'],
      timings: map['timings'] != null
          ? List<Timings>.from(
              map['timings'].map<Timings>(
                (x) => Timings.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coach.fromJson(String source) =>
      Coach.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Coach(id: $id, email: $email, fullName: $fullName, phone: $phone, bio: $bio, gender: $gender, userType: $userType, profileURL: $profileURL, dob: $dob, sports: $sports, createdAt: $createdAt, coachingAreas: $coachingAreas, playingExperience: $playingExperience, coachingExperience: $coachingExperience, certifications: $certifications, timings: $timings)';
  }

  @override
  bool operator ==(covariant Coach other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.fullName == fullName &&
        other.phone == phone &&
        other.bio == bio &&
        other.gender == gender &&
        other.userType == userType &&
        other.profileURL == profileURL &&
        other.dob == dob &&
        listEquals(other.sports, sports) &&
        other.createdAt == createdAt &&
        listEquals(other.coachingAreas, coachingAreas) &&
        other.playingExperience == playingExperience &&
        other.coachingExperience == coachingExperience &&
        other.certifications == certifications &&
        listEquals(other.timings, timings);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        fullName.hashCode ^
        phone.hashCode ^
        bio.hashCode ^
        gender.hashCode ^
        userType.hashCode ^
        profileURL.hashCode ^
        dob.hashCode ^
        sports.hashCode ^
        createdAt.hashCode ^
        coachingAreas.hashCode ^
        playingExperience.hashCode ^
        coachingExperience.hashCode ^
        certifications.hashCode ^
        timings.hashCode;
  }
}

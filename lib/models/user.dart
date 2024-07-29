// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String phone;
  final String bio;
  String? gender;
  String? userType;
  List? profileURL;
  List? coachingAreas;
  String? dob;
  final List sports;
  String? playingExperience;
  String? coachingExperience;
  Map<String, dynamic>? coachingLocation;

  List? certifications;
  Timestamp? createdAt;
  Timestamp? lastSeen;
  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.bio,
    this.gender,
    this.userType,
    this.coachingAreas,
    this.profileURL,
    this.coachingLocation,
    this.dob,
    required this.sports,
    this.playingExperience,
    this.coachingExperience,
    this.certifications,
    this.createdAt,
    this.lastSeen,
  });

  UserModel copyWith({
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
    List? coachingAreas,
    String? playingExperience,
    String? coachingExperience,
    List? certifications,
    Timestamp? createdAt,
    Timestamp? lastSeen,
    Map<String, dynamic>? coachingLocation,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      userType: userType ?? this.userType,
      profileURL: profileURL ?? this.profileURL,
      certifications: certifications ?? this.certifications,
      createdAt: createdAt ?? this.createdAt,
      lastSeen: lastSeen ?? this.lastSeen,
      coachingAreas: coachingAreas ?? this.coachingAreas,
      dob: dob ?? this.dob,
      coachingLocation: coachingLocation ?? this.coachingLocation,
      sports: sports ?? this.sports,
      playingExperience: playingExperience ?? this.playingExperience,
      coachingExperience: coachingExperience ?? this.coachingExperience,
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
      'playingExperience': playingExperience,
      'coachingExperience': coachingExperience,
      'certifications': certifications,
      'lastSeen': lastSeen,
      'createdAt': createdAt,
      'coachingLocation': coachingLocation,
      'coachingAreas': coachingAreas,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] as String,
        email: map['email'] as String,
        fullName: map['fullName'] as String,
        phone: map['phone'] as String,
        bio: map['bio'] as String,
        gender: map['gender'] != null ? map['gender'] as String : null,
        userType: map['userType'] != null ? map['userType'] as String : null,
        profileURL: List.from((map['profileURL'] as List)),
        dob: map['dob'] != null ? map['dob'] as String : null,
        sports: List.from((map['sports'] as List)),
        coachingAreas: List.from((map['coachingAreas'] as List)),
        playingExperience: map['playingExperience'] != null
            ? map['playingExperience'] as String
            : null,
        coachingExperience: map['coachingExperience'] != null
            ? map['coachingExperience'] as String
            : null,
        certifications: map['certifications'] ?? [],
        createdAt: map['createdAt'] ?? Timestamp.now(),
        coachingLocation: map['coachingLocation'] ?? {},
        lastSeen: map['lastSeen'] ?? Timestamp.now());
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, fullName: $fullName, phone: $phone, bio: $bio, gender: $gender, userType: $userType, profileURL: $profileURL, dob: $dob, sports: $sports, playingExperience: $playingExperience, coachingExperience: $coachingExperience)';
  }

  @override
  bool operator ==(covariant UserModel other) {
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
        other.playingExperience == playingExperience &&
        other.coachingExperience == coachingExperience;
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
        playingExperience.hashCode ^
        coachingExperience.hashCode;
  }
}

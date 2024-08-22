// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Student {
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

  Student({
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
  });

  Student copyWith({
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
  }) {
    return Student(
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
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      phone: map['phone'] as String,
      bio: map['bio'] as String,
      gender: map['gender'] != null ? map['gender'] as String : null,
      userType: map['userType'] != null ? map['userType'] as String : null,
      profileURL: map['profileURL'] ?? [],
      dob: map['dob'] != null ? map['dob'] as String : null,
      sports: List.from((map['sports'] as List)),
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(id: $id, email: $email, fullName: $fullName, phone: $phone, bio: $bio, gender: $gender, userType: $userType, profileURL: $profileURL, dob: $dob, sports: $sports, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Student other) {
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
        other.createdAt == createdAt;
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
        createdAt.hashCode;
  }
}

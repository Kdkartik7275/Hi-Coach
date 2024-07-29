// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClassRequest {
  final String requestID;
  final String classId;
  final String classFrom;
  final String studentID;
  final bool isAccepted;
  final bool denied;
  ClassRequest({
    required this.requestID,
    required this.classId,
    required this.classFrom,
    required this.studentID,
    required this.isAccepted,
    required this.denied,
  });

  ClassRequest copyWith({
    String? requestID,
    String? classId,
    String? classFrom,
    String? studentID,
    bool? isAccepted,
    bool? denied,
  }) {
    return ClassRequest(
      requestID: requestID ?? this.requestID,
      classId: classId ?? this.classId,
      classFrom: classFrom ?? this.classFrom,
      studentID: studentID ?? this.studentID,
      isAccepted: isAccepted ?? this.isAccepted,
      denied: denied ?? this.denied,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestID': requestID,
      'classId': classId,
      'classFrom': classFrom,
      'studentID': studentID,
      'isAccepted': isAccepted,
      'denied': denied,
    };
  }

  factory ClassRequest.fromMap(Map<String, dynamic> map) {
    return ClassRequest(
      requestID: map['requestID'] as String,
      classId: map['classId'] as String,
      classFrom: map['classFrom'] as String,
      studentID: map['studentID'] as String,
      isAccepted: map['isAccepted'] as bool,
      denied: map['denied'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassRequest.fromJson(String source) =>
      ClassRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}

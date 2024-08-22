// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Timings {
  final String address;
  final bool isHoliday;
  final Timestamp date;
  final List<Map<String, dynamic>> timings;
  Timings({
    required this.address,
    required this.date,
    required this.isHoliday,
    required this.timings,
  });

  Timings copyWith({
    String? address,
    Timestamp? date,
    List<Map<String, dynamic>>? timings,
    bool? isHoliday,
  }) {
    return Timings(
      address: address ?? this.address,
      isHoliday: isHoliday ?? this.isHoliday,
      date: date ?? this.date,
      timings: timings ?? this.timings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'date': date,
      'timings': timings,
      'isHoliday': isHoliday
    };
  }

  factory Timings.fromMap(Map<String, dynamic> map) {
    return Timings(
      address: map['address'] as String,
      isHoliday: map['isHoliday'],
      date: map['date'],
      timings: List<Map<String, dynamic>>.from(
        map['timings'].map((x) => x),
      ),
    );
  }
}

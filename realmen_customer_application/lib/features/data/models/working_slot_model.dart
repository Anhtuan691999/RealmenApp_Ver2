// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class WorkingSlotModel extends Equatable {
  String? from;
  String? to;
  int? bookingCount;
  String? shiftCode;
  String? shiftName;

  WorkingSlotModel({
    this.from,
    this.to,
    this.bookingCount,
    this.shiftCode,
    this.shiftName,
  });

  @override
  List<Object?> get props => [
        from,
        to,
        bookingCount,
        shiftCode,
        shiftName,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'bookingCount': bookingCount,
      'shiftCode': shiftCode,
      'shiftName': shiftName,
    };
  }

  factory WorkingSlotModel.fromMap(Map<String, dynamic> map) {
    return WorkingSlotModel(
      from: map['from'] != null ? map['from'] as String : null,
      to: map['to'] != null ? map['to'] as String : null,
      bookingCount:
          map['bookingCount'] != null ? map['bookingCount'] as int : null,
      shiftCode: map['shiftCode'] != null ? map['shiftCode'] as String : null,
      shiftName: map['shiftName'] != null ? map['shiftName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkingSlotModel.fromJson(Map<String, dynamic> source) =>
      WorkingSlotModel.fromMap(source);
}

class TimeSlotCardModel extends Equatable {
  bool isSelectable;
  String timeSlot;
  String type;
  TimeSlotCardModel({
    required this.isSelectable,
    required this.timeSlot,
    required this.type,
  });

  @override
  List<Object?> get props => [isSelectable, timeSlot];
}

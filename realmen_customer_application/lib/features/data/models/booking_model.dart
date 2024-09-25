// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class BookingServiceModel extends Equatable {
  int serviceId;
  int staffId;
  String beginAtReq;
  BookingServiceModel({
    required this.serviceId,
    required this.staffId,
    required this.beginAtReq,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceId': serviceId,
      'staffId': staffId,
      'beginAtReq': beginAtReq,
    };
  }

  factory BookingServiceModel.fromMap(Map<String, dynamic> map) {
    return BookingServiceModel(
      serviceId: map['serviceId'] as int,
      staffId: map['staffId'] as int,
      beginAtReq: map['beginAtReq'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingServiceModel.fromJson(String source) =>
      BookingServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BookingModel extends Equatable {
  final int branchId;
  final List<BookingServiceModel> bookingServices;
  BookingModel({
    required this.branchId,
    required this.bookingServices,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'branchId': branchId,
      'bookingServices': bookingServices.map((x) => x.toMap()).toList(),
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      branchId: map['branchId'] as int,
      bookingServices: List<BookingServiceModel>.from(
        (map['bookingServices'] as List<int>).map<BookingServiceModel>(
          (x) => BookingServiceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

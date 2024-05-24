import 'dart:core';

import 'package:realmen_staff_application/models/branch/branch_model.dart';

class AccountInfoModel {
  int? accountId;
  int? branchId;
  String? thumbnailUrl;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? dob;
  String? gender;
  String? status;
  BranchModel? branch;
  StaffModel? staff;

  String? itimacyLevel;
  String? professional;
  int? average;
  String? role;

  int? totalElements;
  int? totalPages;
  int? pageSize;
  int? current;

  AccountInfoModel({
    this.accountId,
    this.branchId,
    this.thumbnailUrl,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.dob,
    this.gender,
    this.status,
    this.branch,
    this.staff,
    this.itimacyLevel,
    this.professional,
    this.average,
    this.role,
    this.totalElements,
    this.totalPages,
    this.pageSize,
    this.current,
  });

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) {
    return AccountInfoModel(
      accountId: json['accountId'],
      branchId: json['branchId'],
      thumbnailUrl: json['thumbnailUrl'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      address: json['address'],
      dob: json['dob'],
      gender: json['gender'],
      status: json['status'],
      branch: json['branch'] != null && json['branch'] != []
          ? BranchModel.fromJson(json['branch'])
          : null,
      staff: json['staff'] != null && json['staff'] != []
          ? StaffModel.fromJson(json['staff'])
          : null,
      itimacyLevel: json['itimacyLevel'],
      professional: json['professional'],
      average: json['average'] ?? 0,
      role: json['role'],
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      pageSize: json['pageSize'],
      current: json['current'],
    );
  }
}

class StaffModel {
  int? staffId;
  int? accountId;
  double? averageRating;
  List<ScheduleModel>? scheduleList;
  String? professional;

  StaffModel({
    this.staffId,
    this.accountId,
    this.averageRating,
    this.scheduleList,
    this.professional,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      accountId: json['accountId'],
      staffId: json['staffId'],
      averageRating:
          json['averageRating'] == "NaN" ? null : json['averageRating'],
      scheduleList: json['scheduleList'] != null && json['scheduleList'] != []
          ? (json['scheduleList'] as List)
              .map((item) => ScheduleModel.fromJson(item))
              .toList()
          : null,
      professional: json['professional'],
    );
  }
}

class ScheduleModel {
  int? scheduleId;
  int? staffId;
  int? shiftId;
  String? shift;
  String? workingDate;
  String? start;
  String? end;
  String? scheduleStatus;

  ScheduleModel({
    this.scheduleId,
    this.staffId,
    this.shiftId,
    this.shift,
    this.workingDate,
    this.start,
    this.end,
    this.scheduleStatus,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'],
      staffId: json['staffId'],
      shiftId: json['shiftId'],
      shift: json['shift'],
      workingDate: json['workingDate'],
      start: json['start'],
      end: json['end'],
      scheduleStatus: json['scheduleStatus'],
    );
  }
}

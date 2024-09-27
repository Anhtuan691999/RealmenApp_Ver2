// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DailyPlanAccountModel extends Equatable {
  int? dailyPlanAccountId;
  int? dailyPlanId;
  int? accountId;
  String? fullName;
  String? phone;
  String? genderCode;
  String? genderName;
  String? professionalTypeCode;
  String? professionalTypeName;
  String? thumbnail;
  String? accountStatusCode;
  String? accountStatusName;
  String? shiftCode;
  String? shiftName;
  // bo sung data
  String? nickName;

  DailyPlanAccountModel({
    this.dailyPlanAccountId,
    this.dailyPlanId,
    this.accountId,
    this.fullName,
    this.phone,
    this.genderCode,
    this.genderName,
    this.professionalTypeCode,
    this.professionalTypeName,
    this.thumbnail,
    this.accountStatusCode,
    this.accountStatusName,
    this.shiftCode,
    this.shiftName,
    this.nickName,
  });

  @override
  List<Object?> get props => [
        dailyPlanAccountId,
        dailyPlanId,
        accountId,
        fullName,
        phone,
        genderCode,
        genderName,
        professionalTypeCode,
        professionalTypeName,
        thumbnail,
        accountStatusCode,
        accountStatusName,
        shiftCode,
        shiftName,
        nickName
      ];

  factory DailyPlanAccountModel.fromMap(Map<String, dynamic> map) {
    return DailyPlanAccountModel(
      dailyPlanAccountId: map['dailyPlanAccountId'] != null
          ? map['dailyPlanAccountId'] as int
          : null,
      dailyPlanId:
          map['dailyPlanId'] != null ? map['dailyPlanId'] as int : null,
      accountId: map['accountId'] != null ? map['accountId'] as int : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      genderCode:
          map['genderCode'] != null ? map['genderCode'] as String : null,
      genderName:
          map['genderName'] != null ? map['genderName'] as String : null,
      professionalTypeCode: map['professionalTypeCode'] != null
          ? map['professionalTypeCode'] as String
          : null,
      professionalTypeName: map['professionalTypeName'] != null
          ? map['professionalTypeName'] as String
          : null,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
      accountStatusCode: map['accountStatusCode'] != null
          ? map['accountStatusCode'] as String
          : null,
      accountStatusName: map['accountStatusName'] != null
          ? map['accountStatusName'] as String
          : null,
      shiftCode: map['shiftCode'] != null ? map['shiftCode'] as String : null,
      shiftName: map['shiftName'] != null ? map['shiftName'] as String : null,
    );
  }

  factory DailyPlanAccountModel.fromJson(Map<String, dynamic> source) =>
      DailyPlanAccountModel.fromMap(source);
}

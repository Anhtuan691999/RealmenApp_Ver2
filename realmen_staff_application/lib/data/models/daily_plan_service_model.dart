// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DailyPlanServiceModel extends Equatable {
  int? dailyPlanServiceId;
  int? dailyPlanId;
  int? weeklyPlanId;
  int? branchId;
  int? shopServiceId;
  String? shopServiceName;
  int? branchServicePrice;
  String? serviceAssignmentCode;
  String? serviceAssignmentName;
  String? categoryCode;
  String? categoryName;
  int? estimateDuration;
  String? durationUnitCode;
  String? durationUnitName;

  DailyPlanServiceModel({
    this.dailyPlanServiceId,
    this.dailyPlanId,
    this.weeklyPlanId,
    this.branchId,
    this.shopServiceId,
    this.shopServiceName,
    this.branchServicePrice,
    this.serviceAssignmentCode,
    this.serviceAssignmentName,
    this.categoryCode,
    this.categoryName,
    this.estimateDuration,
    this.durationUnitCode,
    this.durationUnitName,
  });

  @override
  List<Object?> get props => [
        dailyPlanServiceId,
        dailyPlanId,
        weeklyPlanId,
        branchId,
        shopServiceId,
        shopServiceName,
        branchServicePrice,
        serviceAssignmentCode,
        serviceAssignmentName,
        categoryCode,
        categoryName,
        estimateDuration,
        durationUnitCode,
        durationUnitName,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dailyPlanServiceId': dailyPlanServiceId,
      'dailyPlanId': dailyPlanId,
      'weeklyPlanId': weeklyPlanId,
      'branchId': branchId,
      'shopServiceId': shopServiceId,
      'shopServiceName': shopServiceName,
      'branchServicePrice': branchServicePrice,
      'serviceAssignmentCode': serviceAssignmentCode,
      'serviceAssignmentName': serviceAssignmentName,
      'categoryCode': categoryCode,
      'categoryName': categoryName,
      'estimateDuration': estimateDuration,
      'durationUnitCode': durationUnitCode,
      'durationUnitName': durationUnitName,
    };
  }

  factory DailyPlanServiceModel.fromMap(Map<String, dynamic> map) {
    return DailyPlanServiceModel(
      dailyPlanServiceId: map['dailyPlanServiceId'] != null
          ? map['dailyPlanServiceId'] as int
          : null,
      dailyPlanId:
          map['dailyPlanId'] != null ? map['dailyPlanId'] as int : null,
      weeklyPlanId:
          map['weeklyPlanId'] != null ? map['weeklyPlanId'] as int : null,
      branchId: map['branchId'] != null ? map['branchId'] as int : null,
      shopServiceId:
          map['shopServiceId'] != null ? map['shopServiceId'] as int : null,
      shopServiceName: map['shopServiceName'] != null
          ? map['shopServiceName'] as String
          : null,
      branchServicePrice: map['branchServicePrice'] != null
          ? map['branchServicePrice'] as int
          : null,
      serviceAssignmentCode: map['serviceAssignmentCode'] != null
          ? map['serviceAssignmentCode'] as String
          : null,
      serviceAssignmentName: map['serviceAssignmentName'] != null
          ? map['serviceAssignmentName'] as String
          : null,
      categoryCode:
          map['categoryCode'] != null ? map['categoryCode'] as String : null,
      categoryName:
          map['categoryName'] != null ? map['categoryName'] as String : null,
      estimateDuration: map['estimateDuration'] != null
          ? map['estimateDuration'] as int
          : null,
      durationUnitCode: map['durationUnitCode'] != null
          ? map['durationUnitCode'] as String
          : null,
      durationUnitName: map['durationUnitName'] != null
          ? map['durationUnitName'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyPlanServiceModel.fromJson(Map<String, dynamic> source) =>
      DailyPlanServiceModel.fromMap(source);
}

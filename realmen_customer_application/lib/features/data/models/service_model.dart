// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ServiceDataModel extends Equatable {
  int? branchServiceId;
  int? shopServiceId;
  int? branchId;
  int? dailyPlanId;
  String? shopServiceName;
  int? branchServicePrice;
  String? shopServiceThumbnail;
  int? estimateDuration;
  String? durationUnitCode;
  String? durationUnitName;
  String? shopCategoryCode;
  String? shopCategoryName;
  String? serviceDisplays;

  // bổ sung
  String? shopServicePriceS;

  ServiceDataModel({
    this.branchServiceId,
    this.shopServiceId,
    this.branchId,
    this.dailyPlanId,
    this.shopServiceName,
    this.branchServicePrice,
    this.shopServiceThumbnail,
    this.estimateDuration,
    this.durationUnitCode,
    this.durationUnitName,
    this.shopCategoryCode,
    this.shopCategoryName,
    this.serviceDisplays,
    this.shopServicePriceS,
  });

  @override
  List<Object?> get props => [
        branchServiceId,
        shopServiceId,
        branchId,
        dailyPlanId,
        shopServiceName,
        branchServicePrice,
        shopServiceThumbnail,
        estimateDuration,
        durationUnitCode,
        durationUnitName,
        shopCategoryCode,
        shopCategoryName,
        serviceDisplays,
        shopServicePriceS, // Bổ sung thuộc tính này
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'branchServiceId': branchServiceId,
      'shopServiceId': shopServiceId,
      'branchId': branchId,
      'dailyPlanId': dailyPlanId,
      'shopServiceName': shopServiceName,
      'branchServicePrice': branchServicePrice,
      'shopServiceThumbnail': shopServiceThumbnail,
      'estimateDuration': estimateDuration,
      'durationUnitCode': durationUnitCode,
      'durationUnitName': durationUnitName,
      'shopCategoryCode': shopCategoryCode,
      'shopCategoryName': shopCategoryName,
      'serviceDisplays': serviceDisplays,
    };
  }

  factory ServiceDataModel.fromMap(Map<String, dynamic> map) {
    return ServiceDataModel(
      branchServiceId:
          map['branchServiceId'] != null ? map['branchServiceId'] as int : null,
      shopServiceId:
          map['shopServiceId'] != null ? map['shopServiceId'] as int : null,
      branchId: map['branchId'] != null ? map['branchId'] as int : null,
      dailyPlanId:
          map['dailyPlanId'] != null ? map['dailyPlanId'] as int : null,
      shopServiceName: map['shopServiceName'] != null
          ? map['shopServiceName'] as String
          : null,
      branchServicePrice: map['branchServicePrice'] != null
          ? map['branchServicePrice'] as int
          : null,
      shopServiceThumbnail: map['shopServiceThumbnail'] != null
          ? map['shopServiceThumbnail'] as String
          : null,
      estimateDuration: map['estimateDuration'] != null
          ? map['estimateDuration'] as int
          : null,
      durationUnitCode: map['durationUnitCode'] != null
          ? map['durationUnitCode'] as String
          : null,
      durationUnitName: map['durationUnitName'] != null
          ? map['durationUnitName'] as String
          : null,
      shopCategoryCode: map['shopCategoryCode'] != null
          ? map['shopCategoryCode'] as String
          : null,
      shopCategoryName: map['shopCategoryName'] != null
          ? map['shopCategoryName'] as String
          : null,
      serviceDisplays: map['serviceDisplays'] != null
          ? map['serviceDisplays'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceDataModel.fromJson(Map<String, dynamic> source) =>
      ServiceDataModel.fromMap(source);
}

class ServiceCategoryModel {
  String? title;
  List<ServiceDataModel>? services;
  ServiceCategoryModel({
    this.title,
    this.services,
  });
}

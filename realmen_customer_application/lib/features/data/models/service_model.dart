// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServiceDataModel {
  int? shopServiceId;
  int? branchId;
  String? shopServiceName;
  int? shopServicePrice;
  String? shopServiceThumbnail;
  int? shopCategoryId;
  String? shopCategoryCode;
  String? shopCategoryName;
  String? serviceDisplays;

  // bổ sung
  String? shopServicePriceS;

  ServiceDataModel(
      {this.shopServiceId,
      this.branchId,
      this.shopServiceName,
      this.shopServicePrice,
      this.shopServiceThumbnail,
      this.shopCategoryId,
      this.shopCategoryCode,
      this.shopCategoryName,
      this.serviceDisplays,
      this.shopServicePriceS});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopServiceId': shopServiceId,
      'branchId': branchId,
      'shopServiceName': shopServiceName,
      'shopServicePrice': shopServicePrice,
      'shopServiceThumbnail': shopServiceThumbnail,
      'shopCategoryId': shopCategoryId,
      'shopCategoryCode': shopCategoryCode,
      'shopCategoryName': shopCategoryName,
      'serviceDisplays': serviceDisplays,
    };
  }

  factory ServiceDataModel.fromMap(Map<String, dynamic> map) {
    return ServiceDataModel(
      shopServiceId:
          map['shopServiceId'] != null ? map['shopServiceId'] as int : 0,
      branchId: map['branchId'] as dynamic,
      shopServiceName: map['shopServiceName'] != null
          ? map['shopServiceName'] as String
          : "",
      shopServicePrice:
          map['shopServicePrice'] != null ? map['shopServicePrice'] as int : 0,
      shopServiceThumbnail: map['shopServiceThumbnail'] != null
          ? map['shopServiceThumbnail'] as String
          : null,
      shopCategoryId:
          map['shopCategoryId'] != null ? map['shopCategoryId'] as int : null,
      shopCategoryCode: map['shopCategoryCode'] != null
          ? map['shopCategoryCode'] as String
          : null,
      shopCategoryName: map['shopCategoryName'] != null
          ? map['shopCategoryName'] as String
          : "",
      serviceDisplays: map['serviceDisplays'] != null
          ? map['serviceDisplays'] as String
          : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceDataModel.fromJson(Map<String, dynamic> source) =>
      ServiceDataModel.fromMap(source);

  @override
  String toString() {
    return 'ServiceDataModel(shopServiceId: $shopServiceId, branchId: $branchId, shopServiceName: $shopServiceName, shopServicePrice: $shopServicePrice, shopServiceThumbnail: $shopServiceThumbnail, shopCategoryId: $shopCategoryId, shopCategoryCode: $shopCategoryCode, shopCategoryName: $shopCategoryName, serviceDisplays: $serviceDisplays)';
  }
}

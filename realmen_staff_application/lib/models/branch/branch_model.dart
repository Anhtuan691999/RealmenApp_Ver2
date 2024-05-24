// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:realmen_staff_application/models/account/account_info_model.dart';

class BranchesModel {
  List<BranchesValuesModel>? values;
  BranchesModel({
    this.values,
  });

  factory BranchesModel.fromJson(Map<String, dynamic> json) {
    return BranchesModel(
      values: json['values'] != null && json['values'] != []
          ? (json['values'] as List)
              .map((e) => BranchesValuesModel.fromJson(e))
              .toList()
          : null,
    );
  }
}

class BranchesValuesModel {
  String? city;
  int? branch;
  List<BranchModel>? branchList;
  BranchesValuesModel({
    this.city,
    this.branch,
    this.branchList,
  });
  factory BranchesValuesModel.fromJson(Map<String, dynamic> json) {
    return BranchesValuesModel(
      city: json['city'],
      branch: json['branch'],
      branchList: json['branchList'] != null && json['branchList'] != []
          ? (json['branchList'] as List)
              .map((e) => BranchModel.fromJson(e))
              .toList()
          : null,
    );
  }
}

class BranchModel {
  int? branchId;
  int? shopOwnerId;
  String? branchName;
  String? thumbnailUrl;
  String? phone;
  String? address;
  String? status;
  int? numberStaffs;
  String? open;
  String? close;
  List<BranchDisplayListUrl>? branchDisplayList;
  List<BranchServiceModel>? branchServiceList;
  List<AccountInfoModel>? accountStaffList;
  String? distanceKilometer;
  double? lat;
  double? lng;
  bool? distance;

  BranchModel({
    this.branchId,
    this.shopOwnerId,
    this.branchName,
    this.thumbnailUrl,
    this.phone,
    this.address,
    this.status,
    this.numberStaffs,
    this.open,
    this.close,
    this.branchDisplayList,
    this.branchServiceList,
    this.accountStaffList,
    this.distanceKilometer,
    this.lat,
    this.lng,
    this.distance,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      branchId: json['branchId'],
      shopOwnerId: json['shopOwnerId'],
      branchName: json['branchName'],
      thumbnailUrl: json['thumbnailUrl'],
      phone: json['phone'],
      address: json['address'],
      status: json['status'],
      numberStaffs: json['numberStaffs'],
      open: json['open'],
      close: json['close'],
      branchDisplayList: json['branchDisplayList'] != null
          ? (json['branchDisplayList'] as List)
              .map((e) => BranchDisplayListUrl.fromJson(e))
              .toList()
          : null,
      branchServiceList: json['branchServiceList'] != null
          ? (json['branchServiceList'] as List)
              .map((e) => BranchServiceModel.fromJson(e))
              .toList()
          : null,
      accountStaffList: json['accountStaffList'] != null
          ? (json['accountStaffList'] as List)
              .map((e) => AccountInfoModel.fromJson(e))
              .toList()
          : null,
      distanceKilometer: json['distanceKilometer'],
      lat: json['lat'],
      lng: json['lng'],
      distance: json['distance'],
    );
  }
}

class BranchServiceModel {
  int? serviceId;
  int? branchId;
  String? serviceName;
  String? branchName;
  String? thumbnailUrl;
  int? price;
  int? branchServicePrice;

  BranchServiceModel({
    this.serviceId,
    this.branchId,
    this.serviceName,
    this.branchName,
    this.thumbnailUrl,
    this.price,
    this.branchServicePrice,
  });

  factory BranchServiceModel.fromJson(Map<String, dynamic> json) =>
      BranchServiceModel(
          serviceId: json["serviceId"],
          branchId: json["branchId"],
          serviceName: json["serviceName"],
          branchName: json["branchName"],
          thumbnailUrl: json["thumbnailUrl"],
          price: json["price"],
          branchServicePrice: json["branchServicePrice"]);
}

class BranchDisplayListUrl {
  String? url;
  int? branchDisplayId;
  int? branchId;

  BranchDisplayListUrl({
    this.url,
    this.branchDisplayId,
    this.branchId,
  });

  factory BranchDisplayListUrl.fromJson(Map<String, dynamic> json) {
    return BranchDisplayListUrl(
      url: json['url'],
      branchDisplayId: json['branchDisplayId'],
      branchId: json['branchId'],
    );
  }
}

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BranchDataModel {
  int? branchId;
  String? branchName;
  String? branchThumbnail;
  String? branchStreet;
  String? branchWard;
  String? branchDistrict;
  String? branchProvince;
  double? latitude;
  double? longitude;
  String? open;
  String? close;
  DistanceInKm? distanceInKm;
  String? branchStatusCode;
  String? branchStatusName;

  //Thuộc tính bổ sung cho logic nghiệp vụ
  String? distanceKm;

  BranchDataModel(
      {this.branchId,
      this.branchName,
      this.branchThumbnail,
      this.branchStreet,
      this.branchWard,
      this.branchDistrict,
      this.branchProvince,
      this.latitude,
      this.longitude,
      this.open,
      this.close,
      this.distanceInKm,
      this.branchStatusCode,
      this.branchStatusName,
      this.distanceKm});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'branchId': branchId,
      'branchName': branchName,
      'branchThumbnail': branchThumbnail,
      'branchStreet': branchStreet,
      'branchWard': branchWard,
      'branchDistrict': branchDistrict,
      'branchProvince': branchProvince,
      'latitude': latitude,
      'longitude': longitude,
      'open': open,
      'close': close,
      'distanceInKm': distanceInKm?.toMap(),
      'branchStatusCode': branchStatusCode,
      'branchStatusName': branchStatusName,
    };
  }

  factory BranchDataModel.fromMap(Map<String, dynamic> map) {
    return BranchDataModel(
      branchId: map['branchId'] != null ? map['branchId'] as int : null,
      branchName:
          map['branchName'] != null ? map['branchName'] as String : null,
      branchThumbnail: map['branchThumbnail'] != null
          ? map['branchThumbnail'] as String
          : null,
      branchStreet:
          map['branchStreet'] != null ? map['branchStreet'] as String : null,
      branchWard:
          map['branchWard'] != null ? map['branchWard'] as String : null,
      branchDistrict: map['branchDistrict'] != null
          ? map['branchDistrict'] as String
          : null,
      branchProvince: map['branchProvince'] != null
          ? map['branchProvince'] as String
          : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      open: map['open'] != null ? map['open'] as String : null,
      close: map['close'] != null ? map['close'] as String : null,
      distanceInKm: map['distanceInKm'] != null
          ? DistanceInKm.fromMap(map['distanceInKm'] as Map<String, dynamic>)
          : null,
      branchStatusCode: map['branchStatusCode'] != null
          ? map['branchStatusCode'] as String
          : null,
      branchStatusName: map['branchStatusName'] != null
          ? map['branchStatusName'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchDataModel.fromJson(Map<String, dynamic> source) =>
      BranchDataModel.fromMap(source);
}

class DistanceInKm {
  double? distance;
  DistanceInKm({
    this.distance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'distance': distance,
    };
  }

  factory DistanceInKm.fromMap(Map<String, dynamic> map) {
    return DistanceInKm(
      distance: map['distance'] != null ? map['distance'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DistanceInKm.fromJson(String source) =>
      DistanceInKm.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BranchProvince {
  String? province;
  BranchDataModel? branches;
  int? total;
  BranchProvince({this.province, this.branches, this.total});

  BranchProvince copyWith({
    String? province,
    BranchDataModel? branches,
    int? total,
  }) {
    return BranchProvince(
      province: province ?? this.province,
      branches: branches ?? this.branches,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'province': province,
      'branches': branches?.toMap(),
      'total': total,
    };
  }

  factory BranchProvince.fromMap(Map<String, dynamic> map) {
    return BranchProvince(
      province: map['province'] != null ? map['province'] as String : "",
      branches: map['branches'] != null
          ? map['branches']
              .map((branch) =>
                  BranchDataModel.fromMap(branch as Map<String, dynamic>))
              .toList()
          : [],
      total: map['total'] != null ? map['total'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchProvince.fromJson(Map<String, dynamic> source) =>
      BranchProvince.fromMap(source);
}

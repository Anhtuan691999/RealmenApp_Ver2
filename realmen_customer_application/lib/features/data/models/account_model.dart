import 'dart:convert';
import 'package:equatable/equatable.dart';

class AccountModel extends Equatable {
  int? accountId;
  int? branchId;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? roleCode;
  String? roleName;
  String? professionalTypeCode;
  String? professionalTypeName;
  String? thumbnail;
  String? dob;
  String? genderCode;
  String? genderName;
  String? accountStatusCode;
  String? accountStatusName;

  AccountModel({
    this.accountId,
    this.branchId,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.roleCode,
    this.roleName,
    this.professionalTypeCode,
    this.professionalTypeName,
    this.thumbnail,
    this.dob,
    this.genderCode,
    this.genderName,
    this.accountStatusCode,
    this.accountStatusName,
  });

  // Sử dụng Equatable
  @override
  List<Object?> get props => [
        accountId,
        branchId,
        firstName,
        lastName,
        phone,
        address,
        roleCode,
        roleName,
        professionalTypeCode,
        professionalTypeName,
        thumbnail,
        dob,
        genderCode,
        genderName,
        accountStatusCode,
        accountStatusName,
      ];

  // Chuyển đối tượng thành Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountId': accountId,
      'branchId': branchId,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'roleCode': roleCode,
      'roleName': roleName,
      'professionalTypeCode': professionalTypeCode,
      'professionalTypeName': professionalTypeName,
      'thumbnail': thumbnail,
      'dob': dob,
      'genderCode': genderCode,
      'genderName': genderName,
      'accountStatusCode': accountStatusCode,
      'accountStatusName': accountStatusName,
    };
  }

  // Tạo đối tượng từ Map
  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountId: map['accountId'] != null ? map['accountId'] as int : null,
      branchId: map['branchId'] != null ? map['branchId'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : "",
      lastName: map['lastName'] != null ? map['lastName'] as String : "",
      phone: map['phone'] != null ? map['phone'] as String : "",
      address: map['address'] != null ? map['address'] as String : null,
      roleCode: map['roleCode'] != null ? map['roleCode'] as String : "",
      roleName: map['roleName'] != null ? map['roleName'] as String : "",
      professionalTypeCode: map['professionalTypeCode'] != null
          ? map['professionalTypeCode'] as String
          : "",
      professionalTypeName: map['professionalTypeName'] != null
          ? map['professionalTypeName'] as String
          : "",
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : "",
      dob: map['dob'] != null ? map['dob'] as String : null,
      genderCode: map['genderCode'] != null ? map['genderCode'] as String : "",
      genderName:
          map['genderName'] != null ? map['genderName'] as String : null,
      accountStatusCode: map['accountStatusCode'] != null
          ? map['accountStatusCode'] as String
          : "",
      accountStatusName: map['accountStatusName'] != null
          ? map['accountStatusName'] as String
          : "",
    );
  }

  // Chuyển đối tượng thành chuỗi JSON
  String toJson() => json.encode(toMap());

  // Tạo đối tượng từ chuỗi JSON
  factory AccountModel.fromJson(Map<String, dynamic> source) =>
      AccountModel.fromMap(source);
}

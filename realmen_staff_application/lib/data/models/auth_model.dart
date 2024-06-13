// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthenticationModel extends Equatable {
  String? accessToken;
  int? accountId;
  int? branchId;
  String? staffCode;
  String? phone;
  String? firstName;
  String? lastName;
  bool? isAccountActive;
  String? role;

  AuthenticationModel({
    this.accessToken,
    this.accountId,
    this.branchId,
    this.staffCode,
    this.phone,
    this.firstName,
    this.lastName,
    this.isAccountActive,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'accountId': accountId,
      'branchId': branchId,
      'staffCode': staffCode,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'isAccountActive': isAccountActive,
      'role': role,
    };
  }

  factory AuthenticationModel.fromMap(Map<String, dynamic> map) {
    return AuthenticationModel(
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      accountId: map['accountId'] != null ? map['accountId'] as int : null,
      branchId: map['branchId'] != null ? map['branchId'] as int : null,
      staffCode: map['staffCode'] != null ? map['staffCode'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      isAccountActive: map['isAccountActive'] != null
          ? map['isAccountActive'] as bool
          : null,
      role: map['role'] != null ? map['role'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationModel.fromJson(String source) =>
      AuthenticationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [accessToken];
}

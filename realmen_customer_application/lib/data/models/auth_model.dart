// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthenticationModel extends Equatable {
  int? accountId;
  String? lastName;
  String? firstName;
  String? accessToken;
  String? issueAt;
  String? roleCode;
  String? roleName;
  AuthenticationModel({
    this.accountId,
    this.lastName,
    this.firstName,
    this.accessToken,
    this.issueAt,
    this.roleCode,
    this.roleName,
  });

  @override
  List<Object?> get props => [accessToken];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountId': accountId,
      'lastName': lastName,
      'firstName': firstName,
      'accessToken': accessToken,
      'issueAt': issueAt,
      'roleCode': roleCode,
      'roleName': roleName,
    };
  }

  factory AuthenticationModel.fromMap(Map<String, dynamic> map) {
    return AuthenticationModel(
      accountId: map['accountId'] != null ? map['accountId'] as int : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      issueAt: map['issueAt'] != null ? map['issueAt'] as String : null,
      roleCode: map['roleCode'] != null ? map['roleCode'] as String : null,
      roleName: map['roleName'] != null ? map['roleName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationModel.fromJson(String source) =>
      AuthenticationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

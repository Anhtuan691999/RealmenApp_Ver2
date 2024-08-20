// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccountModel {
  String? firstName;
  String? lastName;
  String? phone;
  String? thumbnail;
  String? dob;
  String? genderCode;
  String? genderName;
  AccountModel({
    this.firstName,
    this.lastName,
    this.phone,
    this.thumbnail,
    this.dob,
    this.genderCode,
    this.genderName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'thumbnail': thumbnail,
      'dob': dob,
      'genderCode': genderCode,
      'genderName': genderName,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      firstName: map['firstName'] != null ? map['firstName'] as String : "",
      lastName: map['lastName'] != null ? map['lastName'] as String : "",
      phone: map['phone'] != null ? map['phone'] as String : "",
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : "",
      dob: map['dob'] != null ? map['dob'] as String : null,
      genderCode: map['genderCode'] != null ? map['genderCode'] as String : "",
      genderName: map['genderName'] != null ? map['genderName'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

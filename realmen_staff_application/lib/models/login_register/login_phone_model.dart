import 'dart:core';

class LoginPhoneModel {
  LoginPhoneModel({this.value});

  String? value;
  // LoginPhoneResponseModel? loginPhoneResponse;

  factory LoginPhoneModel.fromJson(Map<String, dynamic> json) =>
      LoginPhoneModel(value: json["value"].toString());

  Map<String, dynamic> toJson() => {"value": value};
}

// class LoginPhoneResponseModel {
//   LoginPhoneResponseModel({this.otpId, this.phoneAttemp});

//   int? otpId;
//   String? phoneAttemp;

//   factory LoginPhoneResponseModel.fromJson(Map<String, dynamic> json) =>
//       LoginPhoneResponseModel(
//           otpId: json["otpId"], phoneAttemp: json["phoneAttemp"]);
// }

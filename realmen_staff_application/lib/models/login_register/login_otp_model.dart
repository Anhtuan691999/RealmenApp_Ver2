import 'dart:core';

class LoginOtpModel {
  LoginOtpModel({this.phone, this.passCode, this.loginOtpResponseModel});

  String? phone;
  String? passCode;
  LoginOtpResponseModel? loginOtpResponseModel;

  // Future<String?> getPhone() async {
  //   this.phone = await SharedPreferencesService.getPhone();
  //   return this.phone;
  // }

  factory LoginOtpModel.fromJson(Map<String, dynamic> json) => LoginOtpModel(
      loginOtpResponseModel: LoginOtpResponseModel.fromJson(json["value"]));

  Map<String, dynamic> toJson() => {"phone": phone, "passCode": passCode};
}

class LoginOtpResponseModel {
  LoginOtpResponseModel({
    this.accountId,
    this.staffId,
    this.branchId,
    this.phone,
    this.jwtToken,
    this.role,
    this.expTime,
    this.customerId,
  });

  int? accountId;
  int? customerId;
  int? staffId;
  int? branchId;
  String? phone;
  String? jwtToken;
  String? role;
  String? expTime;

  factory LoginOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginOtpResponseModel(
        accountId: json["accountId"],
        staffId: json["staffId"],
        branchId: json["branchId"],
        phone: json["phone"],
        jwtToken: json["jwtToken"],
        role: json["role"],
        expTime: json["expTime"],
        customerId: json["customerId"],
      );
}

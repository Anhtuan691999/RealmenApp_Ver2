class RegisterCustomerModel {
  RegisterCustomerModel(
      {this.passCode,
      this.thumbnailUrl,
      this.firstName,
      this.lastName,
      this.phone,
      this.address,
      this.gender,
      this.status,
      this.dob});

  String? passCode;
  String? thumbnailUrl;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? gender;
  String? status;
  String? dob;

  // factory RegisterCustomerModel.fromJson(Map<String, dynamic> json) =>
  //     RegisterCustomerModel(
  //       firstName: json["firstName"],
  //       lastName: json["lastName"],
  //       phone: json["phone"],
  //       address: json["address"],
  //       gender: json["gender"],
  //       dob: json["dob"],
  //     );

  Map<String, dynamic> toJson() => {
        "thumbnailUrl": thumbnailUrl,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "address": address,
        "gender": gender,
        "status": status,
        "dob": dob
      };
}

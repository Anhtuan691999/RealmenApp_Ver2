// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServerExceptionModel {
  String? errorCode;
  String? errorMsg;
  int? statusCode;
  String? status;
  String? issueAt;

  ServerExceptionModel(
      {this.errorCode,
      this.errorMsg,
      this.statusCode,
      this.status,
      this.issueAt});

  factory ServerExceptionModel.fromMap(Map<String, dynamic> map) {
    return ServerExceptionModel(
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMsg: map['errorMsg'] != null ? map['errorMsg'] as String : null,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      issueAt: map['issueAt'] != null ? map['issueAt'] as String : null,
    );
  }

  factory ServerExceptionModel.fromJson(String source) =>
      ServerExceptionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

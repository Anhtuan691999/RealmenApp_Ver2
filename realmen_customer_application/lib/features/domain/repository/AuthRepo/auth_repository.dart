import 'dart:convert';

import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/core/network/api/api_endpoints.dart';
import 'package:realmen_customer_application/core/network/exceptions/exception_handlers.dart';
import 'package:http/http.dart' as http;

import '../../../../core/network/exceptions/app_exceptions.dart';

abstract class IAuthRepository {
  Future<Map<String, dynamic>> createOtp(String phone);

  Future<Map<String, dynamic>> login(String phone, String otp);

  Future<Map<String, dynamic>> register(AccountModel accountModel);
}

class AuthRepository extends ApiEndpoints implements IAuthRepository {
  @override
  Future<Map<String, dynamic>> createOtp(String phone) async {
    try {
      Uri uri = Uri.parse("$AuthenticationUrl/send-otp?phone=$phone");
      final client = http.Client();
      final response = await client.get(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ).timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      if (e is NotFoundException) {
        return {
          "status": false,
          "message": e.message.toString(),
          "statusCode": 404
        };
      } else {
        return ExceptionHandlers().getExceptionString(e);
      }
    }
  }

  @override
  Future<Map<String, dynamic>> login(String phone, String otp) async {
    try {
      var credentials = {"phone": phone, "otp": otp};
      Uri uri = Uri.parse("$AuthenticationUrl/customer");
      final client = http.Client();
      final response = await client
          .post(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*',
              },
              body: jsonEncode(credentials))
          .timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }

  @override
  Future<Map<String, dynamic>> register(AccountModel accountModel) async {
    try {
      Uri uri = Uri.parse(AccountUrl);
      final client = http.Client();
      final response = await client
          .post(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*',
              },
              body: accountModel.toJson())
          .timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }
}

import 'dart:convert';

import 'package:realmen_staff_application/data/models/account_model.dart';
import 'package:realmen_staff_application/network/api/api_endpoints.dart';
import 'package:realmen_staff_application/network/exceptions/exception_handlers.dart';
import 'package:http/http.dart' as http;

import '../../network/exceptions/app_exceptions.dart';

abstract class IAuthRepository {
  Future<Map<String, dynamic>> login(String phone, String otp);
}

class AuthRepository extends ApiEndpoints implements IAuthRepository {
  @override
  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      var credentials = {"staffCode": phone, "password": password};
      Uri uri = Uri.parse("$authUrl/staff");
      final client = http.Client();
      final response = await client
          .post(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*',
              },
              body: jsonEncode(credentials))
          .timeout(const Duration(seconds: 500));
      return processResponse(response);
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }
}

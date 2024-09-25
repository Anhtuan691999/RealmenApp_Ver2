import 'package:realmen_customer_application/core/network/api/api_endpoints.dart';
import 'package:realmen_customer_application/core/network/exceptions/app_exceptions.dart';
import 'package:realmen_customer_application/core/network/exceptions/exception_handlers.dart';
import 'package:realmen_customer_application/features/data/shared_preferences/auth_pref.dart';
import 'package:http/http.dart' as http;

abstract class IDailyPlanRepository {
  Future<Map<String, dynamic>> getDailyPlan(
      DateTime to, DateTime from, int branchId, int? accountId, int? serviceId);
  Future<Map<String, dynamic>> getDailyPlanById(int dailyPlanId);
  Future<Map<String, dynamic>> getShiftPlan(int dailyPlanAccId);
}

class DailyPlanRepository extends ApiEndpoints implements IDailyPlanRepository {
  @override
  Future<Map<String, dynamic>> getDailyPlan(DateTime to, DateTime from,
      int branchId, int? accountId, int? serviceId) async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse(
          "$DailyPlanUrl?timeRange=${to.toIso8601String()}&timeRange=${from.toIso8601String()}&branchId=$branchId&accountId${accountId != null ? "=$accountId" : ""}&serviceId${serviceId != null ? "=$serviceId" : ""}");
      final client = http.Client();
      final response = await client.get(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $jwtToken'
        },
      ).timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getDailyPlanById(int dailyPlanId) async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse("$DailyPlanUrl/$dailyPlanId");
      final client = http.Client();
      final response = await client.get(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $jwtToken'
        },
      ).timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getShiftPlan(int dailyPlanAccId) async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse("$DailyPlanUrl/account/$dailyPlanAccId");
      final client = http.Client();
      final response = await client.get(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $jwtToken'
        },
      ).timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }
}

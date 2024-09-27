import 'package:realmen_staff_application/data/shared_preferences/auth_pref.dart';
import 'package:realmen_staff_application/network/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:realmen_staff_application/network/exceptions/app_exceptions.dart';
import 'package:realmen_staff_application/network/exceptions/exception_handlers.dart';

abstract class IDailyPlanRepository {
  Future<Map<String, dynamic>> getDailyPlanForStaff(DateTime to, DateTime from);
  Future<Map<String, dynamic>> getDailyPlanById(int dailyPlanId);
}

class DailyPlanRepository extends ApiEndpoints implements IDailyPlanRepository {
  @override
  Future<Map<String, dynamic>> getDailyPlanForStaff(
      DateTime to, DateTime from) async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse(
          "$DailyPlanUrl/staff?timeRange=${to.toIso8601String()}&timeRange=${from.toIso8601String()}");
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
}

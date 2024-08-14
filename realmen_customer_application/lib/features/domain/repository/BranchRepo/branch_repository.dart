import 'package:realmen_customer_application/features/data/shared_preferences/auth_pref.dart';
import 'package:realmen_customer_application/core/network/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/core/network/exceptions/app_exceptions.dart';
import 'package:realmen_customer_application/core/network/exceptions/exception_handlers.dart';

abstract class IBranchRepository {
  Future<Map<String, dynamic>> getBranchForHome();
  Future<Map<String, dynamic>> getBranchByProvince();
}

class BranchRepository extends ApiEndpoints implements IBranchRepository {
  @override
  Future<Map<String, dynamic>> getBranchForHome() async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse(
          "$BranchUrl?search&latitude=16.01620225221449&longitude=108.20495660759316&branchStatusCodes=active&current&pageSize");
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
  Future<Map<String, dynamic>> getBranchByProvince() async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse("$BranchUrl/group-by-province");
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

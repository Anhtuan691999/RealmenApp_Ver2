import 'package:realmen_customer_application/features/data/shared_preferences/auth_pref.dart';
import 'package:realmen_customer_application/core/network/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/core/network/exceptions/app_exceptions.dart';
import 'package:realmen_customer_application/core/network/exceptions/exception_handlers.dart';

abstract class IBranchRepository {
  Future<Map<String, dynamic>> getBranch(String? search, int? currentPage);
  Future<Map<String, dynamic>> getBranchByProvince();
}

class BranchRepository extends ApiEndpoints implements IBranchRepository {
  @override
  Future<Map<String, dynamic>> getBranch(
      String? search, int? currentPage) async {
    double lat = 0;
    double lng = 0;
    try {
      final String jwtToken = AuthPref.getToken().toString();
      final positionLongLat = await AuthPref.getLongLat();
      lat = positionLongLat['lat'] as double;
      lng = positionLongLat['lng'] as double;

      Uri uri = Uri.parse(
          "$BranchUrl?search${search != null ? '=$search' : ''}&latitude=$lat&longitude=$lng&branchStatusCodes=ACTIVE&serviceIds=&current${currentPage == null ? "" : "=$currentPage"}&pageSize");
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

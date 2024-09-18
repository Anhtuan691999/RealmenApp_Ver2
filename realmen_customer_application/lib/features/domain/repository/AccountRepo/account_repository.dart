import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/core/network/api/api_endpoints.dart';
import 'package:realmen_customer_application/core/network/exceptions/app_exceptions.dart';
import 'package:realmen_customer_application/core/network/exceptions/exception_handlers.dart';
import 'package:realmen_customer_application/features/data/shared_preferences/auth_pref.dart';

abstract class IAccountRepository {
  Future<Map<String, dynamic>> getAccountList(
      int? branchId, String roles, int? current);
}

class AccountRepository extends ApiEndpoints implements IAccountRepository {
  @override
  Future<Map<String, dynamic>> getAccountList(
      int? branchId, String roles, int? current) async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse(
          "$AccountUrl?search=&branchId=${branchId ?? ''}&roles=$roles&accountStatusCodes=ACTIVE&current${current == null ? '' : '=$current'}&pageSize");
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

import 'package:realmen_customer_application/features/data/shared_preferences/auth_pref.dart';
import 'package:realmen_customer_application/core/network/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/core/network/exceptions/app_exceptions.dart';
import 'package:realmen_customer_application/core/network/exceptions/exception_handlers.dart';

abstract class IServiceRepository {
  Future<Map<String, dynamic>> getAllServices(int? branchId);
  Future<Map<String, dynamic>> getServiceDetail(int serviceId);
}

class ServiceRepository extends ApiEndpoints implements IServiceRepository {
  @override
  Future<Map<String, dynamic>> getAllServices(int? branchId) async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse(
          "$ServiceUrl?search&branchId=${branchId ?? ''}&shopCategoryId&shopServicePriceRange&assignmentTypeCode&current&pageSize");
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
  Future<Map<String, dynamic>> getServiceDetail(int serviceId) async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse("$ServiceUrl/$serviceId");
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

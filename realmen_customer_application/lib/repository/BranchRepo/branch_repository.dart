import 'package:realmen_customer_application/network/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/network/exceptions/app_exceptions.dart';
import 'package:realmen_customer_application/network/exceptions/exception_handlers.dart';

abstract class IBranchRepository {
  Future<Map<String, dynamic>> getBranchForHome();
}

class BranchRepository extends ApiEndpoints implements IBranchRepository {
  @override
  Future<Map<String, dynamic>> getBranchForHome() async {
    try {
      Uri uri = Uri.parse(
          "$BranchUrl?search&latitude=16.01620225221449&longitude=108.20495660759316&branchStatusCodes=active&current&pageSize");
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
      return ExceptionHandlers().getExceptionString(e);
    }
  }
}

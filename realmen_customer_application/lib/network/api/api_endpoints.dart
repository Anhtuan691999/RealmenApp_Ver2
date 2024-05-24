import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String domainUrl = "${dotenv.env["DOMAIN"]}";

  //$ Authentication API $//
  final String customerUrl = "$domainUrl/mobile/auth";

  final String createOtpUrl = "$domainUrl/mobile/auth/create-otp";

  //$ Account API $//
  final String accountsUrl = "$domainUrl/mobile/accounts";

  final String accountMeUrl = "$domainUrl/mobile/accounts/me";
}

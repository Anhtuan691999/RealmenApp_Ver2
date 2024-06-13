import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String domainUrl = "${dotenv.env["DOMAIN"]}";

  //$ Authentication API $//
  final String authUrl = "$domainUrl/mobile/auth";

  //$ Account API $//
  final String accountsUrl = "$domainUrl/mobile/accounts";
}

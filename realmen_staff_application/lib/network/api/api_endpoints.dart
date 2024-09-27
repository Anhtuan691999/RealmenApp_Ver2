import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String domainUrl = "${dotenv.env["DOMAIN"]}";

  //$ Authentication API $//
  final String appAuthenticationControllerUrl = "$domainUrl/web/auth";

  //$ Account API $//
  final String appAccountControllerUrl = "$domainUrl/mobile/accounts";

  //$ Daily Plan API $//
  final String DailyPlanUrl = "$domainUrl/mobile/daily-plan";
}

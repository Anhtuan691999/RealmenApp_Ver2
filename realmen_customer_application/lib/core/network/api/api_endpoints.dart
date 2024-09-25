import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String domainUrl = "${dotenv.env["DOMAIN"]}";

  //$ Authentication API $//
  final String AuthenticationUrl = "$domainUrl/mobile/auth";

  //$ Account API $//
  final String AccountUrl = "$domainUrl/mobile/accounts";

  //$ Branch API $//
  final String BranchUrl = "$domainUrl/mobile/branch";

  //$ Service API $//
  final String ServiceUrl = "$domainUrl/mobile/shop-service";

  //$ Daily Plan API $//
  final String DailyPlanUrl = "$domainUrl/mobile/daily-plan";

  //$ Booking API $//
  final String BookingUrl = "$domainUrl/mobile/booking";
}

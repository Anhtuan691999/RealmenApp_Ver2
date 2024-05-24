import 'package:flutter_dotenv/flutter_dotenv.dart';

// API URL
// OTP API
final loginPhoneUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["LOGIN_PHONE"]}";
final loginOtpUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["LOGIN_OTP"]}";

//  ACCOUNT API
final registerUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["REGISTER_CUSTOMER"]}";
final accountInfoUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_ACCOUNT"]}";

//  BRANCH API
final getBranchesUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_BRANCHES"]}";
final getBranchUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_BRANCH"]}";
final getBranchesByCityUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_BRANCHES_CITY"]}";

// Autocomplete
final autoCompleteUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["AUTOCOMPLETE_SEARCH"]}";

// common variable
final connectionTimeOut = int.parse(dotenv.env["CONNECTION_TIMEOUT"]!);
final customer = "${dotenv.env["CUSTOMER"]}";
final staff = "${dotenv.env["STAFF"]}";

// Schedule API
final schedulesListUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["POST_SCHEDULE_LIST"]}";
final scheduleListUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_SCHEDULE_LIST"]}";

// Booking API
final bookingUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["BOOKING"]}";

// Booking Service API
final getBookingServiceAPI =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["SERVICE_BOOKING"]}";
final confirmBookingUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["CONFIRM_BOOKING"]}";
final startBookingUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["START_BOOKING"]}";
final finishBookingUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["FINISH_BOOKING"]}";

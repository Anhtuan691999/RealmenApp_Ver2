import 'package:realmen_customer_application/core/network/api/api_endpoints.dart';
import 'package:realmen_customer_application/core/network/exceptions/app_exceptions.dart';
import 'package:realmen_customer_application/core/network/exceptions/exception_handlers.dart';
import 'package:realmen_customer_application/features/data/models/booking_model.dart';
import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/features/data/shared_preferences/auth_pref.dart';

abstract class IBookingRepository {
  Future<Map<String, dynamic>> submitBooking(BookingModel bookingModel);
}

class BookingRepository extends ApiEndpoints implements IBookingRepository {
  @override
  Future<Map<String, dynamic>> submitBooking(BookingModel bookingModel) async {
    try {
      final String jwtToken = AuthPref.getToken().toString();

      Uri uri = Uri.parse(BookingUrl);
      final client = http.Client();
      final response = await client
          .post(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*',
                'Authorization': 'Bearer $jwtToken'
              },
              body: bookingModel.toJson())
          .timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      if (e is NotFoundException) {
        return {
          "status": false,
          "message": e.message.toString(),
          "statusCode": 404
        };
      } else {
        return ExceptionHandlers().getExceptionString(e);
      }
    }
  }
}

import 'dart:async';
import 'dart:io';

import 'package:realmen_customer_application/core/network/exceptions/app_exceptions.dart';

class ExceptionHandlers {
  getExceptionString(error) {
    if (error is SocketException) {
      return {"status": false, "message": 'No internet connection.'};
    } else if (error is HttpException) {
      return {"status": false, "message": 'HTTP error occured.'};
    } else if (error is FormatException) {
      return {"status": false, "message": 'Invalid data format'};
    } else if (error is TimeoutException) {
      return {"status": false, "message": 'Request timedout.'};
    } else if (error is BadRequestException) {
      return {"status": false, "message": error.message.toString()};
    } else if (error is UnAuthorizedException) {
      return {"status": false, "message": error.message.toString()};
    } else if (error is NotFoundException) {
      return {"status": false, "message": error.message.toString()};
    } else if (error is FetchDataException) {
      return {"status": false, "message": error.message.toString()};
    } else {
      return {"status": false, "message": error.message.toString()};
    }
  }
}

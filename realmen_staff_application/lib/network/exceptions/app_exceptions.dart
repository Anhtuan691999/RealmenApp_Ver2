import 'dart:convert';

import 'package:http/http.dart' as http;

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process the request', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responding', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'Unauthorized request', url);
}

class NotFoundException extends AppException {
  NotFoundException([String? message, String? url])
      : super(message, 'Page not found', url);
}

dynamic processResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson =
          (response.body.isNotEmpty) ? jsonDecode(response.body) : "";
      return {"body": responseJson, "status": true};
    case 201:
      var responseJson = jsonDecode(response.body);
      return {"body": responseJson, "status": true};
    case 400: //Bad request
      throw BadRequestException(jsonDecode(response.body)['errorMsg']);
    case 401: //Unauthorized
      throw UnAuthorizedException(jsonDecode(response.body)['errorMsg']);
    case 403: //Forbidden
      throw UnAuthorizedException(jsonDecode(response.body)['errorMsg']);
    case 404: //Resource Not Found
      throw NotFoundException(jsonDecode(response.body)['errorMsg']);
    case 500: //Internal Server Error
    default:
      throw FetchDataException('Something went wrong! ${response.statusCode}');
  }
}

// ignore_for_file: unused_catch_clause

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:realmen_staff_application/global_variable.dart';
import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/models/exception/exception_model.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';

abstract class IBookingService {
  Future<dynamic> getBooking(int accountId, int current, int pageRequest);
  Future<dynamic> getBookingById(int bookingId);
  Future<dynamic> getBookingService(int staffId, int current);
  Future<dynamic> putConfirmBooking(int bookingServiceId, int accountId);
  Future<dynamic> putStartService(int bookingServiceId, int accountId);
  Future<dynamic> putFinishService(int bookingServiceId, int accountId,
      BookingResultImgsModel bookingResultImgs);
}

class BookingService implements IBookingService {
  @override
  Future getBooking(int accountId, int current, int pageRequest) async {
    try {
      BookingModel bookingModel = BookingModel();
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse(
          "$bookingUrl?accountId=$accountId&current=$current&pageRequest=$pageRequest");
      final client = http.Client();
      final response = await client.get(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $jwtToken'
        },
      ).timeout(Duration(seconds: connectionTimeOut));
      final statusCode = response.statusCode;
      final responseBody = response.body;
      if (statusCode == 200) {
        bookingModel = BookingModel.fromJson(json.decode(responseBody));
        var totalPages = json.decode(responseBody)['totalPages'] as int;
        current = json.decode(responseBody)['current'] as int;
        return {
          'statusCode': statusCode,
          'data': bookingModel,
          'totalPages': totalPages,
          'current': current,
        };
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
      };
    }
  }

  @override
  Future getBookingById(int bookingId) async {
    try {
      BookingContent bookingModel = BookingContent();
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse("$bookingUrl/$bookingId");
      final client = http.Client();
      final response = await client.get(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $jwtToken'
        },
      ).timeout(Duration(seconds: connectionTimeOut));
      final statusCode = response.statusCode;
      final responseBody = response.body;
      if (statusCode == 200) {
        final value = json.decode(responseBody);
        bookingModel = BookingContent.fromJson(value['value']);
        return {
          'statusCode': statusCode,
          'data': bookingModel,
        };
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
      };
    }
  }

  @override
  Future putConfirmBooking(int bookingServiceId, int accountId) async {
    try {
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse(
          "$confirmBookingUrl/$bookingServiceId/confirm-service?accountId=$accountId");
      final client = http.Client();
      final response = await client.put(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $jwtToken'
        },
      ).timeout(Duration(seconds: connectionTimeOut));
      final statusCode = response.statusCode;
      final responseBody = response.body;
      if (statusCode == 200) {
        return {
          'statusCode': statusCode,
        };
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
      };
    }
  }

  @override
  Future putStartService(int bookingServiceId, int accountId) async {
    try {
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse(
          "$startBookingUrl/$bookingServiceId/start-service?accountId=$accountId");
      final client = http.Client();
      final response = await client.put(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $jwtToken'
        },
      ).timeout(Duration(seconds: connectionTimeOut));
      final statusCode = response.statusCode;
      final responseBody = response.body;
      if (statusCode == 200) {
        return {
          'statusCode': statusCode,
        };
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
      };
    }
  }

  @override
  Future putFinishService(int bookingServiceId, int accountId,
      BookingResultImgsModel bookingResultImgs) async {
    try {
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse(
          "$startBookingUrl/$bookingServiceId/finish-service?accountId=$accountId");
      final client = http.Client();
      final response = await client
          .put(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*',
                'Authorization': 'Bearer $jwtToken'
              },
              body: json.encode(bookingResultImgs.toJson()))
          .timeout(Duration(seconds: connectionTimeOut));
      final statusCode = response.statusCode;
      final responseBody = response.body;
      if (statusCode == 200) {
        return {
          'statusCode': statusCode,
        };
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
      };
    }
  }

  Future getBookingService(int staffId, int current) async {
    try {
      List<BookingServiceModel> bookingModel = [];
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse(
          "$getBookingServiceAPI?staffId=$staffId&sorter=bookingServiceId&current=$current&pageSize=20");
      final client = http.Client();
      final response = await client.get(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $jwtToken'
        },
      ).timeout(Duration(seconds: connectionTimeOut));
      final statusCode = response.statusCode;
      final responseBody = response.body;
      if (statusCode == 200) {
        final content = json.decode(responseBody);
        bookingModel = (content['content'] as List)
            .map((e) => BookingServiceModel.fromJson(e))
            .toList();

        var totalPages = json.decode(responseBody)['totalPages'] as int;
        current = json.decode(responseBody)['current'] as int;
        return {
          'statusCode': statusCode,
          'data': bookingModel,
          'totalPages': totalPages,
          'current': current,
        };
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
      };
    }
  }
}

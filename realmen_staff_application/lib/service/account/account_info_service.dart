// ignore_for_file: unused_catch_clause

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:realmen_staff_application/global_variable.dart';
import 'package:realmen_staff_application/models/account/account_info_model.dart';
import 'package:realmen_staff_application/models/exception/exception_model.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';

abstract class IAccountService {
  Future<dynamic> getAccountInfo();
}

class AccountService extends IAccountService {
  @override
  Future getAccountInfo() async {
    AccountInfoModel accountInfoModel = AccountInfoModel();
    try {
      final int accountId = await SharedPreferencesService.getAccountId();

      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse(
          "$accountInfoUrl/$accountId/$staff?isShowDistance=false&lat=0&lng=0");
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
        accountInfoModel =
            AccountInfoModel.fromJson(json.decode(responseBody)['value']);
        await SharedPreferencesService.saveStaffInfo(accountInfoModel);
        return {
          'statusCode': statusCode,
          'data': accountInfoModel,
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

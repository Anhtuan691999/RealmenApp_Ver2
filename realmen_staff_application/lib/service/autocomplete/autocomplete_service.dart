// ignore_for_file: unused_catch_clause

import 'package:realmen_staff_application/global_variable.dart';
import 'package:realmen_staff_application/models/autocomplete/autocomplete_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:realmen_staff_application/models/exception/exception_model.dart';

abstract class IAutocompleteService {
  Future<dynamic> getAutocomplete(String address);
}

class AutocompleteService extends IAutocompleteService {
  @override
  Future getAutocomplete(String address) async {
    // ignore: unused_local_variable
    AutocompleteModel autocompleteModel = AutocompleteModel();
    if (address == '') {
      return const Iterable<String>.empty();
    } else {
      try {
        Uri uri = Uri.parse(
            "$autoCompleteUrl?address=$address&limit=10&radius=1000&moreCompound=true");
        final client = http.Client();
        final response = await client.get(
          uri,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
        ).timeout(Duration(seconds: connectionTimeOut));
        final statusCode = response.statusCode;
        final responseBody = response.body;
        if (statusCode == 200) {
          final autocompleteModel =
              AutocompleteModel.fromJson(json.decode(responseBody));

          return {
            'statusCode': statusCode,
            'data': autocompleteModel,
          };
        } else if (statusCode == 401) {
          try {
            final exceptionModel =
                ServerExceptionModel.fromJson(json.decode(responseBody));
            return {
              'statusCode': statusCode,
              'error': exceptionModel,
            };
          } catch (e) {
            return {
              'statusCode': statusCode,
              'error': e,
            };
          }
        } else if (statusCode == 403) {
          return {
            'statusCode': statusCode,
            'error': "Forbidden",
          };
        } else if (statusCode == 400) {
          return {
            'statusCode': statusCode,
            'error': "Bad request",
          };
        } else {
          return {
            'statusCode': statusCode,
            'error': 'Failed to fetch data',
          };
        }
      } on TimeoutException catch (e) {
        return {
          'statusCode': 408,
          'error': "Request timeout",
        };
      } on SocketException catch (e) {
        return {
          'statusCode': 500,
          'error': 'Kiểm tra lại kết nối Internet',
        };
      } catch (e) {
        return {
          'statusCode': 500,
          'error': "Kiểm tra lại kết nối Internet",
        };
      }
    }
  }
  // @override
  // Future<Iterable> getAutocomplete(String address) async {
  //   AutocompleteModel autocompleteModel = AutocompleteModel();
  //   if (address == '') {
  //     return const Iterable<String>.empty();
  //   } else {
  //     try {
  //       Uri uri = Uri.parse(
  //           "$autoCompleteUrl?address=$address&limit=10&radius=1000&moreCompound=true");
  //       final client = http.Client();
  //       final response = await client.get(
  //         uri,
  //         headers: {
  //           "Access-Control-Allow-Origin": "*",
  //           'Content-Type': 'application/json',
  //           'Accept': '*/*',
  //         },
  //       ).timeout(Duration(seconds: connectionTimeOut));
  //       final statusCode = response.statusCode;
  //       final responseBody = response.body;
  //       if (statusCode == 200) {
  //         final autocompleteModel =
  //             AutocompleteModel.fromJson(json.decode(responseBody));

  //         List<String> descriptions = autocompleteModel.predictions!
  //             .map((p) => p.description)
  //             .cast<String>()
  //             .toList();

  //         return [
  //           {
  //             'statusCode': statusCode,
  //             'data': descriptions.where((String option) {
  //               return option.contains(address.toLowerCase());
  //             })
  //           }
  //         ];
  //       } else if (statusCode == 401) {
  //         try {
  //           final exceptionModel =
  //               ServerExceptionModel.fromJson(json.decode(responseBody));
  //           return [
  //             {
  //               'statusCode': statusCode,
  //               'error': exceptionModel,
  //             }
  //           ];
  //         } catch (e) {
  //           return [
  //             {
  //               'statusCode': statusCode,
  //               'error': e,
  //             }
  //           ];
  //         }
  //       } else if (statusCode == 403) {
  //         return [
  //           {
  //             'statusCode': statusCode,
  //             'error': "Forbidden",
  //           }
  //         ];
  //       } else if (statusCode == 400) {
  //         return [
  //           {
  //             'statusCode': statusCode,
  //             'error': "Bad request",
  //           }
  //         ];
  //       } else {
  //         return [
  //           {
  //             'statusCode': statusCode,
  //             'error': 'Failed to fetch data',
  //           }
  //         ];
  //       }
  //     } on TimeoutException catch (e) {
  //       return [
  //         {
  //           'statusCode': 408,
  //           'error': "Request timeout",
  //         }
  //       ];
  //     } on SocketException catch (e) {
  //       return [
  //         {
  //           'statusCode': 500,
  //           'error': 'Socket error',
  //         }
  //       ];
  //     } catch (e) {
  //       return [
  //         {
  //           'statusCode': 500,
  //           'error': e,
  //         }
  //       ];
  //     }
  //   }
  // }
}

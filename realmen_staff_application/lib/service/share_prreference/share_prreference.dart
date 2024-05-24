// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:realmen_staff_application/models/account/account_info_model.dart';
import 'package:realmen_staff_application/service/authentication/authenticate_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:realmen_staff_application/models/login_register/login_otp_model.dart';

class SharedPreferencesService {
  static Future<SharedPreferences> initSharedPreferenced() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static Future<void> saveOtpIdPhone(String otpId, String phone) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setStringList("otpIdPhone", [otpId, phone]);
  }

  static Future<Map<String, String>> getOtpPhone() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String>? result = sharedPreferences.getStringList("otpIdPhone");
    if (result != null && result.length >= 2) {
      Map<String, String> resultMap = {"otpId": result[0], "phone": result[1]};
      return resultMap;
    } else {
      throw Exception(
          "Failed to get OTP ID and phone number from SharedPreferences");
    }
  }

  // static Future<String> getPhone() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   List<String> resultList = sharedPreferences.getStringList("otpIdPhone")!;
  //   String result = resultList[1];
  //   return result;
  // }

  static Future<void> savePassCode(String passCode) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("passCode", passCode);
  }

  static Future<String> getPassCode() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString("passCode")!;
    if (result != null) {
      return result;
    } else {
      throw Exception("Failed to get phone number from SharedPreferences");
    }
  }

  static Future<void> savePhone(String phone) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("phone", phone);
  }

  static Future<String> getPhone() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString("phone");
    if (result != null) {
      return result;
    } else {
      throw Exception("Failed to get phone number from SharedPreferences");
    }
  }

  static Future<void> saveAccountInfo(
      LoginOtpResponseModel loginOtpResponseModel) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setStringList("accountInfo", [
      loginOtpResponseModel.phone!,
      loginOtpResponseModel.jwtToken!,
      loginOtpResponseModel.role!,
      loginOtpResponseModel.accountId!.toString(),
      loginOtpResponseModel.staffId?.toString() ?? "",
      loginOtpResponseModel.branchId?.toString() ?? "",
      loginOtpResponseModel.expTime?.toString() ?? "",
    ]);
  }

  static Future<Map<String, String>> getAccountInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String>? result = sharedPreferences.getStringList("accountInfo");

    if (result != null) {
      Map<String, String> resultMap = {
        "phone": result[0],
        "jwtToken": result[1],
        "role": result[2],
        "accountId": result[3],
        "staffId": result[4],
        "branchId": result[5],
        "expTime": result[6],
      };
      return resultMap;
    } else {
      throw Exception("Failed to get accountInfo from SharedPreferences");
    }
  }

  static Future<int> getAccountId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String>? result = sharedPreferences.getStringList("accountInfo");
    if (result != null && result.length >= 6) {
      int accountId = int.parse(result[3]);
      return accountId;
    } else {
      return 0;
    }
  }

  static Future<int> getStaffId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String>? result = sharedPreferences.getStringList("accountInfo");
    if (result != null && result.length >= 6) {
      int staffId = int.parse(result[4]);
      return staffId;
    } else {
      return 0;
    }
  }

  static Future<String> getJwt() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String>? result = sharedPreferences.getStringList("accountInfo");
    if (result != null && result.length >= 2) {
      String jwtToken = result[1];
      return jwtToken;
    } else {
      throw Exception("Failed to get jwtToken from SharedPreferences");
    }
  }

// no api
  // static Future<bool> checkJwtExpired() async {
  //   return false;
  // }

// kiểm tra hết hạn hay chưa / false là chưa còn tiếp tục
  static Future<bool> checkJwtExpired() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<String>? result = sharedPreferences.getStringList("accountInfo");
      if (result != null && result.length >= 2) {
        String jwtToken = result[1];
        var isExpired = _isExpired(jwtToken);
        if (!isExpired) {
          return false;
        } else {
          AuthenticateService authenticateService = AuthenticateService();
          authenticateService.logout();
        }
      } else {
        print("Failed to get jwtToken from SharedPreferences");
        return true;
      }
    } on Exception catch (e) {
      print(e);
      return true;
    }
    return true;

    // Kiểm tra hết hạn
  }

// true là hết hạn
// false là còn hạn
  // ignore: unused_element
  static bool _isExpired(String jwt) {
    final decoded = JwtDecoder.decode(jwt);
    final expiry = decoded['exp'];
    DateTime expiration = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
    final dateNow = DateTime.now();
    return expiration.isBefore(dateNow);
  }

  static Future<bool> getLocationPermission() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    bool? result = sharedPreferences.getBool("locationPermission");
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }

  static Future<Map<String, dynamic>> getLongLat() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    double? lng = sharedPreferences.getDouble("longitude");
    double? lat = sharedPreferences.getDouble("latitude");
    if (lng != null && lat != null) {
      Map<String, dynamic> result = {"lng": lng, "lat": lat};
      return result;
    } else {
      throw Exception("Failed to get phone number from SharedPreferences");
    }
  }

  static Future<void> saveStaffInfo(AccountInfoModel accountInfoModel) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setStringList("staffInfo", [
      // professional
      accountInfoModel.staff?.professional?.toString() ?? "",

      // other
      //
      //
    ]);
  }

  static Future<String> getProfessional() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String>? result = sharedPreferences.getStringList("staffInfo");

    if (result != null) {
      String professional = result[0];
      return professional;
    } else {
      throw Exception("Failed to get account ID from SharedPreferences");
    }
  }
}

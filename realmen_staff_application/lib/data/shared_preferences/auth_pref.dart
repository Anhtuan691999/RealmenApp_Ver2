import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:realmen_staff_application/data/shared_preferences/shared_preferences.dart';
import 'package:realmen_staff_application/presentation/auth/ui/auth_page.dart';

class AuthPref {
  static Future<void> setPhone(String phone) async {
    await SharedPreferencesHelper.preferences.setString("phone", phone);
  }

  static String getPhone() {
    return SharedPreferencesHelper.preferences.getString("phone") ?? "";
  }

  static Future<void> setToken(String token) async {
    await SharedPreferencesHelper.preferences.setString("token", token);
  }

  static String getToken() {
    return SharedPreferencesHelper.preferences.getString("token") ?? "";
  }

  static Future<void> setRole(String role) async {
    await SharedPreferencesHelper.preferences.setString("role", role);
  }

  static String getRole() {
    return SharedPreferencesHelper.preferences.getString("role") ?? "";
  }

  static Future<void> setAccountId(String accountId) async {
    await SharedPreferencesHelper.preferences.setString("accountId", accountId);
  }

  static String getAccountId() {
    return SharedPreferencesHelper.preferences.getString("accountId") ?? "";
  }

  static Future<void> logout() async {
    await SharedPreferencesHelper.preferences.clear();
    Get.offAllNamed(AuthenticationPage.AuthenticationPageRoute);
  }

  static Future<void> setName(String nameCus) async {
    await SharedPreferencesHelper.preferences.setString("nameCus", nameCus);
  }

  static String getName() {
    return SharedPreferencesHelper.preferences.getString("nameCus") ?? "";
  }
}

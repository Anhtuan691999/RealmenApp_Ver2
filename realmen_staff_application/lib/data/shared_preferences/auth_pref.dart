import 'package:realmen_staff_application/data/shared_preferences/shared_preferences.dart';

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
}

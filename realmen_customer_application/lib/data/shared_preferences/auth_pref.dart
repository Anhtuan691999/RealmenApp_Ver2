import 'package:get/get.dart';
import 'package:realmen_customer_application/data/shared_preferences/shared_preferences.dart';
import 'package:realmen_customer_application/presentation/auth/ui/auth_page.dart';

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

  static Future<void> logout() async {
    await SharedPreferencesHelper.preferences.clear();
    Get.offAllNamed(AuthenticationPage.AuthenticationPageRoute);
  }
}

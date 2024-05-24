import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_staff_application/screens/history_booking/detail_history_hair_cut_screen.dart';
import 'package:realmen_staff_application/screens/history_booking/history_booking_screen.dart';
import 'package:realmen_staff_application/screens/login/login_otp_screen.dart';
import 'package:realmen_staff_application/screens/login/login_phone_screen.dart';

import 'package:realmen_staff_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_staff_application/screens/profile/view_edit_profile.dart';
import 'package:realmen_staff_application/screens/splash/splash_screen.dart';
import 'package:realmen_staff_application/screens/task/component/history_customer_processing.dart';
import 'package:realmen_staff_application/screens/task/component/history_customer_waiting.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';

class RouteGenerator {
  static List<GetPage> routes() {
    return [
      GetPage(
        name: SplashScreen.SplashScreenRoute,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: LoginPhoneScreen.LoginPhoneScreenRoute,
        page: () => const LoginPhoneScreen(),
      ),
      GetPage(
        name: LoginOTPScreen.LoginOTPScreenRoute,
        page: () => const LoginOTPScreen(),
      ),
      GetPage(
          name: MainScreen.MainScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else {
                    return const MainScreen();
                  }
                });
          }),
      GetPage(
          name: ViewEditProfileScreen.ViewEditProfileScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else {
                    return const ViewEditProfileScreen();
                  }
                });
          }),
      GetPage(
          name: HistoryBookingScreen.HistoryBookingScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else {
                    return const HistoryBookingScreen();
                  }
                });
          }),
      GetPage(
          name: DetailHistoryBookingScreen.DetailHistoryBookingScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else {
                    return const DetailHistoryBookingScreen();
                  }
                });
          }),
      GetPage(
          name: HistoryCustomerProcessingScreen
              .HistoryCustomerProcessingScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else {
                    return const HistoryCustomerProcessingScreen();
                  }
                });
          }),
      GetPage(
          name: HistoryCustomerWaitingScreen.HistoryCustomerWaitingScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else {
                    return const HistoryCustomerWaitingScreen();
                  }
                });
          }),
    ];
  }
}

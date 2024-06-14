import 'package:get/get.dart';
import 'package:realmen_staff_application/presentation/landing_page/landing_page.dart';

import 'package:realmen_staff_application/presentation/pages/splash_page.dart';
import 'package:realmen_staff_application/presentation/auth/ui/auth_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/landing_page/bloc/landing_page_bloc.dart';

class RouteGenerator {
  final LandingPageBloc landingPageBloc = LandingPageBloc();
  List<GetPage> routes() {
    return [
      GetPage(
        name: SplashPage.SplashPageRoute,
        page: () => const SplashPage(),
      ),
      GetPage(
        name: AuthenticationPage.AuthenticationPageRoute,
        page: () => const AuthenticationPage(),
      ),
      GetPage(
        name: LandingPage.LandingPageRoute,
        page: () => BlocProvider<LandingPageBloc>.value(
            value: landingPageBloc, child: LandingPage()),
      ),
    ];
  }
}

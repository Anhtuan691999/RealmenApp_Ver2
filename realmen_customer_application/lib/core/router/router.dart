import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/features/presentation/auth/bloc/auth_bloc.dart';
import 'package:realmen_customer_application/features/presentation/pages/landing_page/bloc/landing_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/pages/landing_page/landing_page.dart';
import 'package:realmen_customer_application/features/presentation/pages/splash_page.dart';
import 'package:realmen_customer_application/features/presentation/auth/ui/auth_page.dart';

import '../../features/presentation/pages/branches/branches_overview.dart';

class RouteGenerator {
  final LandingPageBloc landingPageBloc = LandingPageBloc();
  final AuthenticationBloc authenticationBloc = AuthenticationBloc();

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
      // GetPage(
      //   name: LandingPage.LandingPageRoute,
      //   page: () => const LandingPage(),
      // ),
      GetPage(
        name: LandingPage.LandingPageRoute,
        page: () => BlocProvider<LandingPageBloc>.value(
            value: landingPageBloc, child: LandingPage()),
      ),
      GetPage(
        name: BranchesOverviewScreen.BranchesOverviewScreenRoute,
        page: () => const BranchesOverviewScreen(),
      ),
    ];
  }
}

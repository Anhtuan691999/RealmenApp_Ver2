import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/features/presentation/auth/bloc/auth_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_branch_booking/booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/ui/booking_page.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_branch_page/bloc/choose_branch_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_branch_page/choose_branch_page.dart';
import 'package:realmen_customer_application/features/presentation/home/bloc/home_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/pages/landing_page/bloc/landing_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/pages/landing_page/landing_page.dart';
import 'package:realmen_customer_application/features/presentation/pages/splash_page.dart';
import 'package:realmen_customer_application/features/presentation/auth/ui/auth_page.dart';

import '../../features/presentation/pages/branches/branches_overview.dart';

class RouteGenerator {
  final LandingPageBloc landingPageBloc = LandingPageBloc();
  final AuthenticationBloc authenticationBloc = AuthenticationBloc();
  final HomePageBloc homePageBloc = HomePageBloc();
  final BookingBloc bookingPageBloc = BookingBloc();
  final ChooseBranchPageBloc chooseBranchPageBloc = ChooseBranchPageBloc();
  List<GetPage> routes() {
    return [
      GetPage(
        name: SplashPage.SplashPageRoute,
        page: () => const SplashPage(),
      ),
      GetPage(
        name: AuthenticationPage.AuthenticationPageRoute,
        page: () => BlocProvider(
          create: (context) => AuthenticationBloc(),
          child: const AuthenticationPage(),
        ),
      ),
      GetPage(
        name: LandingPage.LandingPageRoute,
        page: () => BlocProvider<LandingPageBloc>.value(
            value: landingPageBloc, child: const LandingPage()),
      ),
      GetPage(
        name: BranchesOverviewScreen.BranchesOverviewScreenRoute,
        page: () {
          final homePageBloc = BlocProvider.of<HomePageBloc>(Get.context!);
          return BranchesOverviewScreen(bloc: homePageBloc);
        },
      ),
      GetPage(
        name: BookingPage.BookingPageRoute,
        page: () {
          callback(int index) {} // Hàm callback rỗng hoặc hàm cụ thể của bạn
          return BookingPage(callback);
        },
      ),
      GetPage(
        name: ChooseBranchesPage.ChooseBranchesPageRoute,
        page: () {
          final bookingBloc = BlocProvider.of<BookingBloc>(Get.context!);
          return ChooseBranchesPage(bookingBloc: bookingBloc);
        },
      ),
    ];
  }
}

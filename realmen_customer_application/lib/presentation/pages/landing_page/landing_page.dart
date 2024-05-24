// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:realmen_customer_application/presentation/pages/landing_page/bloc/landing_page_bloc.dart';

class LandingPage extends StatefulWidget {
  final int? index;
  const LandingPage({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
  static const LandingPageRouter = '/landing-page';
}

class _LandingPageState extends State<LandingPage> {
  final LandingPageBloc landingPageBloc = LandingPageBloc();
  late String token;

  int bottomIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  late final HomeScreen homeScreen;
  late final ServicePriceListScreen servicePriceListScreen;
  late final PromotionScreen promotionScreen;
  late final BookingScreen bookingScreen;
  late final ProfileScreen profileScreen;

  void setPage(index) {
    final CurvedNavigationBarState? navBarState =
        _bottomNavigationKey.currentState;
    navBarState?.setPage(index);
  }

  @override
  void initState() {
    super.initState();

    // Lấy token từ arguments
    final arguments = Get.arguments as Map<String, dynamic>?;
    token = arguments?['token'];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.index != null) {
        bottomIndex = widget.index!;
        setPage(bottomIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Home Page'),
      ),
    );
  }
}

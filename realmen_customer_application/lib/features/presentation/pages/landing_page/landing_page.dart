// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:community_material_icon/community_material_icon.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:realmen_customer_application/features/presentation/booking/ui/booking_page.dart';
import 'package:realmen_customer_application/features/presentation/home/ui/home_page.dart';

import 'package:realmen_customer_application/features/presentation/pages/landing_page/bloc/landing_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/pages/profile_page.dart';
import 'package:realmen_customer_application/features/presentation/pages/promotion_page.dart';
import 'package:realmen_customer_application/features/presentation/list_service/service_price_list.dart';

class LandingPage extends StatefulWidget {
  final int? index;
  const LandingPage({
    super.key,
    this.index,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
  static const LandingPageRoute = '/realmen';
}

class _LandingPageState extends State<LandingPage> {
  final LandingPageBloc landingPageBloc = LandingPageBloc();
  late String token;

  int bottomIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  late final HomePage homePage;
  late final ServicePricePage servicePricePage;
  // late final PromotionPage promotionPage;
  late final BookingPage bookingPage;
  late final ProfilePage profilePage;

  void setPage(index) {
    final CurvedNavigationBarState? navBarState =
        _bottomNavigationKey.currentState;
    navBarState?.setPage(index);
  }

  @override
  void initState() {
    // Lấy token từ arguments
    final arguments = Get.arguments as Map<String, dynamic>?;
    token = arguments?.isNull ?? true ? "" : arguments?['token'];
    // landingPageBloc.add(LandingPageInitial(bottomIndex: 0) as LandingPageEvent);
    print('Current Route: ${Get.currentRoute}');
    super.initState();
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(setPage),
      ServicePricePage(setPage),
      BookingPage(setPage),
      // const PromotionPage(),
      ProfilePage(setPage),
    ];
    return BlocConsumer<LandingPageBloc, LandingPageInitial>(
        bloc: landingPageBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              // key: _bottomNavigationKey,
              body: pages[state.bottomIndex],
              bottomNavigationBar: CurvedNavigationBar(
                key: _bottomNavigationKey,
                color: Colors.white,
                backgroundColor: Colors.black87,
                items: const [
                  CurvedNavigationBarItem(
                    child: Icon(Icons.home_outlined),
                    label: 'Trang chủ',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.list_alt),
                    label: 'Dịch vụ',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.calendar_month),
                    label: 'Đặt lịch',
                  ),
                  // CurvedNavigationBarItem(
                  //   // child: Icon(Icons.newspaper),
                  //   child: Icon(CommunityMaterialIcons.ticket_percent_outline),
                  //   label: 'Ưu đãi',
                  // ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.perm_identity),
                    label: 'Tài khoản',
                  ),
                ],
                onTap: (index) {
                  landingPageBloc
                      .add(LandingPageTabChangeEvent(bottomIndex: index));
                },
              ),
            ),
          );
        });
  }
}

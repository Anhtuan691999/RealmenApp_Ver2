// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:community_material_icon/community_material_icon.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:realmen_staff_application/presentation/home/ui/home_page.dart';
import 'package:realmen_staff_application/presentation/pages/register_work_schedule.dart';
import 'package:realmen_staff_application/presentation/pages/work_schedule.dart';

import '../pages/profile_screen.dart';
import '../pages/task_screen.dart';
import 'bloc/landing_page_bloc.dart';

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

  void setPage(index) {
    final CurvedNavigationBarState? navBarState =
        _bottomNavigationKey.currentState;
    navBarState?.setPage(index);
  }

  @override
  void initState() {
    // Lấy token từ arguments
    final arguments = Get.arguments as Map<String, dynamic>?;
    token = arguments.isNull ? "" : arguments?['token'];
    // landingPageBloc.add(LandingPageInitial(bottomIndex: 0) as LandingPageEvent);
    print('Current Route: ${Get.currentRoute}');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const ProfileScreen(),
      const TaskScreen(),
      const WorkScheduleScreen(),
      const RegisterWorkScheduleScreen(),
    ];
    return BlocConsumer<LandingPageBloc, LandingPageInitial>(
        bloc: landingPageBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: pages[state.bottomIndex],
              bottomNavigationBar: CurvedNavigationBar(
                key: _bottomNavigationKey,
                color: Colors.white,
                backgroundColor: Colors.black87,
                items: const [
                  CurvedNavigationBarItem(
                    child: Icon(Icons.task),
                    label: 'Công việc',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.list_alt),
                    label: 'Lịch làm',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.calendar_month),
                    label: 'Đăng kí lịch',
                  ),
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

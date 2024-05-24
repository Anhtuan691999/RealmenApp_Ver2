// ignore_for_file: constant_identifier_names

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:get/get.dart';

import 'package:realmen_staff_application/screens/login/login_phone_screen.dart';
import 'package:realmen_staff_application/screens/profile/profile_screen.dart';
import 'package:realmen_staff_application/screens/register_work_schedule/register_work_schedule.dart';
import 'package:realmen_staff_application/screens/task/task_screen.dart';
import 'package:realmen_staff_application/screens/work_schedule/work_schedule.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
  static const String MainScreenRoute = "/main-screen";
}

class _MainScreenState extends State<MainScreen> {
  int bottomIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  late final ProfileScreen profileScreen;
  late final TaskScreen taskScreen;
  late final WorkScheduleScreen workScheduleScreen;
  late final RegisterWorkScheduleScreen registerWorkScheduleScreen;
  final LoginPhoneScreen loginScreen = const LoginPhoneScreen();

  void setPage(index) {
    final CurvedNavigationBarState? navBarState =
        _bottomNavigationKey.currentState;
    navBarState?.setPage(index);
  }

  @override
  void initState() {
    profileScreen = ProfileScreen(setPage);
    taskScreen = TaskScreen(setPage);
    workScheduleScreen = WorkScheduleScreen(setPage);
    registerWorkScheduleScreen = RegisterWorkScheduleScreen(setPage);
    super.initState();
  }

  pageChooser(int page) {
    try {
      switch (page) {
        case 0:
          return taskScreen;
        case 1:
          return workScheduleScreen;
        case 2:
          return registerWorkScheduleScreen;
        case 3:
          return profileScreen;
      }
    } catch (e) {
      return loginScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // key: _bottomNavigationKey,
        body: pageChooser(bottomIndex),
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
          onTap: (value) async {
            if (!await SharedPreferencesService.checkJwtExpired()) {
              setState(() {
                bottomIndex = value;
              });
            } else {
              Get.toNamed(LoginPhoneScreen.LoginPhoneScreenRoute);
            }
          },
        ),
      ),
    );
  }
}

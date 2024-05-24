// ignore_for_file: must_be_immutable, constant_identifier_names, unused_field, prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/screens/task/booking_processing.dart';
import 'package:realmen_staff_application/screens/task/booking_waiting.dart';
import 'package:realmen_staff_application/service/account/account_info_service.dart';
import 'package:realmen_staff_application/service/booking/booking_service.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class TaskScreen extends StatefulWidget {
  TaskScreen(this.callback, {super.key});
  Function callback;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
  static const String ProfileScreenRoute = "/task-screen";
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SafeArea(
                child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 15,
                  bottom: 27,
                  child: Container(
                      padding: const EdgeInsets.only(top: 30),
                      width: 90.w,
                      height: 90.h,
                      // height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 7),
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "Công việc".toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          isLoading
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 30),
                                      height: 50,
                                      width: 50,
                                      child: const CircularProgressIndicator(),
                                    )
                                  ],
                                )
                              : DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        controller: _tabController,
                                        labelColor: Colors.black,
                                        labelStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                        indicator: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        tabs: [
                                          Tab(
                                            child: Text(
                                              'ĐANG PHỤC VỤ',
                                              style: GoogleFonts.quicksand(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          !checkBadge
                                              ? Tab(
                                                  child: Text(
                                                    'ĐANG CHỜ',
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                )
                                              : Tab(
                                                  child: badges.Badge(
                                                    badgeStyle:
                                                        badges.BadgeStyle(
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      badgeColor: Colors.red,
                                                    ),
                                                    position:
                                                        badges.BadgePosition
                                                            .topEnd(
                                                                top: -12,
                                                                end: -20),
                                                    badgeContent: Icon(
                                                      Icons.priority_high,
                                                      color: Colors.white,
                                                      size: 13,
                                                    ),
                                                    child: Text(
                                                      'ĐANG CHỜ',
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 1,
                                      ),
                                      Container(
                                        // color: Colors.amber,
                                        // width: 400,
                                        height: 72.h,
                                        child: TabBarView(
                                          controller: _tabController,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          children: const [
                                            BookingProcessingTab(),
                                            BookingWaitingTab(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      )),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  late TabController _tabController;
  @override
  void initState() {
    getAccountInfo();
    getBookingService();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    _tabController.dispose();
    super.dispose();
  }

  bool isLoading = true;
  Future<void> getAccountInfo() async {
    if (mounted) {
      isLoading = true;
      try {
        AccountService accountService = AccountService();
        final result = await accountService.getAccountInfo();
        setState(() {
          isLoading = false;
        });
        print("$result");
      } on Exception catch (e) {
        _errorMessage("Vui lòng thử lại");
        print(e.toString());
      }
    }
  }

  int current = 1;
  int currentResult = 0;
  int totalPages = 0;
  bool checkBadge = false;

  List<BookingServiceModel> bookingContent = [];
  Future<void> getBookingService() async {
    if (mounted) {
      do {
        try {
          int staffId = await SharedPreferencesService.getStaffId();
          if (staffId != 0) {
            final result =
                await BookingService().getBookingService(staffId, current);
            if (result['statusCode'] == 200) {
              bookingContent.addAll(result['data']);
              currentResult = result['current'];
              totalPages = result['totalPages'];
              current = currentResult;
              current = current + 1;
              checkBadge = bookingContent.any((element) =>
                  (element.bookingServiceStatus == "CONFIRM" ||
                      element.bookingServiceStatus == "REQUEST_CONFIRM"));
              if (mounted) {
                setState(() {
                  checkBadge;
                });
              }
            } else {
              _errorMessage(result['message']);
              print(result);
            }
          }
        } catch (e) {
          _errorMessage("Vui lòng thử lại");
          print(e.toString());
        }
      } while (current <= totalPages);
    }
    setState(() {
      isLoading = false;
    });
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }
}

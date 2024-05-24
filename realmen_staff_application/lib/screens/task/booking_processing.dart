// ignore_for_file: unused_field, unused_element, sized_box_for_whitespace, avoid_print, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/screens/task/component/booking_processing_detail.dart';
import 'package:realmen_staff_application/service/booking/booking_service.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';

class BookingProcessingTab extends StatefulWidget {
  const BookingProcessingTab({super.key});

  @override
  State<BookingProcessingTab> createState() => _BookingProcessingTabState();
}

class _BookingProcessingTabState extends State<BookingProcessingTab>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoading
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
        : tabs.isNotEmpty && bookingViews.isNotEmpty
            ? (tabs.length > 1
                ? DefaultTabController(
                    length: tabs.length,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          labelColor: Colors.black,
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                          indicator: BoxDecoration(
                              // border: Border(
                              //   bottom: BorderSide(
                              //     color: Colors.black,
                              //     width: 1.0,
                              //   ),
                              // ),
                              color: Colors.grey.shade300),
                          isScrollable: true,
                          labelPadding: const EdgeInsets.only(
                              bottom: 10, left: 20, right: 20, top: 5),
                          tabs: tabs,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          // color: Colors.amber,
                          // width: 400,
                          // height: 45.h,
                          child: TabBarView(
                            controller: _tabController,
                            children: bookingViews,
                          ),
                        ),
                      ],
                    ),
                  )
                : bookingViews.first)
            : const Center(
                child: Text("Chưa có đơn booking"),
              );
  }

  bool isDone = false;
  @override
  bool get wantKeepAlive => true;

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getBooking(1);
  }

  bool isLoading = true;
  int current = 0;
  int currentResult = 0;
  int totalPages = 0;

  List<Widget> tabs = [];
  late TabController _tabController;
  List<BookingProcessingDetail> bookingViews = [];

  // get booking
  Future<void> getBooking(int current) async {
    if (!_isDisposed && mounted) {
      isLoading = true;
      tabs = [];
      do {
        try {
          int accountId = await SharedPreferencesService.getAccountId();
          String professional =
              await SharedPreferencesService.getProfessional();
          if (accountId != 0) {
            BookingModel bookingModel = BookingModel();
            final result =
                await BookingService().getBooking(accountId, current, 10);
            if (result['statusCode'] == 200) {
              bookingModel = result['data'] as BookingModel;
              currentResult = result['current'];
              totalPages = result['totalPages'];
              current = currentResult;
              current = current + 1;
              BookingContent bookingContent;
              bool checkBSForThisAcc = false;

              if (bookingModel.content!.isNotEmpty) {
                for (var content in bookingModel.content!) {
                  if (content.bookingServices != null) {
                    checkBSForThisAcc = content.bookingServices!
                        .any((service) => service.professional == professional);
                    if (checkBSForThisAcc) {
                      DateTime dateTimeContent =
                          DateTime.parse(content.appointmentDate!);
                      DateTime nowWithTime = DateTime.now();
                      DateTime now = DateTime(
                          nowWithTime.year, nowWithTime.month, nowWithTime.day);
                      if (dateTimeContent.compareTo(now) == 0 &&
                          (content.bookingStatus == "PROCESSING" ||
                              content.bookingStatus == "FINISHED" ||
                              content.bookingStatus == "CONFIRM")) {
                        content.bookingServices!.sort((a, b) =>
                            a.bookingServiceId!.compareTo(b.bookingServiceId!));
                        bookingContent = content;
                        bookingViews.add(
                            BookingProcessingDetail(booking: bookingContent));
                      }
                    }
                  }
                }

                for (var booking in bookingViews) {
                  Widget tab = Container(
                    width: 55.2,
                    // color: Colors.amberAccent,
                    child: Tab(
                      height: 20,
                      child: Text(
                        '${bookingViews.indexOf(booking) + 1}',
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                  tabs.add(tab);
                }
              }
            } else {
              _errorMessage(result['message']);
              print(result);
              break;
            }
          }
        } on Exception catch (e) {
          _errorMessage("Vui lòng thử lại");
          print(e.toString());
          isLoading = false;
          break;
        }
      } while (current <= totalPages);
      if (!_isDisposed && mounted) {
        setState(() {
          isLoading = false;
          bookingViews;
          tabs;
          if (tabs.isNotEmpty) {
            _tabController = TabController(length: tabs.length, vsync: this);
          }
          current;
        });
      }
    }
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  formatDate(DateTime date) {
    String day = DateFormat('EEEE').format(date);
    day = formatDay(day);
    return "$day, ${DateFormat('dd/MM/yyyy').format(date)}";
  }

  String formatDay(String day) {
    return dayNames[day.toLowerCase()] ?? day;
  }

  final Map<String, String> dayNames = {
    'monday': 'Thứ hai',
    'tuesday': 'Thứ ba',
    'wednesday': 'Thứ tư',
    'thursday': 'Thứ năm',
    'friday': 'Thứ sáu',
    'saturday': 'Thứ bảy',
    'sunday': 'Chủ nhật'
  };
}

class serviceDemoModel {
  String? name;
  int? role;
  bool? status;
  serviceDemoModel({
    this.name,
    this.role,
    this.status,
  });
}

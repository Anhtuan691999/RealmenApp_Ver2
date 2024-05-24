// ignore_for_file: use_build_context_synchronously, unused_catch_clause, library_private_types_in_public_api, constant_identifier_names, sized_box_for_whitespace, avoid_print, prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:realmen_staff_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_staff_application/screens/task/component/popup_service_booking.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/service/booking/booking_service.dart';

class ServiceBookingProcessingScreen extends StatefulWidget {
  final int? bookingId;
  final int? index;
  final String? professional;
  final BookingServiceModel? service;

  const ServiceBookingProcessingScreen({
    Key? key,
    this.bookingId,
    this.index,
    this.professional,
    this.service,
  }) : super(key: key);

  @override
  State<ServiceBookingProcessingScreen> createState() =>
      _ServiceBookingProcessingScreenState();
  static const String ServiceBookingProcessingScreenRoute =
      "/history-customer-processing-screen";
}

class _ServiceBookingProcessingScreenState
    extends State<ServiceBookingProcessingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(top: 15, left: 0),
                    width: 90.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 7),
                            child: Center(
                              child: Stack(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: IconButton(
                                      alignment: Alignment.centerLeft,
                                      color: Colors.black,
                                      iconSize: 22,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_left),
                                      onPressed: () {
                                        Get.toNamed(MainScreen.MainScreenRoute);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "đang phục vụ".toUpperCase(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                              : Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Đơn cắt:  ${booking.bookingCode}",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Ngày:  ${booking.appointmentDate}",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Giờ:  ${serviceBooking.startAppointment}",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 100,
                                            child: const Text(
                                              "Khách hàng: ",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 180,
                                            child: Text(
                                              booking.bookingOwnerName!,
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 100,
                                            child: const Text(
                                              "Số điện thoại: ",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 180,
                                            child: Text(
                                              booking.bookingOwnerPhone!,
                                              textAlign: TextAlign.left,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        "Dịch Vụ đang phục vụ: ".toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Divider(
                                          color: Colors.black,
                                          height: 2,
                                          thickness: 1,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: TimelineTile(
                                          // false la hien thanh

                                          isLast: false,
                                          beforeLineStyle: const LineStyle(
                                              color: Colors.transparent,
                                              thickness: 2),

                                          // icon
                                          indicatorStyle: IndicatorStyle(
                                            width: 35,
                                            height: 40,
                                            padding: const EdgeInsets.only(
                                                top: 4, bottom: 4, right: 5),
                                            indicator: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.shade300,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${widget.index}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            indicatorXY: 0.0,
                                          ),

                                          // content
                                          endChild: Container(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 0, left: 10),
                                            constraints: const BoxConstraints(
                                                minHeight: 80),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 194),
                                                  child: Text(
                                                    utf8.decode(widget
                                                        .service!.serviceName!
                                                        .toString()
                                                        .runes
                                                        .toList()),
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "thời gian phục vụ: ".toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Divider(
                                          color: Colors.black,
                                          height: 2,
                                          thickness: 1,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 40,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            10,
                                                    child: const Icon(
                                                      Icons.timer,
                                                      size: 24,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: const Text(
                                                      "Thời gian tiêu chuẩn:",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            5,
                                                    child: Text(
                                                      duration,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            10,
                                                    child: const Icon(
                                                      Icons.schedule,
                                                      size: 24,
                                                      color: Color(0xff207A20),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: const Text(
                                                      "Thời gian đã làm:",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xff207A20)),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            5,
                                                    child: StreamBuilder(
                                                      stream: Stream.periodic(
                                                          const Duration(
                                                              seconds: 1)),
                                                      builder:
                                                          (context, snapshot) {
                                                        return actualTime();
                                                      },
                                                    ),
                                                    // Text(
                                                    //   widget.startAppointment!,
                                                    //   style: TextStyle(
                                                    //       fontSize: 20,
                                                    //       fontWeight:
                                                    //           FontWeight.bold,
                                                    //       color: Color(0xff207A20)),
                                                    // ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      widget.professional == "STYLIST"
                                          ? Column(
                                              children: [
                                                Text(
                                                  "Ảnh chụp sau cắt: "
                                                      .toUpperCase(),
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 23,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                                  child: Divider(
                                                    color: Colors.black,
                                                    height: 2,
                                                    thickness: 1,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    constraints:
                                                        const BoxConstraints(
                                                            minHeight: 100),
                                                    child: Column(
                                                      children: [
                                                        _images.isNotEmpty
                                                            ? Column(
                                                                children: [
                                                                  Container(
                                                                    height: 200,
                                                                    // width: 300,

                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        IconButton(
                                                                          icon:
                                                                              const Icon(Icons.arrow_back),
                                                                          onPressed:
                                                                              () {
                                                                            if (_currentPage >
                                                                                0) {
                                                                              _pageController.previousPage(
                                                                                duration: const Duration(milliseconds: 300),
                                                                                curve: Curves.ease,
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              PageView.builder(
                                                                            controller:
                                                                                _pageController,
                                                                            itemCount:
                                                                                _images.length,
                                                                            itemBuilder:
                                                                                (context, index) {
                                                                              return GestureDetector(
                                                                                onTap: () {
                                                                                  _showFullScreenImage(context, index);
                                                                                },
                                                                                child: Hero(
                                                                                  tag: 'selectedImage$index',
                                                                                  child: Image.file(_images[index]),
                                                                                ),
                                                                              );
                                                                            },
                                                                            onPageChanged:
                                                                                (int page) {
                                                                              setState(() {
                                                                                _currentPage = page;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                        IconButton(
                                                                          icon:
                                                                              const Icon(Icons.arrow_forward),
                                                                          onPressed:
                                                                              () {
                                                                            if (_currentPage <
                                                                                _images.length - 1) {
                                                                              _pageController.nextPage(
                                                                                duration: const Duration(milliseconds: 300),
                                                                                curve: Curves.ease,
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 170,
                                                                    child: GridView
                                                                        .builder(
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      gridDelegate:
                                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount:
                                                                            4,
                                                                        mainAxisSpacing:
                                                                            5.0,
                                                                        crossAxisSpacing:
                                                                            4.0,
                                                                        childAspectRatio:
                                                                            4 / 8,
                                                                      ),
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount:
                                                                          _images
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            // Set the current page of PageView to the selected image
                                                                            if (_currentPage >
                                                                                0) {
                                                                              _pageController.animateToPage(
                                                                                index,
                                                                                duration: const Duration(milliseconds: 300),
                                                                                curve: Curves.ease,
                                                                              );
                                                                            } else if (_currentPage <
                                                                                _images.length - 1) {
                                                                              _pageController.animateToPage(
                                                                                index,
                                                                                duration: const Duration(milliseconds: 300),
                                                                                curve: Curves.ease,
                                                                              );
                                                                            }
                                                                          },
                                                                          child:
                                                                              Image.file(
                                                                            _images[index],
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            // height: 120,
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 7.3,
                                                                            alignment:
                                                                                Alignment.topCenter,
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Container(),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border: Border
                                                                            .all(
                                                                          color:
                                                                              Colors.black54,
                                                                          width:
                                                                              1,
                                                                          style:
                                                                              BorderStyle.solid,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    _pickImages();
                                                                  },
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "Chụp ảnh",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border: Border
                                                                            .all(
                                                                          color:
                                                                              Colors.black54,
                                                                          width:
                                                                              1,
                                                                          style:
                                                                              BorderStyle.solid,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    _removeImage(
                                                                        _currentPage);
                                                                  },
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "Xóa ảnh",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            // color: Colors.black45,
                                            border: Border.all(
                                              color: Colors.black54,
                                              width: 1,
                                              style: BorderStyle.solid,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: const EdgeInsets.all(10),
                                        child: TextButton(
                                          onPressed: btnFinishBookingService,
                                          child: Center(
                                            child: Text(
                                              "hoàn thành".toUpperCase(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  DateTime startTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    getBooking();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  int staffId = 0;
  bool isLoading = true;
  BookingServiceModel serviceBooking = BookingServiceModel();
  String duration = "00:00:00";
  BookingContent booking = BookingContent();
  Future<void> getBooking() async {
    if (!_isDisposed && mounted) {
      try {
        if (widget.bookingId != null) {
          staffId = await SharedPreferencesService.getStaffId();
          final result =
              await BookingService().getBookingById(widget.bookingId!);
          if (result['statusCode'] == 200) {
            booking = result['data'] as BookingContent;

            // date
            DateTime appointmentDate = DateTime.parse(booking.appointmentDate!);
            booking.appointmentDate = formatDate(appointmentDate);

            // phone
            String phone = booking.bookingOwnerPhone!;
            phone =
                "x" * (phone.length - 3) + phone.substring(phone.length - 3);
            booking.bookingOwnerPhone = phone;

            // name
            booking.bookingOwnerName =
                utf8.decode(booking.bookingOwnerName.toString().runes.toList());

            serviceBooking = widget.service!;
            // duration
            if (serviceBooking.startAppointment != null &&
                serviceBooking.endAppointment != null) {
              DateFormat format = DateFormat("HH:mm:ss");
              DateTime startAppo =
                  format.parse(serviceBooking.startAppointment!);
              DateTime endAppo = format.parse(serviceBooking.endAppointment!);
              final timeDifference = endAppo.difference(startAppo);
              duration = timeDifference.toString().split('.')[0];
            }
          } else {
            _errorMessage(result['message']);
            print(result);
          }
        }
        if (!_isDisposed && mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } on Exception catch (e) {
        _errorMessage("Vui lòng thử lại");
        print(e.toString());
      }
      isLoading = false;
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

  Widget actualTime() {
    try {
      DateTime now = DateTime.now();
      String timeString = "00:00:00";
      if (serviceBooking.actualStartAppointment != null) {
        timeString = serviceBooking.actualStartAppointment!;
      }

      DateTime actualStartTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(timeString.split(":")[0]),
        int.parse(timeString.split(":")[1]),
        int.parse(timeString.split(":")[2].split(".")[0]),
      );
      Duration difference = now.difference(actualStartTime);
      int seconds = difference.inSeconds % 60;
      int minutes = (difference.inSeconds ~/ 60) % 60;
      int hours = 0;
      // int hours = 0;
      if (serviceBooking.actualStartAppointment != null) {
        hours = difference.inHours;
      } else {
        hours = 0;
      }
      String text =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      return Text(
        text,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff207A20)),
      );
    } on Exception catch (e) {
      return const Text(
        "00:00:00",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff207A20)),
      );
    }
  }

  List<String> imageList = [];
  BookingResultImgsModel bookingResultImgs =
      BookingResultImgsModel(bookingResultImgs: []);
  final storage = FirebaseStorage.instance;
  List<Future<String>> uploadFutures = [];
  Future<void> btnFinishBookingService() async {
    if (!_isDisposed && mounted) {
      try {
        String professional = await SharedPreferencesService.getProfessional();
        final int bookingServiceId = serviceBooking.bookingServiceId!;
        final int accountId = await SharedPreferencesService.getAccountId();
        BookingService bookingService = BookingService();
        if (professional == "MASSEUR") {
          final result = await bookingService.putFinishService(
              bookingServiceId, accountId, bookingResultImgs);
          if (result['statusCode'] == 200) {
            Get.toNamed(MainScreen.MainScreenRoute);
          } else {
            _errorMessage(result['message']);
            print(result['error']);
          }
        }
        // Stylist
        else if (professional == "STYLIST") {
          if (_images.isEmpty || _images.length < 4) {
            return showModalBottomSheet(
              enableDrag: true,
              isDismissible: true,
              isScrollControlled: false,
              context: context,
              backgroundColor: Colors.white,
              barrierColor: const Color(0x8c111111),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) {
                dynamic bookingHairCut;
                return PopupServiceBooking(
                  images: _images,
                  bookings: bookingHairCut,
                  accountId: accountId,
                  bookingServiceId: bookingServiceId,
                );
              },
            );
          } else {
            if (_images.length > 4) {
              setState(() {
                _images.removeLast();
                _selectedImageIndex = 0;
              });
            } else {
              imageList = [];
              if (_images.length == 4) {
                for (var image in _images) {
                  imageList.add(
                      '${booking.bookingCode}_${_images.indexOf(image)}.jpg');
                  // Reference
                  var reference = storage.ref(
                      'booking/${booking.bookingCode}_${_images.indexOf(image)}.jpg');
                  // upload file
                  UploadTask uploadTask = reference.putFile(
                      image, SettableMetadata(contentType: 'image/jpeg'));
                  // kiem tra up xong chua
                  Future<TaskSnapshot> completedTask =
                      uploadTask.whenComplete(() => null);
                  uploadFutures.add(
                      completedTask.then((_) => reference.getDownloadURL()));
                }
              }
              if (imageList.length < 4) {
                imageList = [];
              }
              List<String> downloadURLs = await Future.wait(uploadFutures);
              if (downloadURLs.length == 4) {
                bookingResultImgs =
                    BookingResultImgsModel(bookingResultImgs: imageList);
                final result = await bookingService.putFinishService(
                    bookingServiceId, accountId, bookingResultImgs);
                if (result['statusCode'] == 200) {
                  Get.toNamed(MainScreen.MainScreenRoute);
                } else {
                  _errorMessage(result['message']);
                  print(result);
                }
              }
            }
          }
        }
      } on Exception catch (e) {
        _errorMessage("Vui lòng thử lại");
        print(e.toString());
      }
    }
  }

  // File image

  List<File> _images = [];
  int _selectedImageIndex = 0;
  int _currentPage = 0;
  PageController _pageController = PageController();
  Future<void> _pickImages() async {
    // for (var i = 0; i < 4; i++) {
    if (_images.length < 4) {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _images.add(File(image.path));
        });
      }
    } else {
      setState(() {
        _images.removeLast();
        _selectedImageIndex = 0;
      });
    }
    // }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      if (_selectedImageIndex == index) {
        _selectedImageIndex = 0;
      }
    });
  }

  void _showFullScreenImage(BuildContext context, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FullScreenImagePage(images: _images, initialIndex: initialIndex),
      ),
    );
  }

  Future<void> uploadFile(File file) async {
    // name file booking_code + index
    Reference ref =
        storage.ref().child('service_booking/${DateTime.now().toString()}');
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    if (taskSnapshot.state == TaskState.success) {
      print('File uploaded successfully');
    } else {
      print('File upload failed');
    }
  }
}

class FullScreenImagePage extends StatefulWidget {
  final List<File> images;
  final int initialIndex;

  const FullScreenImagePage(
      {super.key, required this.images, required this.initialIndex});

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white)),
        body:
            // Zoomed
            InteractiveViewer(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Center(
                // slide
                child: Hero(
                  tag: 'selectedImage$index',
                  child: Image.file(widget.images[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

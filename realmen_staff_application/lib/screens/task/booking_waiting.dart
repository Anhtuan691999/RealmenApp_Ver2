// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/screens/task/component/popup_accept_guests.dart';
import 'package:realmen_staff_application/service/booking/booking_service.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class BookingWaitingTab extends StatefulWidget {
  const BookingWaitingTab({super.key});

  @override
  State<BookingWaitingTab> createState() => _BookingWaitingTabState();
}

class _BookingWaitingTabState extends State<BookingWaitingTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: isLoading
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
            : bookingsPending.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bookingsPending.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize
                                .min, // Điều này sẽ giúp Column co lại con của nó thay vì mở rộng
                            crossAxisAlignment: CrossAxisAlignment
                                .stretch, // Đảm bảo các con của Column sẽ căng đều theo chiều ngang
                            children: [
                              Container(
                                height: 35,
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    bookingsPending[index].date!,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: bookingsPending[index]
                                    .bookings!
                                    .length, // The number of items in the list
                                itemBuilder: (context, i) {
                                  String phone = bookingsPending[index]
                                      .bookings![i]
                                      .bookingOwnerPhone!;
                                  phone = "x" * (phone.length - 3) +
                                      phone.substring(phone.length - 3);
                                  String name = utf8.decode(
                                      bookingsPending[index]
                                          .bookings![i]
                                          .bookingOwnerName
                                          .toString()
                                          .runes
                                          .toList());
                                  bool isComfirm = false;
                                  String bookingServiceStatus = "";
                                  for (var bookingService
                                      in bookingsPending[index]
                                          .bookings![i]
                                          .bookingServices!) {
                                    if (bookingService.staffId == staffId) {
                                      if (bookingService.bookingServiceStatus ==
                                              "REQUEST_CONFIRM" ||
                                          bookingService.bookingServiceStatus ==
                                              "CONFIRM") {
                                        if (bookingService
                                                .bookingServiceStatus ==
                                            "REQUEST_CONFIRM") {
                                          bookingServiceStatus = "Chờ xác nhận";
                                        } else if (bookingService
                                                .bookingServiceStatus ==
                                            "CONFIRM") {
                                          bookingServiceStatus = "Đã xác nhận";
                                        }
                                        isComfirm = true;
                                        break;
                                      } else {
                                        isComfirm = false;
                                      }
                                    }
                                  }

                                  // Return a Card widget for each item in the list
                                  return ExpansionTile(
                                    tilePadding: const EdgeInsets.all(0),
                                    backgroundColor: Colors.transparent,
                                    collapsedBackgroundColor: isComfirm
                                        ? Colors.amber
                                        : Colors.transparent,
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${i + 1}. ${utf8.decode(bookingsPending[index].bookings![i].bookingOwnerName.toString().runes.toList())}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "   Giờ book: ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              bookingsPending[index]
                                                  .bookings![i]
                                                  .bookingServices!
                                                  .first
                                                  .startAppointment!
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            constraints: const BoxConstraints(
                                                minHeight: 100),
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.start,
                                                //   crossAxisAlignment:
                                                //       CrossAxisAlignment.start,
                                                //   children: [
                                                //     Container(
                                                //       width: 120,
                                                //       child: const Text(
                                                //         "Khách hàng: ",
                                                //         style: TextStyle(
                                                //           fontSize: 17,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     Container(
                                                //       width: 200,
                                                //       child: Text(
                                                //         "${name}",
                                                //         maxLines: 2,
                                                //         textAlign:
                                                //             TextAlign.left,
                                                //         style: TextStyle(
                                                //           overflow: TextOverflow
                                                //               .ellipsis,
                                                //           color: Colors.black,
                                                //           fontWeight:
                                                //               FontWeight.w500,
                                                //           fontSize: 17,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                                // const SizedBox(
                                                //   height: 10,
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 90,
                                                      child: const Text(
                                                        "Số điện thoại: ",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 180,
                                                      child: Text(
                                                        phone,
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 17,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
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
                                                      width: 90,
                                                      child: const Text(
                                                        "Đơn booking: ",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 180,
                                                      child: Text(
                                                        bookingsPending[index]
                                                            .bookings![i]
                                                            .bookingCode!,
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 17,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isComfirm
                                                    ? Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child:
                                                                    const Text(
                                                                  "Trạng thái: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 170,
                                                                child: Text(
                                                                  bookingServiceStatus,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .amber
                                                                        .shade800,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        19,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),

                                                // Center(
                                                //   child: TextButton(
                                                //     onPressed: () {
                                                //       Get.to(
                                                //           const HistoryCustomerWaitingScreen());
                                                //     },
                                                //     child: const Text.rich(
                                                //       TextSpan(
                                                //         children: [
                                                //           TextSpan(
                                                //             text: "Xem lịch sử",
                                                //             style: TextStyle(
                                                //                 fontSize: 18,
                                                //                 color: Colors.blueAccent,
                                                //                 decoration: TextDecoration
                                                //                     .underline,
                                                //                 decorationStyle:
                                                //                     TextDecorationStyle
                                                //                         .solid),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  "Dịch Vụ: ",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
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
                                                Container(
                                                  // padding: EdgeInsets.all(12.0),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        bookingsPending[index]
                                                            .bookings![i]
                                                            .bookingServices!
                                                            .length,
                                                    itemBuilder: (context,
                                                        indexBookingService) {
                                                      // Return a Card widget for each item in the list
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 5),
                                                        child: Text(
                                                          "${indexBookingService + 1}.  ${utf8.decode(bookingsPending[index].bookings![i].bookingServices![indexBookingService].serviceName.toString().runes.toList())}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 20),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                  ),
                                                  child: Divider(
                                                    color: Colors.black,
                                                    height: 2,
                                                    thickness: 1,
                                                  ),
                                                ),
                                                bookingServiceStatus ==
                                                        "Đã xác nhận"
                                                    ? Container(
                                                        height: 60,
                                                        child: Center(
                                                          child: Text(
                                                            "Vui lòng chờ các nhân viên khác xác nhận!",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      )
                                                    : Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                // Container(
                                                                //   height: 50,
                                                                //   padding:
                                                                //       const EdgeInsets.symmetric(
                                                                //           horizontal: 5),
                                                                //   decoration: BoxDecoration(
                                                                //       color: Colors.grey,
                                                                //       borderRadius:
                                                                //           BorderRadius.circular(
                                                                //               10)),
                                                                //   // margin: EdgeInsets.all(10),
                                                                //   child: TextButton(
                                                                //     onPressed: () {},
                                                                //     child: const Center(
                                                                //       child: Text(
                                                                //         "Chuyển khách",
                                                                //         style: TextStyle(
                                                                //             fontSize: 20,
                                                                //             color: Colors.white),
                                                                //       ),
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                Container(
                                                                  height: 50,
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .black,
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
                                                                  // margin: EdgeInsets.all(10),
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      _popup(
                                                                        name,
                                                                        phone,
                                                                        bookingsPending[index]
                                                                            .bookings![i]
                                                                            .bookingId!,
                                                                        bookingsPending[index]
                                                                            .bookings![i],
                                                                      );
                                                                    },
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        bookingServiceStatus ==
                                                                                "Chờ xác nhận"
                                                                            ? "Xác nhận"
                                                                            : "Nhận khách",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          )
                                                        ],
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          );
                        }),
                  )
                : Container(
                    height: 70.h,
                    child: const Center(
                      child: Text("Chưa có đơn booking"),
                    ),
                  ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getBookingPending(1);
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // button
  Future<void> _popup(
      String name, String phone, int bookingId, BookingContent booking) async {
    if (!_isDisposed) {
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
        builder: (context) => PopUpAcceptGuest(
            name: name, phone: phone, bookingId: bookingId, booking: booking),
      );
    }
  }

  List<BookingPendingModel> bookingsPending = [];

  bool isLoading = true;
  int current = 0;
  int currentResult = 0;
  int totalPages = 0;
  int staffId = 0;

  // get booking
  Future<void> getBookingPending(int current) async {
    if (!_isDisposed && mounted) {
      List<BookingContent> bookings = [];
      List<String> dates = [];
      List<DateTime> dateTimes = [];
      try {
        do {
          try {
            int accountId = await SharedPreferencesService.getAccountId();
            staffId = await SharedPreferencesService.getStaffId();

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

                if (bookingModel.content!.isNotEmpty) {
                  try {
                    for (var content in bookingModel.content!) {
                      if (content.appointmentDate != null) {
                        DateTime nowWithTime = DateTime.now();
                        DateTime now = DateTime(nowWithTime.year,
                            nowWithTime.month, nowWithTime.day);
                        DateTime bookingDate =
                            DateTime.parse(content.appointmentDate!);
                        int checkDate = bookingDate.compareTo(now);
                        if (!dateTimes.contains(bookingDate) &&
                            checkDate == 0) {
                          dateTimes
                              .add(DateTime.parse(content.appointmentDate!));
                        }
                      }
                    }
                  } on Exception catch (e) {
                    isLoading = false;
                  }

                  if (dateTimes.isNotEmpty) {
                    dateTimes.sort((a, b) => a.compareTo(b));
                  }
                  for (var dateTime in dateTimes) {
                    String sDateTime =
                        DateFormat('yyyy-MM-dd').format(dateTime);
                    if (dates.isNotEmpty) {
                      bool checkDate = dates.contains((sDateTime));

                      if (!checkDate) {
                        dates.add(sDateTime);
                      }
                    } else {
                      dates.add(sDateTime);
                    }
                  }

                  for (var date in dates) {
                    bookings = [];
                    for (var content in bookingModel.content!) {
                      bool checkBookingsForThisAcc = content.bookingServices!
                          .any((service) => service.staffId == staffId);
                      if (date == content.appointmentDate &&
                          content.bookingStatus == "ONGOING" &&
                          checkBookingsForThisAcc) {
                        if (content.bookingServices!.length >= 2) {
                          content.bookingServices!.sort((a, b) => a
                              .bookingServiceId!
                              .compareTo(b.bookingServiceId!));
                        }
                        bookings.add(content);
                      }
                    }

                    DateTime dateFormat = DateTime.parse(date);
                    date = formatDate(dateFormat);

                    if (bookings.isNotEmpty) {
                      bookings.sort(((a, b) {
                        int check = a.bookingServices!.first.startAppointment!
                            .compareTo(
                                b.bookingServices!.first.startAppointment!);
                        return check;
                      }));
                      // add bookingsPending (date , bookings )
                      if (bookingsPending.isNotEmpty) {
                        bool isDateContained = bookingsPending.any(
                            (bookingPending) => bookingPending.date == date);
                        if (isDateContained) {
                          for (var bookingPending in bookingsPending) {
                            bookingPending.bookings!.addAll(bookings);
                            bookingPending.bookings!.sort(((a, b) {
                              int check = a
                                  .bookingServices!.first.startAppointment!
                                  .compareTo(b.bookingServices!.first
                                      .startAppointment!);
                              return check;
                            }));
                          }
                        } else {
                          BookingPendingModel newBookingPending =
                              BookingPendingModel(
                                  date: date, bookings: bookings);
                          bookingsPending.add(newBookingPending);
                        }
                      } else {
                        BookingPendingModel newBookingPending =
                            BookingPendingModel(date: date, bookings: bookings);
                        bookingsPending.add(newBookingPending);
                      }
                    }
                  }

                  if (!_isDisposed && mounted) {
                    setState(() {
                      bookingsPending;
                      current;
                    });
                  }
                } else {
                  if (!_isDisposed && mounted) {
                    setState(() {
                      bookingsPending;
                      current;
                    });
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
          });
        }
      } on Exception catch (e) {
        _errorMessage("Vui lòng thử lại");
        print(e.toString());
        isLoading = false;
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
}

class BookingPendingModel {
  String? date;
  List<BookingContent>? bookings;
  BookingPendingModel({
    this.date,
    this.bookings,
  });
}

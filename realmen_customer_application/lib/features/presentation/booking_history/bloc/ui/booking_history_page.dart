// // ignore_for_file: constant_identifier_names, sized_box_for_whitespace, avoid_print

// import 'dart:convert';
// import 'dart:math';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:realmen_customer_application/models/booking/booking_model.dart';

// import 'package:realmen_customer_application/screens/history_booking/detail_history_hair_cut_screen.dart';
// import 'package:realmen_customer_application/screens/message/success_screen.dart';
// import 'package:realmen_customer_application/service/authentication/authenticate_service.dart';
// import 'package:realmen_customer_application/service/booking/booking_service.dart';
// import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
// import 'package:sizer/sizer.dart';
// import 'package:badges/badges.dart' as badges;

// class HistoryBookingScreen extends StatefulWidget {
//   const HistoryBookingScreen({super.key});

//   @override
//   State<HistoryBookingScreen> createState() => _HistoryBookingScreenState();
//   static const String HistoryBookingScreenRoute = "/history-booking-screen";
// }

// class _HistoryBookingScreenState extends State<HistoryBookingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: [
//         Positioned(
//           child: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
//             ),
//           ),
//         ),
//         SafeArea(
//             child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Positioned(
//               top: 15,
//               bottom: 27,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Container(
//                   padding: const EdgeInsets.only(top: 15, left: 0),
//                   width: 90.w,
//                   height: 90.h,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.white),
//                   child: ListView(
//                     controller: _scrollController,
//                     children: <Widget>[
//                       Container(
//                         padding: const EdgeInsets.only(left: 7),
//                         child: Center(
//                           child: Stack(
//                             // mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 50,
//                                 child: IconButton(
//                                   alignment: Alignment.centerLeft,
//                                   color: Colors.black,
//                                   iconSize: 22,
//                                   icon: const Icon(Icons.keyboard_arrow_left),
//                                   onPressed: () {
//                                     Get.back();
//                                   },
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 50,
//                                 child: Center(
//                                   child: Text(
//                                     "Lịch sử đặt lịch".toUpperCase(),
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 24,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       isLoading
//                           ? Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.only(top: 30),
//                                   height: 50,
//                                   width: 50,
//                                   child: const CircularProgressIndicator(),
//                                 )
//                               ],
//                             )
//                           : Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   // ignore: avoid_unnecessary_containers
//                                   child: Container(
//                                     // height: 85.8.h,
//                                     child: bookings.isEmpty
//                                         ? Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 margin: const EdgeInsets.only(
//                                                     top: 30),
//                                                 child: const Center(
//                                                   child: Text(
//                                                     "Bạn chưa có lịch đặt nào",
//                                                     style: TextStyle(
//                                                       fontSize: 17,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           )
//                                         : ListView.builder(
//                                             // controller: _scrollController,
//                                             shrinkWrap: true,
//                                             physics:
//                                                 const NeverScrollableScrollPhysics(),
//                                             itemCount: bookings
//                                                 .length, // Số lượng thẻ lịch sử cắt tóc
//                                             itemBuilder: (context, index) {
//                                               return Card(
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               12.0),
//                                                       child: Column(
//                                                         children: [
//                                                           badges.Badge(
//                                                             badgeStyle: badges
//                                                                 .BadgeStyle(
//                                                               shape: badges
//                                                                   .BadgeShape
//                                                                   .circle,
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           5),
//                                                               padding:
//                                                                   EdgeInsets
//                                                                       .all(2),
//                                                               badgeColor:
//                                                                   Colors.red,
//                                                             ),
//                                                             position: badges
//                                                                     .BadgePosition
//                                                                 .topEnd(
//                                                                     top: -12,
//                                                                     end: -20),
//                                                             badgeContent: Icon(
//                                                               Icons
//                                                                   .priority_high,
//                                                               color:
//                                                                   Colors.white,
//                                                               size: 13,
//                                                             ),
//                                                             child: Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .center,
//                                                               children: [
//                                                                 const Icon(
//                                                                   Icons.home,
//                                                                   color: Colors
//                                                                       .red,
//                                                                   size: 26,
//                                                                 ),
//                                                                 Expanded(
//                                                                   child:
//                                                                       Container(
//                                                                     padding:
//                                                                         const EdgeInsets
//                                                                             .all(
//                                                                             10),
//                                                                     child:
//                                                                         Column(
//                                                                       crossAxisAlignment:
//                                                                           CrossAxisAlignment
//                                                                               .start,
//                                                                       children: [
//                                                                         Text(
//                                                                           utf8.decode(bookings[index]
//                                                                               .branchName
//                                                                               .toString()
//                                                                               .runes
//                                                                               .toList()),
//                                                                           style:
//                                                                               const TextStyle(
//                                                                             fontSize:
//                                                                                 17,
//                                                                             fontWeight:
//                                                                                 FontWeight.w600,
//                                                                           ),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                             height:
//                                                                                 2),
//                                                                         Row(
//                                                                           children: [
//                                                                             Text(
//                                                                               bookings[index].appointmentDate ?? "",
//                                                                               style: const TextStyle(fontSize: 16, color: Colors.black54),
//                                                                             ),
//                                                                             const SizedBox(width: 10),
//                                                                             bookings[index].bookingServices != null
//                                                                                 ? Text(
//                                                                                     bookings[index].bookingServices!.first.startAppointment.toString(),
//                                                                                     style: const TextStyle(fontSize: 16, color: Colors.black54),
//                                                                                   )
//                                                                                 : Container(),
//                                                                           ],
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           Row(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               // bookings[index]
//                                                               //             .bookingServices!
//                                                               //             .first
//                                                               //             .bookingResults !=
//                                                               //         null
//                                                               //     ? CachedNetworkImage(
//                                                               //         imageUrl: bookings[
//                                                               //                 index]
//                                                               //             .bookingServices!
//                                                               //             .first
//                                                               //             .bookingResults!
//                                                               //             .first
//                                                               //             .bookingResultImg!,
//                                                               //         height:
//                                                               //             170,
//                                                               //         width:
//                                                               //             120,
//                                                               //         fit: BoxFit
//                                                               //             .cover,
//                                                               //         progressIndicatorBuilder: (context,
//                                                               //                 url,
//                                                               //                 progress) =>
//                                                               //             Center(
//                                                               //           child:
//                                                               //               CircularProgressIndicator(
//                                                               //             value:
//                                                               //                 progress.progress,
//                                                               //           ),
//                                                               //         ),
//                                                               //         errorWidget: (context,
//                                                               //                 url,
//                                                               //                 error) =>
//                                                               //             Image
//                                                               //                 .asset(
//                                                               //           "assets/images/default.png",
//                                                               //           height:
//                                                               //               170,
//                                                               //           width:
//                                                               //               120,
//                                                               //           fit: BoxFit
//                                                               //               .cover,
//                                                               //         ),
//                                                               //       )
//                                                               //     :
//                                                               Image.asset(
//                                                                 "assets/images/default.png",
//                                                                 height: 170,
//                                                                 width: 120,
//                                                                 fit: BoxFit
//                                                                     .cover,
//                                                               ),
//                                                               Column(
//                                                                 children: [
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets
//                                                                             .all(
//                                                                             9),
//                                                                     child:
//                                                                         Column(
//                                                                       crossAxisAlignment:
//                                                                           CrossAxisAlignment
//                                                                               .start,
//                                                                       children: [
//                                                                         Container(
//                                                                           constraints:
//                                                                               const BoxConstraints(maxWidth: 200),
//                                                                           child:
//                                                                               Text(
//                                                                             "${bookings[index].bookingCode}",
//                                                                             style:
//                                                                                 const TextStyle(overflow: TextOverflow.clip),
//                                                                           ),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                             height:
//                                                                                 10),
//                                                                         Row(
//                                                                           children: [
//                                                                             const Text("Stylist:"),
//                                                                             const SizedBox(width: 2),
//                                                                             Text(stylist)
//                                                                           ],
//                                                                         ),
//                                                                         const SizedBox(
//                                                                             height:
//                                                                                 10),
//                                                                         Row(
//                                                                           children: [
//                                                                             const Text("Massuer:"),
//                                                                             const SizedBox(width: 2),
//                                                                             Text(massuer)
//                                                                           ],
//                                                                         ),
//                                                                         const SizedBox(
//                                                                             height:
//                                                                                 10),
//                                                                         // Row(
//                                                                         //   children: [
//                                                                         //     const Text(
//                                                                         //         "Tổng hóa đơn:"),
//                                                                         //     const SizedBox(
//                                                                         //         width:
//                                                                         //             2),
//                                                                         //     totals[index]['bookingId'] ==
//                                                                         //             bookings[index].bookingId
//                                                                         //         ? Text(
//                                                                         //             formatter.format(totals[index]['total']),
//                                                                         //           )
//                                                                         //         : const Text("0"),
//                                                                         //   ],
//                                                                         // ),
//                                                                         const SizedBox(
//                                                                             height:
//                                                                                 25),
//                                                                         ElevatedButton(
//                                                                           onPressed: () =>
//                                                                               Get.to(() => DetailHistoryBookingScreen(booking: bookings[index])),
//                                                                           style:
//                                                                               ElevatedButton.styleFrom(
//                                                                             backgroundColor:
//                                                                                 Colors.black,
//                                                                           ),
//                                                                           child:
//                                                                               const Text(
//                                                                             'Xem chi tiết ->',
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Colors.white,
//                                                                               fontWeight: FontWeight.bold,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ))
//       ],
//     )

//         //  SingleChildScrollView(
//         //   child: Column(
//         //     children: [
//         //       Container(
//         //         child: const Padding(
//         //           padding: EdgeInsets.all(16.0),
//         //           child: CardHistoryHairCut(),
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         );
//   }

//   @override
//   void initState() {
//     super.initState();
//     checkLoadMore();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         // Khi scroll tới dưới cùng
//         checkLoadMore();
//       }
//     });
//   }

//   bool _isDisposed = false;
//   @override
//   void dispose() {
//     _isDisposed = true;
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(HistoryBookingScreen oldWidget) {
//     setState(() {
//       build(context);
//       current;
//     });

//     super.didUpdateWidget(oldWidget);
//   }

//   NumberFormat formatter = NumberFormat("#,##0");
//   double total = 0;

//   bool isLoading = true;
//   List<BookingContent> bookings = [];
//   String stylist = '';
//   String massuer = '';
//   int current = 0;
//   int currentResult = 0;
//   int totalPages = 0;
//   final storage = FirebaseStorage.instance;

//   Future<void> getBookingPending(int current) async {
//     if (!_isDisposed && mounted) {
//       try {
//         int accountId = await SharedPreferencesService.getAccountId();
//         int customerId = await SharedPreferencesService.getCusomterId();
//         if (accountId != 0) {
//           BookingModel bookingModel = BookingModel();

//           final result = await BookingService()
//               .getBooking(accountId, customerId, current, 4);
//           if (result['statusCode'] == 200) {
//             bookingModel = result['data'] as BookingModel;
//             currentResult = result['current'];
//             totalPages = result['totalPages'];
//             if (bookingModel.content!.isNotEmpty) {
//               for (var content in bookingModel.content!) {
//                 bookings.add(content);
//               }
//               for (var booking in bookings) {
//                 total = 0;
//                 try {
//                   DateTime date = DateTime.parse(booking.appointmentDate!);
//                   booking.appointmentDate = formatDate(date);
//                   if (booking.bookingServices != null) {
//                     for (var service in booking.bookingServices!) {
//                       if (service.servicePrice != null) {
//                         total += double.parse(service.servicePrice.toString());
//                       } else {
//                         total = 0;
//                       }
//                       if (service.staffName == null) {
//                       } else if (service.professional == "MASSEUR") {
//                         massuer = utf8.decode(
//                             service.staffName!.toString().runes.toList());
//                       } else {
//                         stylist = utf8.decode(
//                             service.staffName!.toString().runes.toList());
//                       }
//                       List<BookingResultsModel> bookingResultImg = [];

//                       if (service.bookingResults != null) {
//                         for (BookingResultsModel image
//                             in service.bookingResults!) {
//                           String bookingImage = "";
//                           try {
//                             var reference = storage.ref(image.bookingResultImg);
//                             bookingImage = await reference.getDownloadURL();
//                             bookingResultImg.add(BookingResultsModel(
//                                 bookingResultImg: bookingImage));
//                           } catch (e) {}
//                         }
//                         if (bookingResultImg.length == 4) {
//                           booking.bookingServices!.first.bookingResults =
//                               bookingResultImg;
//                         }
//                       }
//                     }
//                     totals
//                         .add({'bookingId': booking.bookingId, 'total': total});
//                   } else {
//                     total = 0;
//                     totals
//                         .add({'bookingId': booking.bookingId, 'total': total});
//                   }

//                   // ignore: unused_catch_clause
//                 } on Exception catch (e) {
//                   totals.add({'bookingId': 0, 'total': 0});
//                 }
//               }
//               // if (bookings.isNotEmpty) {
//               //   bookings
//               //       .removeWhere((booking) => booking.bookingServices == null);
//               // }

//               if (!_isDisposed && mounted) {
//                 setState(() {
//                   bookings;
//                   totals;

//                   // current;
//                 });
//               }
//             } else {
//               if (!_isDisposed && mounted) {
//                 setState(() {
//                   bookings;

//                   // current;
//                 });
//               }
//             }
//           } else {
//             _errorMessage(result['message']);
//             print(result);
//           }
//         }
//       } on Exception catch (e) {
//         _errorMessage("Vui lòng thử lại");
//         print(e.toString());
//       }
//     }
//     isLoading = false;
//   }

//   void checkLoadMore() async {
//     current = currentResult;
//     current = current + 1;
//     if (totalPages == 0) {
//       await getBookingPending(current);
//     } else {
//       if (current <= totalPages) {
//         await getBookingPending(current);
//       }
//     }
//   }

//   void _errorMessage(String? message) {
//     try {
//       ShowSnackBar.ErrorSnackBar(context, message!);
//     } catch (e) {
//       print(e);
//     }
//   }

//   formatDate(DateTime date) {
//     String day = DateFormat('EEEE').format(date);
//     day = formatDay(day);
//     return "$day, ${DateFormat('dd/MM/yyyy').format(date)}";
//   }

//   String formatDay(String day) {
//     return dayNames[day.toLowerCase()] ?? day;
//   }

//   final Map<String, String> dayNames = {
//     'monday': 'Thứ hai',
//     'tuesday': 'Thứ ba',
//     'wednesday': 'Thứ tư',
//     'thursday': 'Thứ năm',
//     'friday': 'Thứ sáu',
//     'saturday': 'Thứ bảy',
//     'sunday': 'Chủ nhật'
//   };
//   final ScrollController _scrollController = ScrollController();

//   List<Map<String, dynamic>> totals = [];
// }

// // ignore_for_file: constant_identifier_names, avoid_print

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:intl/intl.dart';
// import 'package:realmen_customer_application/models/booking/booking_model.dart';
// import 'package:realmen_customer_application/screens/booking/components/pop_up/popup_confirm.dart';
// import 'package:realmen_customer_application/screens/message/success_screen.dart';
// import 'package:realmen_customer_application/service/authentication/authenticate_service.dart';
// import 'package:realmen_customer_application/service/booking/booking_service.dart';
// import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
// import 'package:sizer/sizer.dart';

// class BookingProcessingScreen extends StatefulWidget {
//   const BookingProcessingScreen({super.key});

//   @override
//   State<BookingProcessingScreen> createState() =>
//       _BookingProcessingScreenState();
//   static const String BookingProcessingScreenRoute =
//       "/booking-processing-screen";
// }

// class _BookingProcessingScreenState extends State<BookingProcessingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//             child: Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('assets/images/bg.png'),
//                     fit: BoxFit.cover),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Positioned(
//                   top: 15,
//                   bottom: 27,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       padding: const EdgeInsets.only(top: 15, left: 0),
//                       width: 90.w,
//                       height: 90.h,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.white),
//                       child: ListView(
//                         children: <Widget>[
//                           Container(
//                             padding: const EdgeInsets.only(left: 7),
//                             child: Center(
//                               child: Stack(
//                                 // mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     height: 50,
//                                     child: IconButton(
//                                       alignment: Alignment.centerLeft,
//                                       color: Colors.black,
//                                       iconSize: 22,
//                                       icon:
//                                           const Icon(Icons.keyboard_arrow_left),
//                                       onPressed: () {
//                                         Get.back();
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 50,
//                                     child: Center(
//                                       child: Text(
//                                         "lịch đặt của bạn".toUpperCase(),
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 24,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           isLoading
//                               ? Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.only(top: 30),
//                                       height: 50,
//                                       width: 50,
//                                       child: const CircularProgressIndicator(),
//                                     )
//                                   ],
//                                 )
//                               : booking.bookingId == null
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           margin:
//                                               const EdgeInsets.only(top: 30),
//                                           child: const Center(
//                                             child: Text(
//                                               "Bạn chưa có lịch đặt nào",
//                                               style: TextStyle(
//                                                 fontSize: 17,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     )
//                                   : Column(
//                                       children: [
//                                         _buildInfoUser(),
//                                         _buildService(),
//                                         const Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 10, horizontal: 10),
//                                           child: Divider(
//                                             color: Colors.black,
//                                             height: 2,
//                                             thickness: 1,
//                                           ),
//                                         ),
//                                         _buildTotalMoney(),
//                                         _buildButton(),
//                                         const SizedBox(
//                                           height: 10,
//                                         )
//                                       ],
//                                     ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),

//       //
//     );
//   }

//   Widget _buildInfoUser() {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 width: 130,
//                 child: Text(
//                   "Code: ",
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//               Text(
//                 booking.bookingCode ?? " ",
//                 textAlign: TextAlign.left,
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 17),
//               ),
//             ],
//           ),
//           // Ngày và giờ
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 width: 130,
//                 child: Text(
//                   "Ngày: ",
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//               Text(
//                 booking.appointmentDate ?? " ",
//                 textAlign: TextAlign.left,
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 17),
//               ),
//             ],
//           ),

//           // Giờ
//           const SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 width: 130,
//                 child: Text(
//                   "Giờ booking: ",
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//               Text(
//                 booking.bookingServices != null
//                     ? booking.bookingServices!.first.startAppointment ?? ""
//                     : '',
//                 textAlign: TextAlign.left,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 17,
//                 ),
//               ),
//             ],
//           ),
//           //Stylist
//           const SizedBox(
//             height: 12,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 width: 130,
//                 child: Text(
//                   "Stylist: ",
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 220,
//                 child: Text(
//                   stylist,
//                   textAlign: TextAlign.left,
//                   maxLines: 1,
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 17,
//                       overflow: TextOverflow.ellipsis),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 width: 130,
//                 child: Text(
//                   "Massuer: ",
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 220,
//                 child: Text(
//                   massuer,
//                   textAlign: TextAlign.left,
//                   maxLines: 1,
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 17,
//                       overflow: TextOverflow.ellipsis),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           // Barber Shop:
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 width: 130,
//                 child: Text(
//                   "Barber Shop: ",
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 220,
//                 child: Text(
//                   utf8.decode(booking.branchAddress.toString().runes.toList()),
//                   maxLines: 3,
//                   textAlign: TextAlign.left,
//                   style: const TextStyle(
//                     overflow: TextOverflow.ellipsis,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildService() {
//     return Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Dịch Vụ: ",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//           child: Divider(
//             color: Colors.black,
//             height: 2,
//             thickness: 1,
//           ),
//         ),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: booking.bookingServices != null
//               ? booking.bookingServices!.length
//               : 0, // The number of items in the list
//           itemBuilder: (context, index) {
//             // Return a Card widget for each item in the list
//             return Padding(
//               padding:
//                   const EdgeInsets.only(top: 7, bottom: 7, left: 12, right: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     constraints: const BoxConstraints(maxWidth: 280),
//                     child: Expanded(
//                       child: Text(
//                         utf8.decode(booking.bookingServices![index].serviceName
//                             .toString()
//                             .runes
//                             .toList()),
//                         style: const TextStyle(fontSize: 17),
//                         maxLines: 2,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     booking.bookingServices![index].servicePrice != null
//                         ? formatter.format(
//                             booking.bookingServices![index].servicePrice)
//                         : '0',
//                     style: const TextStyle(fontSize: 17),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildTotalMoney() {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: ListView(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: [
//           //     const Text(
//           //       "Tổng Tiền:",
//           //       style: TextStyle(
//           //         fontSize: 17,
//           //       ),
//           //     ),
//           //     // SizedBox(width: 140),
//           //     Text(
//           //       formatter.format(total),
//           //       style: const TextStyle(fontSize: 17),
//           //     ),
//           //   ],
//           // ),
//           // const SizedBox(
//           //   height: 5,
//           // ),
//           // const Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: [
//           //     Text(
//           //       "Tổng Giảm Giá:",
//           //       style: TextStyle(
//           //         fontSize: 17,
//           //       ),
//           //     ),
//           //     // SizedBox(width: 140),
//           //     Text(
//           //       "0",
//           //       style: TextStyle(fontSize: 17),
//           //     ),
//           //   ],
//           // ),
//           // const SizedBox(
//           //   height: 7,
//           // ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Tạm Tính:",
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               // SizedBox(width: 140),
//               Text(
//                 formatter.format(total),
//                 style: const TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 7,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildButton() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Container(
//           // margin: const EdgeInsets.only(top: 22),
//           width: 70.w,
//           height: 40,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.redAccent, width: 1),
//             borderRadius: BorderRadius.circular(24),
//           ),
//           child: ElevatedButton(
//             onPressed: () {
//               _popup();
//             },
//             style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               backgroundColor: Colors.transparent,
//               shadowColor: Colors.transparent,
//             ),
//             child: const Text(
//               "Hủy lịch đặt",
//               style: TextStyle(
//                   fontSize: 22,
//                   color: Colors.redAccent,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   NumberFormat formatter = NumberFormat("#,##0");
//   double total = 0;
//   calTotal() {
//     if (booking.bookingServices != null) {
//       for (var service in booking.bookingServices!) {
//         if (service.servicePrice != null) {
//           total += double.parse(service.servicePrice.toString());
//           if (service.staffName == null) {
//           } else if (service.professional == "MASSEUR") {
//             massuer = utf8.decode(service.staffName!.toString().runes.toList());
//           } else {
//             stylist = utf8.decode(service.staffName!.toString().runes.toList());
//           }
//         } else {
//           total = 0;
//         }
//       }
//     } else {
//       total = 0;
//     }
//     setState(() {
//       total;
//       isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getBookingPending();
//   }

//   bool _isDisposed = false;
//   @override
//   void dispose() {
//     _isDisposed = true;
//     super.dispose();
//   }

//   bool isLoading = true;
//   BookingContent booking = BookingContent();
//   String stylist = '';
//   String massuer = '';
//   Future<void> getBookingPending() async {
//     if (!_isDisposed && mounted) {
//       try {
//         int current = 1;
//         int totalPages = 0;
//         int accountId = await SharedPreferencesService.getAccountId();
//         int customerId = await SharedPreferencesService.getCusomterId();
//         if (accountId != 0) {
//           do {
//             BookingModel bookingModel = BookingModel();
//             final result = await BookingService()
//                 .getBooking(accountId, customerId, current, 1);
//             if (result['statusCode'] == 200) {
//               bookingModel = result['data'] as BookingModel;
//               current = result['current'];
//               totalPages = result['totalPages'];
//               if (bookingModel.content!.isNotEmpty) {
//                 DateTime now = DateTime.now();
//                 DateTime nowFullTime =
//                     DateTime(now.year, now.month, now.day, 0);
//                 DateTime appointmentDate = DateTime.parse(
//                     bookingModel.content!.first.appointmentDate!.toString());
//                 if (nowFullTime.isAtSameMomentAs(appointmentDate) ||
//                     appointmentDate.isAfter(nowFullTime)) {
//                   booking = bookingModel.content!.first;
//                   DateTime date = DateTime.parse(booking.appointmentDate!);
//                   booking.appointmentDate = formatDate(date);

//                   if (!_isDisposed && mounted) {
//                     setState(() {
//                       booking;
//                       calTotal();
//                     });
//                   }
//                   break;
//                 } else {
//                   current++;
//                 }

//                 // if (booking.bookingStatus == 'PENDING') {
//                 //   if (!_isDisposed && mounted) {
//                 //     setState(() {
//                 //       bookingModel;
//                 //       isLoading = false;
//                 //     });
//                 //   }
//                 // }
//               } else {
//                 // if (!_isDisposed && mounted) {
//                 //   setState(() {
//                 //     bookingModel;
//                 //     isLoading = false;
//                 //   });
//                 // }
//                 current++;
//               }
//             } else {
//               _errorMessage(result['message']);
//               print(result);
//               break;
//             }
//           } while (current <= totalPages);
//           if (booking.bookingId == null) {
//             if (!_isDisposed && mounted) {
//               setState(() {
//                 isLoading = false;
//               });
//             }
//           }
//         }
//       } on Exception catch (e) {
//         _errorMessage("Vui lòng thử lại");
//         print(e.toString());
//       }
//       isLoading = false;
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

//   Future<void> _popup() async {
//     if (!_isDisposed) {
//       return showModalBottomSheet(
//         enableDrag: true,
//         isDismissible: true,
//         isScrollControlled: false,
//         context: context,
//         backgroundColor: Colors.white,
//         barrierColor: const Color(0x8c111111),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(20),
//           ),
//         ),
//         builder: (context) {
//           return PopUpConfirm(
//             bookingId: booking.bookingId,
//           );
//         },
//       );
//     }
//   }
// }

// class ServiceList {
//   String? name;
//   double? price;
//   ServiceList({
//     this.name,
//     this.price,
//   });
// }

// // ignore_for_file: constant_identifier_names, must_be_immutable

// import 'dart:convert';
// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import 'package:sizer/sizer.dart';



// class DetailHistoryBookingScreen extends StatefulWidget {
//   BookingContent? booking;
//   DetailHistoryBookingScreen({this.booking, super.key});

//   @override
//   State<DetailHistoryBookingScreen> createState() =>
//       _DetailHistoryBookingScreenState();
//   static const String DetailHistoryBookingScreenRoute =
//       "/detail-history-booking-screen";
// }

// class _DetailHistoryBookingScreenState
//     extends State<DetailHistoryBookingScreen> {
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
//                                         "chi tiết đặt lịch".toUpperCase(),
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
//                               : Column(
//                                   children: [
//                                     _images.isNotEmpty
//                                         ? Column(
//                                             children: [
//                                               Container(
//                                                 height: 200,
//                                                 // width: 300,

//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     IconButton(
//                                                       icon: const Icon(
//                                                           Icons.arrow_back),
//                                                       onPressed: () {
//                                                         if (_currentPage > 0) {
//                                                           _pageController
//                                                               .previousPage(
//                                                             duration:
//                                                                 const Duration(
//                                                                     milliseconds:
//                                                                         300),
//                                                             curve: Curves.ease,
//                                                           );
//                                                         }
//                                                       },
//                                                     ),
//                                                     Expanded(
//                                                       child: PageView.builder(
//                                                         controller:
//                                                             _pageController,
//                                                         itemCount:
//                                                             _images.length,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           return GestureDetector(
//                                                             onTap: () {
//                                                               _showFullScreenImage(
//                                                                   context,
//                                                                   index);
//                                                             },
//                                                             child: Hero(
//                                                               tag:
//                                                                   'selectedImage$index',
//                                                               child:
//                                                                   CachedNetworkImage(
//                                                                 imageUrl: _images[
//                                                                         index]
//                                                                     .bookingResultImg!,
//                                                                 fit: BoxFit
//                                                                     .cover,
//                                                                 progressIndicatorBuilder:
//                                                                     (context,
//                                                                             url,
//                                                                             progress) =>
//                                                                         Center(
//                                                                   child:
//                                                                       CircularProgressIndicator(
//                                                                     value: progress
//                                                                         .progress,
//                                                                   ),
//                                                                 ),
//                                                                 errorWidget: (context,
//                                                                         url,
//                                                                         error) =>
//                                                                     Image.asset(
//                                                                   "assets/images/default.png",
//                                                                   fit: BoxFit
//                                                                       .cover,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           );
//                                                         },
//                                                         onPageChanged:
//                                                             (int page) {
//                                                           setState(() {
//                                                             _currentPage = page;
//                                                           });
//                                                         },
//                                                       ),
//                                                     ),
//                                                     IconButton(
//                                                       icon: const Icon(
//                                                           Icons.arrow_forward),
//                                                       onPressed: () {
//                                                         if (_currentPage <
//                                                             _images.length -
//                                                                 1) {
//                                                           _pageController
//                                                               .nextPage(
//                                                             duration:
//                                                                 const Duration(
//                                                                     milliseconds:
//                                                                         300),
//                                                             curve: Curves.ease,
//                                                           );
//                                                         }
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 height: 10,
//                                               ),
//                                               Container(
//                                                 height: 170,
//                                                 child: GridView.builder(
//                                                   physics:
//                                                       const NeverScrollableScrollPhysics(),
//                                                   gridDelegate:
//                                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                                     crossAxisCount: 4,
//                                                     mainAxisSpacing: 5.0,
//                                                     crossAxisSpacing: 4.0,
//                                                     childAspectRatio: 4 / 8,
//                                                   ),
//                                                   shrinkWrap: true,
//                                                   itemCount: _images.length,
//                                                   itemBuilder:
//                                                       (context, index) {
//                                                     return GestureDetector(
//                                                       onTap: () {
//                                                         // Set the current page of PageView to the selected image
//                                                         if (_currentPage > 0) {
//                                                           _pageController
//                                                               .animateToPage(
//                                                             index,
//                                                             duration:
//                                                                 const Duration(
//                                                                     milliseconds:
//                                                                         300),
//                                                             curve: Curves.ease,
//                                                           );
//                                                         } else if (_currentPage <
//                                                             _images.length -
//                                                                 1) {
//                                                           _pageController
//                                                               .animateToPage(
//                                                             index,
//                                                             duration:
//                                                                 const Duration(
//                                                                     milliseconds:
//                                                                         300),
//                                                             curve: Curves.ease,
//                                                           );
//                                                         }
//                                                       },
//                                                       child: CachedNetworkImage(
//                                                         imageUrl: _images[index]
//                                                             .bookingResultImg!,
//                                                         fit: BoxFit.contain,
//                                                         // height: 120,
//                                                         height: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .height /
//                                                             7.3,
//                                                         alignment:
//                                                             Alignment.topCenter,
//                                                         progressIndicatorBuilder:
//                                                             (context, url,
//                                                                     progress) =>
//                                                                 Center(
//                                                           child:
//                                                               CircularProgressIndicator(
//                                                             value: progress
//                                                                 .progress,
//                                                           ),
//                                                         ),
//                                                         errorWidget: (context,
//                                                                 url, error) =>
//                                                             Image.asset(
//                                                           "assets/images/default.png",
//                                                           fit: BoxFit.contain,
//                                                           // height: 120,
//                                                           height: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .height /
//                                                               7.3,
//                                                           alignment: Alignment
//                                                               .topCenter,
//                                                         ),
//                                                       ),
//                                                     );
//                                                   },
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                         : Container(),
//                                     _buildInfoUser(),
//                                     _buildService(),
//                                     const Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 10, horizontal: 10),
//                                       child: Divider(
//                                         color: Colors.black,
//                                         height: 2,
//                                         thickness: 1,
//                                       ),
//                                     ),
//                                     _buildTotalMoney(),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     _buildRating(),
//                                     _buildButton(),
//                                     const SizedBox(
//                                       height: 10,
//                                     )
//                                   ],
//                                 ),
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
//           // Ngày và giờ
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
//                 widget.booking!.bookingCode ?? "",
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
//                   "Ngày: ",
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//               Text(
//                 widget.booking!.appointmentDate ?? " ",
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
//                 widget.booking!.bookingServices != null
//                     ? widget.booking!.bookingServices!.first.startAppointment!
//                     : "",
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
//                   utf8.decode(
//                       widget.booking!.branchAddress.toString().runes.toList()),
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
//         widget.booking!.bookingServices != null
//             ? ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: widget.booking!.bookingServices!
//                     .length, // The number of items in the list
//                 itemBuilder: (context, index) {
//                   // Return a Card widget for each item in the list
//                   return Padding(
//                     padding: const EdgeInsets.only(
//                         top: 7, bottom: 7, left: 12, right: 12),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           constraints: const BoxConstraints(maxWidth: 280),
//                           child: Expanded(
//                             child: Text(
//                               utf8.decode(widget
//                                   .booking!.bookingServices![index].serviceName
//                                   .toString()
//                                   .runes
//                                   .toList()),
//                               style: const TextStyle(fontSize: 17),
//                               maxLines: 2,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           widget.booking!.bookingServices![index]
//                                       .servicePrice !=
//                                   null
//                               ? formatter.format(widget.booking!
//                                   .bookingServices![index].servicePrice)
//                               : '0',
//                           style: const TextStyle(fontSize: 17),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               )
//             : Container(),
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
//                 "Tổng Hóa Đơn:",
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
//     return Container(
//       width: 81.w,
//       margin: const EdgeInsets.symmetric(horizontal: 15),
//       padding: const EdgeInsets.all(0),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xff302E2E),
//               Color(0xe6444141),
//               Color(0x8c484646),
//               Color(0x26444141),
//             ]),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ElevatedButton(
//         onPressed: submitRating,
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//         ),
//         child: Text(
//           "Gửi đánh giá".toUpperCase(),
//           style: TextStyle(
//               fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
//         ),
//       ),
//     );
//   }

//   Widget _buildRating() {
//     return Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Đánh giá: ",
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
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: widget.booking!.bookingServices!.length,
//             itemBuilder: (context, index) {
//               double rating = 1.0;
//               TextEditingController comment = TextEditingController();
//               return widget.booking!.bookingServices![index].professional ==
//                           "MASSEUR" ||
//                       widget.booking!.bookingServices![index].staffId == null
//                   ? Container()
//                   : Padding(
//                       padding: const EdgeInsets.only(
//                           top: 10, bottom: 10, left: 10, right: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 utf8
//                                     .decode(widget.booking!
//                                         .bookingServices![index].serviceName!
//                                         .toString()
//                                         .runes
//                                         .toList())
//                                     .toUpperCase(),
//                                 maxLines: 2,
//                                 style: const TextStyle(fontSize: 18),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             constraints: const BoxConstraints(maxWidth: 280),
//                             child: Expanded(
//                               child: Text(
//                                 'Stylist-${widget.booking!.bookingServices![index].staffName != null ? utf8.decode(widget.booking!.bookingServices![index].staffName!.toString().runes.toList()) : ''} ',
//                                 maxLines: 1,
//                                 style: const TextStyle(
//                                     fontSize: 16,
//                                     overflow: TextOverflow.ellipsis),
//                               ),
//                             ),
//                           ),
//                           RatingBar.builder(
//                             initialRating: rating,
//                             minRating: 1,
//                             direction: Axis.horizontal,
//                             allowHalfRating: true,
//                             itemCount: 5,
//                             itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                             itemBuilder: (context, _) => Icon(
//                               Icons.star,
//                               color: Colors.amber,
//                             ),
//                             onRatingUpdate: (ratingValue) {
//                               rating = ratingValue;
//                               for (var ratingElement in ratings) {
//                                 if (ratingElement.bookingServiceId ==
//                                     widget.booking!.bookingServices![index]
//                                         .bookingServiceId) {
//                                   ratingElement.point = rating;
//                                 }
//                               }
//                               print(this.rating);
//                             },
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 5),
//                             child: TextField(
//                               controller: comment,
//                               keyboardType: TextInputType.multiline,
//                               maxLines: 4,
//                               style: const TextStyle(
//                                   height: 1.17,
//                                   fontSize: 20,
//                                   color: Colors.black),
//                               decoration: InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                       color: Color(0xffC4C4C4)),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                       color: Color(0xffC4C4C4)),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                       color: Color(0xffC4C4C4)),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 contentPadding: const EdgeInsets.only(
//                                     top: 5,
//                                     // bottom: 20,
//                                     left: 15,
//                                     right: 15),
//                                 hintText: "Viết đánh giá",
//                                 hintStyle: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xffC4C4C4)),
//                               ),
//                               onChanged: (commentValue) {
//                                 comment.text = commentValue;
//                                 for (var ratingElement in ratings) {
//                                   if (ratingElement.bookingServiceId ==
//                                       widget.booking!.bookingServices![index]
//                                           .bookingServiceId) {
//                                     ratingElement.feedback = comment.text;
//                                   }
//                                 }
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           )
//                         ],
//                       ),
//                     );
//             }),
//       ],
//     );
//   }

//   bool isLoading = true;
//   String stylist = '';
//   String massuer = '';
//   NumberFormat formatter = NumberFormat("#,##0");
//   double total = 0;
//   calTotal() {
//     if (widget.booking!.bookingServices != null) {
//       for (var service in widget.booking!.bookingServices!) {
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

//   List<BookingResultsModel> _images = [];
//   @override
//   void initState() {
//     calTotal();
//     setRating();
//     if (widget.booking!.bookingServices!.first.bookingResults != null) {
//       _images = widget.booking!.bookingServices!.first.bookingResults!;
//     }
//     super.initState();
//   }

//   int _selectedImageIndex = 0;
//   int _currentPage = 0;
//   PageController _pageController = PageController();
//   void _showFullScreenImage(BuildContext context, int initialIndex) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) =>
//             FullScreenImagePage(images: _images, initialIndex: initialIndex),
//       ),
//     );
//   }

//   double rating = 1;
//   List<RatingModel> ratings = [];

//   TextEditingController textRating = TextEditingController();
//   void setRating() {
//     try {
//       for (var bookingService in widget.booking!.bookingServices!) {
//         // kiểm tra xem thông tin bookingservice có rating chưa
//         if (bookingService.professional != "MASSEUR" &&
//             // bookingService.bookingServiceStatus == "PAID" &&
//             bookingService.staffId != null) {
//           RatingModel newRating = RatingModel(
//             staffId: bookingService.staffId,
//             bookingServiceId: bookingService.bookingServiceId,
//           );

//           ratings.add(newRating);
//         }
//       }
//     } catch (e) {}
//   }

//   Future<void> submitRating() async {
//     if (mounted) {
//       try {
//         bool isResult = false;
//         if (ratings.isNotEmpty) {
//           for (var ratingElement in ratings) {
//             // thêm điều kiện post hay up
//             bool isPostRating = true;

//             try {
//               final result;
//               if (isPostRating) {
//                 result = await RatingService().postRatings(ratingElement);
//               } else {
//                 // update rating
//                 int ratingId = 0;
//                 result =
//                     await RatingService().putRatings(ratingId, ratingElement);
//               }

//               if (result['statusCode'] == 200) {
//                 isResult = true;
//               } else if (result['statusCode'] == 500) {
//                 isResult = false;
//                 break;
//               } else {
//                 isResult = false;
//                 break;
//               }
//             } catch (e) {
//               break;
//             }
//           }
//           if (isResult) {
//             _successMessage("Gửi đánh giá thành công.");
//           } else {
//             _errorMessage("Vui lòng thử lại.");
//           }
//         }
//       } catch (e) {
//         print(e.toString());
//         _errorMessage("Vui lòng thử lại.");
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

//   void _successMessage(String? message) {
//     try {
//       ShowSnackBar.SuccessSnackBar(context, message!);
//     } catch (e) {
//       print(e);
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

// class FullScreenImagePage extends StatefulWidget {
//   final List<BookingResultsModel> images;
//   final int initialIndex;

//   const FullScreenImagePage(
//       {super.key, required this.images, required this.initialIndex});

//   @override
//   _FullScreenImagePageState createState() => _FullScreenImagePageState();
// }

// class _FullScreenImagePageState extends State<FullScreenImagePage> {
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: widget.initialIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//             backgroundColor: Colors.black,
//             iconTheme: const IconThemeData(color: Colors.white)),
//         body:
//             // Zoomed
//             InteractiveViewer(
//           child: PageView.builder(
//             controller: _pageController,
//             itemCount: widget.images.length,
//             itemBuilder: (context, index) {
//               return Center(
//                 // slide
//                 child: Hero(
//                   tag: 'selectedImage$index',
//                   child: CachedNetworkImage(
//                     imageUrl: widget.images[index].bookingResultImg!,
//                     progressIndicatorBuilder: (context, url, progress) =>
//                         Center(
//                       child: CircularProgressIndicator(
//                         value: progress.progress,
//                       ),
//                     ),
//                     errorWidget: (context, url, error) => Image.asset(
//                       "assets/images/default.png",
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

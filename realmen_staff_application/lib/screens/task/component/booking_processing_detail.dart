// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/screens/task/component/popup_change_staff.dart';
import 'package:realmen_staff_application/screens/task/component/popup_confirm.dart';
import 'package:realmen_staff_application/screens/task/service_booking_processing.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';

class BookingProcessingDetail extends StatefulWidget {
  final BookingContent booking;
  const BookingProcessingDetail({required this.booking, super.key});

  @override
  State<BookingProcessingDetail> createState() =>
      _BookingProcessingDetailState();
}

class _BookingProcessingDetailState extends State<BookingProcessingDetail>
    with AutomaticKeepAliveClientMixin {
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
        : Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Đơn cắt:  ${widget.booking.bookingCode}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Ngày:  ${widget.booking.appointmentDate}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Giờ:  ${widget.booking.bookingServices!.first.startAppointment}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              utf8.decode(widget.booking.bookingOwnerName
                                  .toString()
                                  .runes
                                  .toList()),
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
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              phone,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      // Center(
                      //   child: TextButton(
                      //     onPressed: () {
                      //       Get.to(const HistoryCustomerProcessingScreen());
                      //     },
                      //     child: const Text.rich(
                      //       TextSpan(
                      //         children: [
                      //           TextSpan(
                      //             text: "Xem lịch sử",
                      //             style: TextStyle(
                      //                 fontSize: 18,
                      //                 color: Colors.blueAccent,
                      //                 decoration: TextDecoration.underline,
                      //                 decorationStyle:
                      //                     TextDecorationStyle.solid),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dịch vụ: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          // Container(
                          //   height: 40,
                          //   decoration: BoxDecoration(
                          //       color: Colors.black54,
                          //       border: Border.all(
                          //         color: Colors.black54,
                          //         width: 1,
                          //         style: BorderStyle.solid,
                          //       ),
                          //       borderRadius: BorderRadius.circular(10)),
                          //   // margin: const EdgeInsets.all(10),
                          //   child: TextButton(
                          //     style: const ButtonStyle(
                          //       alignment: Alignment.center,
                          //       padding: MaterialStatePropertyAll(
                          //         EdgeInsets.symmetric(horizontal: 5),
                          //       ),
                          //     ),
                          //     onPressed: () {
                          //       setState(() {
                          //         Get.to(() => AddMoreServiceScreen(
                          //             widget.booking.bookingServices!));
                          //       });
                          //     },
                          //     child: const Center(
                          //       child: Text(
                          //         " + Thêm dịch vụ ",
                          //         style: TextStyle(
                          //             fontSize: 20, color: Colors.white),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
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
                      stylistServiceMuitl.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: stylistServiceMuitl.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      constraints:
                                          const BoxConstraints(minHeight: 40),
                                      color: Colors.grey.shade300,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 200),
                                            child: Text(
                                              "Stylist: ${utf8.decode(stylistServiceMuitl[index].name!.toString().runes.toList())}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 89,
                                              height: 30,
                                              margin: const EdgeInsets.only(
                                                  right: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                // color: Color(0xff207A20),
                                                color: stylistServiceMuitl[
                                                                index]
                                                            .isStylistServicesDone ==
                                                        "CHƯA LÀM"
                                                    ? Colors.white
                                                    : (stylistServiceMuitl[
                                                                    index]
                                                                .isStylistServicesDone ==
                                                            "ĐANG LÀM"
                                                        ? Colors.amberAccent
                                                        : const Color(
                                                            0xff207A20)),
                                                border: Border.all(
                                                    color: Colors.black54,
                                                    style: BorderStyle.solid),
                                              ),
                                              child: Center(
                                                child: stylistServiceMuitl[
                                                                index]
                                                            .isStylistServicesDone ==
                                                        "HOÀN THÀNH"
                                                    ? Text(
                                                        stylistServiceMuitl[
                                                                index]
                                                            .isStylistServicesDone!,
                                                        style: TextStyle(
                                                          fontSize: 11,

                                                          fontWeight:
                                                              FontWeight.w700,
                                                          // color: Colors.white,
                                                          color: stylistServiceMuitl[
                                                                          index]
                                                                      .isStylistServicesDone ==
                                                                  "HOÀN THÀNH"
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      )
                                                    : Text(
                                                        stylistServiceMuitl[
                                                                index]
                                                            .isStylistServicesDone!,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          // color: Colors.white,
                                                          color: stylistServiceMuitl[
                                                                          index]
                                                                      .isStylistServicesDone ==
                                                                  "HOÀN THÀNH"
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: stylistServiceMuitl[index]
                                          .bookingServiceList!
                                          .length,
                                      itemBuilder: (context, i) {
                                        return TimelineTile(
                                          // false la hien thanh

                                          isLast: false,
                                          beforeLineStyle: LineStyle(
                                              color: index + 1 !=
                                                      stylistServiceMuitl[index]
                                                          .bookingServiceList!
                                                          .length
                                                  ? Colors.black
                                                  : Colors.transparent,
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
                                                color: stylistServiceMuitl[index]
                                                                .bookingServiceList![
                                                                    i]
                                                                .bookingServiceStatus ==
                                                            "ONGOING" ||
                                                        stylistServiceMuitl[
                                                                    index]
                                                                .bookingServiceList![
                                                                    i]
                                                                .bookingServiceStatus ==
                                                            "LOCKED" ||
                                                        stylistServiceMuitl[
                                                                    index]
                                                                .bookingServiceList![
                                                                    i]
                                                                .bookingServiceStatus ==
                                                            "CONFIRM"
                                                    ? Colors.grey.shade300
                                                    : (stylistServiceMuitl[
                                                                    index]
                                                                .bookingServiceList![
                                                                    i]
                                                                .bookingServiceStatus ==
                                                            "PROCESSING"
                                                        ? Colors.amberAccent
                                                        : const Color(
                                                            0xff207A20)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${i + 1}",
                                                  style: TextStyle(
                                                      color: stylistServiceMuitl[
                                                                      index]
                                                                  .bookingServiceList![
                                                                      i]
                                                                  .bookingServiceStatus ==
                                                              "FINISHED"
                                                          ? Colors.white
                                                          : Colors.black,
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
                                                    utf8.decode(
                                                        stylistServiceMuitl[
                                                                index]
                                                            .bookingServiceList![
                                                                i]
                                                            .serviceName
                                                            .toString()
                                                            .runes
                                                            .toList()),
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                Container(
                                                  width: 89,
                                                  height: 30,
                                                  margin:
                                                      EdgeInsets.only(right: 5),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                    // color: Color(0xff207A20),
                                                    color: stylistServiceMuitl[index]
                                                                    .bookingServiceList![
                                                                        i]
                                                                    .bookingServiceStatus ==
                                                                "ONGOING" ||
                                                            stylistServiceMuitl[
                                                                        index]
                                                                    .bookingServiceList![
                                                                        i]
                                                                    .bookingServiceStatus ==
                                                                "LOCKED" ||
                                                            stylistServiceMuitl[
                                                                        index]
                                                                    .bookingServiceList![
                                                                        i]
                                                                    .bookingServiceStatus ==
                                                                "CONFIRM"
                                                        ? Colors.white
                                                        : (stylistServiceMuitl[
                                                                        index]
                                                                    .bookingServiceList![
                                                                        i]
                                                                    .bookingServiceStatus ==
                                                                "PROCESSING"
                                                            ? Colors.amberAccent
                                                            : const Color(
                                                                0xff207A20)),
                                                    border: Border.all(
                                                        color: Colors.black54,
                                                        style:
                                                            BorderStyle.solid),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      stylistServiceMuitl[index]
                                                                      .bookingServiceList![
                                                                          i]
                                                                      .bookingServiceStatus ==
                                                                  "ONGOING" ||
                                                              stylistServiceMuitl[
                                                                          index]
                                                                      .bookingServiceList![
                                                                          i]
                                                                      .bookingServiceStatus ==
                                                                  "LOCKED" ||
                                                              stylistServiceMuitl[
                                                                          index]
                                                                      .bookingServiceList![
                                                                          i]
                                                                      .bookingServiceStatus ==
                                                                  "CONFIRM"
                                                          ? "CHƯA LÀM"
                                                          : (stylistServiceMuitl[
                                                                          index]
                                                                      .bookingServiceList![
                                                                          i]
                                                                      .bookingServiceStatus ==
                                                                  "PROCESSING"
                                                              ? "ĐANG LÀM"
                                                              : "HOÀN THÀNH"),
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        // color: Colors.white,
                                                        color: stylistServiceMuitl[
                                                                        index]
                                                                    .bookingServiceList![
                                                                        i]
                                                                    .bookingServiceStatus ==
                                                                "FINISHED"
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              })
                          : Container(),
                      const SizedBox(
                        height: 15,
                      ),

                      masseurServices.isNotEmpty
                          ? Column(
                              children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(minHeight: 40),
                                  color: Colors.grey.shade300,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 200),
                                        child: Text(
                                          "Massuer:  ${utf8.decode(masseurServices.first.staffName!.toString().runes.toList())} ",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1),
                                        ),
                                      ),

                                      // status tổng dành cho massa
                                      Center(
                                        child: Container(
                                          width: 89,
                                          height: 30,
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          decoration: BoxDecoration(
                                            // color: Color(0xff207A20),
                                            color: isMasseurServicesDone ==
                                                    "CHƯA LÀM"
                                                ? Colors.white
                                                : (isMasseurServicesDone ==
                                                        "ĐANG LÀM"
                                                    ? Colors.amberAccent
                                                    : const Color(0xff207A20)),
                                            border: Border.all(
                                                color: Colors.black54,
                                                style: BorderStyle.solid),
                                          ),
                                          child: Center(
                                            child: isMasseurServicesDone ==
                                                    "HOÀN THÀNH"
                                                ? Text(
                                                    isMasseurServicesDone!,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      // color: Colors.white,
                                                      color:
                                                          isMasseurServicesDone ==
                                                                  "HOÀN THÀNH"
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                  )
                                                : Text(
                                                    isMasseurServicesDone!,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      // color: Colors.white,
                                                      color:
                                                          isMasseurServicesDone ==
                                                                  "HOÀN THÀNH"
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: masseurServices.length,
                                  itemBuilder: (context, index) {
                                    return TimelineTile(
                                      // false la hien thanh

                                      isLast: false,
                                      beforeLineStyle: LineStyle(
                                          color: index + 1 !=
                                                  masseurServices.length
                                              ? Colors.black
                                              : Colors.transparent,
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
                                            color: masseurServices[index].bookingServiceStatus ==
                                                        "ONGOING" ||
                                                    masseurServices[index]
                                                            .bookingServiceStatus ==
                                                        "LOCKED" ||
                                                    masseurServices[index]
                                                            .bookingServiceStatus ==
                                                        "CONFIRM"
                                                ? Colors.grey.shade300
                                                : (masseurServices[index]
                                                            .bookingServiceStatus ==
                                                        "PROCESSING"
                                                    ? Colors.amberAccent
                                                    : const Color(0xff207A20)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                  color: masseurServices[index]
                                                              .bookingServiceStatus ==
                                                          "FINISHED"
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        indicatorXY: 0.0,
                                      ),

                                      // content
                                      endChild: Container(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 0, left: 10),
                                        constraints:
                                            const BoxConstraints(minHeight: 80),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 194),
                                              child: Text(
                                                utf8.decode(
                                                    masseurServices[index]
                                                        .serviceName
                                                        .toString()
                                                        .runes
                                                        .toList()),
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              width: 89,
                                              height: 40,
                                              margin: EdgeInsets.only(right: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                // color: Color(0xff207A20),
                                                color: masseurServices[index].bookingServiceStatus ==
                                                            "ONGOING" ||
                                                        masseurServices[index]
                                                                .bookingServiceStatus ==
                                                            "LOCKED" ||
                                                        masseurServices[index]
                                                                .bookingServiceStatus ==
                                                            "CONFIRM"
                                                    ? Colors.white
                                                    : (masseurServices[index]
                                                                .bookingServiceStatus ==
                                                            "PROCESSING"
                                                        ? Colors.amberAccent
                                                        : const Color(
                                                            0xff207A20)),
                                                border: Border.all(
                                                    color: Colors.black54,
                                                    style: BorderStyle.solid),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  masseurServices[index]
                                                                  .bookingServiceStatus ==
                                                              "ONGOING" ||
                                                          masseurServices[index]
                                                                  .bookingServiceStatus ==
                                                              "LOCKED" ||
                                                          masseurServices[index]
                                                                  .bookingServiceStatus ==
                                                              "CONFIRM"
                                                      ? "CHƯA LÀM"
                                                      : (masseurServices[index]
                                                                  .bookingServiceStatus ==
                                                              "PROCESSING"
                                                          ? "ĐANG LÀM"
                                                          : "HOÀN THÀNH"),
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    // color: Colors.white,
                                                    color: masseurServices[
                                                                    index]
                                                                .bookingServiceStatus ==
                                                            "FINISHED"
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 55,
                      ),
                    ],
                  ),
                ),
              ),
              checkAllowUpdate
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 5),
                          margin:
                              EdgeInsets.only(right: 1, left: 1, bottom: 23),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(
                                        color: Colors.black54,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  // margin: const EdgeInsets.all(10),
                                  child: TextButton(
                                    onPressed: () {
                                      _btnRight();
                                    },
                                    child: Center(
                                      child: Text(
                                        btn.value!,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 25),
                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black54,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  // margin: const EdgeInsets.all(10),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Center(
                                      child: Text(
                                        "Vui lòng chờ nhân viên khác \nxong việc!",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    setDataBooking();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // @override
  // void didUpdateWidget(BookingProcessingDetail oldWidget) {
  //   setDataBooking();
  //   super.didUpdateWidget(oldWidget);
  // }

  List<BookingServiceModel> masseurServices = [];

  List<BookingServiceModel> stylistServices = [];

  List<MutilBookingService> stylistServiceMuitl = [];

  bool isMutil = false;

  Future<void> _btnRight() async {
    if (!_isDisposed && mounted) {
      int index = 0;
      if (btn.key == 0) {
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
            if (professional == "MASSEUR") {
              for (var service in masseurServices) {
                if (service.staffId == staffId) {
                  if (service.bookingServiceStatus == "ONGOING" ||
                      service.bookingServiceStatus == "CONFIRM") {
                    index = masseurServices.indexOf(service) + 1;
                    return PopUpConfirm(
                      service: service,
                      index: index,
                      bookingId: widget.booking.bookingId,
                    );
                  }
                }
              }
            } else if (professional == "STYLIST") {
              for (var service in stylistServices) {
                if (service.staffId == staffId) {
                  if (service.bookingServiceStatus == "ONGOING" ||
                      service.bookingServiceStatus == "CONFIRM") {
                    index = stylistServices.indexOf(service) + 1;
                    return PopUpConfirm(
                      service: service,
                      index: index,
                      bookingId: widget.booking.bookingId,
                    );
                  }
                }
              }
            }
            return Container(
              width: 0,
              height: 0,
            );
          },
        );
      } else if (btn.key == 1) {
        if (professional == "MASSEUR") {
          for (var service in masseurServices) {
            if (service.staffId == staffId) {
              if (service.bookingServiceStatus == "PROCESSING") {
                index = masseurServices.indexOf(service) + 1;
                Get.to(() => ServiceBookingProcessingScreen(
                      bookingId: widget.booking.bookingId,
                      professional: professional,
                      index: index,
                      service: service,
                    ));
                break;
              }
            }
          }
        } else if (professional == "STYLIST") {
          for (var service in stylistServices) {
            if (service.staffId == staffId) {
              if (service.bookingServiceStatus == "PROCESSING") {
                index = stylistServices.indexOf(service) + 1;

                Get.to(() => ServiceBookingProcessingScreen(
                      bookingId: widget.booking.bookingId,
                      professional: professional,
                      index: index,
                      service: service,
                    ));
                break;
              }
            }
          }
        }
      } else if (btn.key == 4) {}
    }
  }

  bool checkAllowUpdate = false;
  String phone = '';
  String? isMasseurServicesDone;
  String? isStylistServicesDone;
  bool isLoading = true;
  bool checkServiceBookingIsProcessing = false;
  bool checkBookingIsDone = false;
  int staffId = 0;
  final List<BtnStatus> btnStatus = [
    BtnStatus(key: 0, value: "bắt đầu phục vụ".toUpperCase()),
    BtnStatus(key: 1, value: "tiếp tục".toUpperCase()),
    BtnStatus(key: 2, value: "hoàn tất, chuyển qua stylist".toUpperCase()),
    BtnStatus(key: 3, value: "hoàn tất, chuyển qua MASSEUR".toUpperCase()),
    BtnStatus(key: 4, value: "Thanh toán".toUpperCase()),
  ];
  BtnStatus btn = BtnStatus();

  //
  Future<void> setDataBooking() async {
    if (!_isDisposed && mounted) {
      try {
        isLoading = true;
        // professional
        professional = await SharedPreferencesService.getProfessional();
        staffId = await SharedPreferencesService.getStaffId();
        // date
        DateTime appointmentDate =
            DateTime.parse(widget.booking.appointmentDate!);
        widget.booking.appointmentDate = formatDate(appointmentDate);

        // phone
        phone = widget.booking.bookingOwnerPhone!;
        phone = "x" * (phone.length - 3) + phone.substring(phone.length - 3);

        // masseurServices + stylistServices
        for (var bookingService in widget.booking.bookingServices!) {
          if (bookingService.professional == "MASSEUR") {
            masseurServices.add(bookingService);
          } else if (bookingService.professional == "STYLIST") {
            stylistServices.add(bookingService);
          }
        }
        // title massur
        if (masseurServices.isNotEmpty) {
          for (var service in masseurServices) {
            if (service.bookingServiceStatus == "ONGOING" ||
                service.bookingServiceStatus == "LOCKED" ||
                service.bookingServiceStatus == "CONFIRM") {
              isMasseurServicesDone = "CHƯA LÀM";
            } else if (service.bookingServiceStatus == "PROCESSING") {
              isMasseurServicesDone = "ĐANG LÀM";
            } else if (service.bookingServiceStatus == "FINISHED") {
              isMasseurServicesDone = "HOÀN THÀNH";
            }
          }
        }

        // set data stylist
        setDataStylist();
        // one to all
        if (stylistServiceMuitl.isNotEmpty) {
          for (var mutil in stylistServiceMuitl) {
            if (mutil.staffId == staffId) {
              for (var service in mutil.bookingServiceList!) {
                if (service.bookingServiceStatus == "ONGOING" ||
                    service.bookingServiceStatus == "LOCKED" ||
                    service.bookingServiceStatus == "CONFIRM") {
                  isStylistServicesDone = "CHƯA LÀM";
                } else if (service.bookingServiceStatus == "PROCESSING") {
                  isStylistServicesDone = "ĐANG LÀM";
                } else if (service.bookingServiceStatus == "FINISHED") {
                  isStylistServicesDone = "HOÀN THÀNH";
                }
              }
            }
          }
        }

        // checkBookingIsDone
        if (isStylistServicesDone == "HOÀN THÀNH" &&
            isMasseurServicesDone == "HOÀN THÀNH") {
          checkBookingIsDone = true;
        } else {
          checkBookingIsDone = false;
        }
        // checkServiceBookingIsProcessing = true ? "tiếp tục" : "bắt đầu phục vụ"
        // isStylistServicesDone or isMasseurServicesDone == "HOÀN THÀNH"
        //kiểm tra dv của staff đó đã xong chưa
        // checkBookingIsDone = true kiểm tra cả đơn đó xong chưa

        if (professional == "STYLIST" && isStylistServicesDone == "ĐANG LÀM") {
          btn = btnStatus[1];
        } else if (professional == "MASSEUR" &&
            isMasseurServicesDone == "ĐANG LÀM") {
          btn = btnStatus[1];
        } else {
          if (professional == "MASSEUR" &&
              isMasseurServicesDone == "HOÀN THÀNH" &&
              isStylistServicesDone != "HOÀN THÀNH") {
            btn = btnStatus[2];
          } else if (professional == "STYLIST" &&
              isMasseurServicesDone != "HOÀN THÀNH" &&
              isStylistServicesDone == "HOÀN THÀNH") {
            btn = btnStatus[3];
          } else if (isMasseurServicesDone == "HOÀN THÀNH" &&
              isStylistServicesDone == "HOÀN THÀNH") {
            btn = btnStatus[4];
          } else {
            btn = btnStatus[0];
          }
        }
        if (professional == "MASSEUR") {
          for (var service in masseurServices) {
            if (service.allowUpdate != null) {
              checkAllowUpdate = service.allowUpdate!;
            }
          }
        } else if (professional == "STYLIST") {
          if (stylistServiceMuitl.isNotEmpty) {
            for (var mutil in stylistServiceMuitl) {
              if (mutil.staffId == staffId) {
                for (var service in mutil.bookingServiceList!) {
                  if (service.allowUpdate != null) {
                    checkAllowUpdate = service.allowUpdate!;
                  }
                }
              }
            }
          }
        }
        if (!_isDisposed && mounted) {
          setState(() {
            checkAllowUpdate;
            isLoading = false;
            professional;
          });
        }
      } on Exception catch (e) {
        print(e.toString());
        isLoading = true;
      }
    }
  }

  void setDataStylist() {
//titile stylist
    // kiểm tra có 2 staff id trỏe lên kh
    staffId;
    stylistServiceMuitl = [];
    List<BookingServiceModel> newBookingServcie = [];
    //
    for (var service in stylistServices) {
      if (stylistServiceMuitl.isEmpty) {
        MutilBookingService newMutilBookingService = MutilBookingService(
          name: service.staffName,
          staffId: service.staffId,
          isStylistServicesDone: '',
          bookingServiceList: [],
        );
        stylistServiceMuitl.add(newMutilBookingService);
      } else if (stylistServiceMuitl
          .any((element) => element.staffId != service.staffId)) {
        MutilBookingService newMutilBookingService = MutilBookingService(
          name: service.staffName,
          staffId: service.staffId,
          isStylistServicesDone: '',
          bookingServiceList: [],
        );
        stylistServiceMuitl.add(newMutilBookingService);
      }
    }

    if (stylistServiceMuitl.isNotEmpty) {
      for (var serviceMutil in stylistServiceMuitl) {
        newBookingServcie = [];
        for (var service in stylistServices) {
          if (serviceMutil.staffId == service.staffId) {
            newBookingServcie.add(service);
          }
        }
        if (newBookingServcie.isNotEmpty) {
          serviceMutil.bookingServiceList!.addAll(newBookingServcie);
        }
      }
    }
    if (stylistServiceMuitl.isNotEmpty) {
      for (var serviceMutil in stylistServiceMuitl) {
        for (var service in serviceMutil.bookingServiceList!) {
          if (service.bookingServiceStatus == "ONGOING" ||
              service.bookingServiceStatus == "LOCKED" ||
              service.bookingServiceStatus == "CONFIRM") {
            isStylistServicesDone = "CHƯA LÀM";
          } else if (service.bookingServiceStatus == "PROCESSING") {
            isStylistServicesDone = "ĐANG LÀM";
          } else if (service.bookingServiceStatus == "FINISHED") {
            isStylistServicesDone = "HOÀN THÀNH";
          }
        }
        serviceMutil.isStylistServicesDone = isStylistServicesDone;
      }
    }
    isStylistServicesDone = '';
  }

  String professional = '';

  // ignore: unused_element
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

  Future<void> _btnLeft() async {
    if (!_isDisposed && mounted) {
      int index = 0;
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
          if (professional == "MASSEUR") {
            for (var service in masseurServices) {
              if (service.bookingServiceStatus == "ONGOING") {
                index = masseurServices.indexOf(service) + 1;
                return PopupChangeStaff(
                  service: service,
                  index: index,
                  bookingId: widget.booking.bookingId!,
                );
              }
            }
          } else if (professional == "STYLIST") {
            for (var service in stylistServices) {
              if (service.bookingServiceStatus == "ONGOING") {
                index = stylistServices.indexOf(service) + 1;
                return PopupChangeStaff(
                  service: service,
                  index: index,
                  bookingId: widget.booking.bookingId!,
                );
              }
            }
          }
          return Container(
            width: 0,
            height: 0,
          );
        },
      );
    }
  }
}

class BtnStatus {
  int? key;
  String? value;
  BtnStatus({this.key, this.value});
}

class MutilBookingService {
  int? staffId;
  String? name;
  String? isStylistServicesDone;
  List<BookingServiceModel>? bookingServiceList;
  MutilBookingService({
    this.staffId,
    this.name,
    this.isStylistServicesDone,
    this.bookingServiceList,
  });
}

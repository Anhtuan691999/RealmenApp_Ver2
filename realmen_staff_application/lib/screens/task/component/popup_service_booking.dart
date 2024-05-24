// ignore_for_file: must_be_immutable, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/service/booking/booking_service.dart';

class PopupServiceBooking extends StatefulWidget {
  List<File>? images;
  dynamic bookings;
  int? bookingServiceId, accountId;
  PopupServiceBooking({
    Key? key,
    this.images,
    required this.bookings,
    required this.accountId,
    required this.bookingServiceId,
  }) : super(key: key);

  @override
  State<PopupServiceBooking> createState() => _PopupServiceBookingState();
}

class _PopupServiceBookingState extends State<PopupServiceBooking> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "xác nhận hoàn thành dịch vụ".toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey.shade700,
            ),
            const SizedBox(
              height: 20,
            ),
            widget.images!.isNotEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          "Số lượng hình ảnh sau cắt chưa đủ 4 ảnh.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Colors.black,
                            wordSpacing: 1.3,
                          ),
                        )),
                        Center(
                            child: Text(
                          "Vui lòng quay lại chụp thêm.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        )),
                      ],
                    ),
                  )
                : const Column(
                    children: [
                      Center(
                          child: Text(
                        "Chưa có hình ảnh sau cắt.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      )),
                      Center(
                          child: Text(
                        "Khách hàng không muốn chụp có thể \"XÁC NHẬN\".",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Colors.black,
                          wordSpacing: 1.3,
                        ),
                      )),
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        "quay lại".toUpperCase(),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                widget.images!.isEmpty
                    ? Container(
                        width: 140,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.black54,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(10),
                        child: TextButton(
                          onPressed: btnFinishBookingService,
                          child: Center(
                            child: Text(
                              "xác nhận".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 140,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  List<String> imageList = [];
  BookingResultImgsModel bookingResultImgs =
      BookingResultImgsModel(bookingResultImgs: []);
  Future<void> btnFinishBookingService() async {
    if (!_isDisposed && mounted) {
      try {
        BookingService bookingService = BookingService();
        if (widget.bookingServiceId != null && widget.accountId != null) {
          final int bookingServiceId = widget.bookingServiceId!;
          final int accountId = widget.accountId!;
          final result = await bookingService.putFinishService(
              bookingServiceId, accountId, bookingResultImgs);
          if (result['statusCode'] == 200) {
            Get.toNamed(MainScreen.MainScreenRoute);
          } else {
            _errorMessage(result['message']);
            print(result);
          }
        }
      } on Exception catch (e) {
        _errorMessage("Vui lòng thử lại");
        print(e.toString());
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
}

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/screens/task/service_booking_processing.dart';
import 'package:realmen_staff_application/service/booking/booking_service.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';

class PopUpConfirm extends StatefulWidget {
  final BookingServiceModel? service;
  final int? index;
  final int? bookingId;

  const PopUpConfirm({
    Key? key,
    this.service,
    this.index,
    this.bookingId,
  }) : super(key: key);
  @override
  State<PopUpConfirm> createState() => _PopUpConfirmState();
}

class _PopUpConfirmState extends State<PopUpConfirm> {
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
                "xác nhận bắt đầu phục vụ".toUpperCase(),
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
            widget.service != null
                ? Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                height: 23,
                                width: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                ),
                                child: Center(
                                  child: Text(
                                    "${widget.index!}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const WidgetSpan(
                            child: SizedBox(
                              width: 5,
                            ),
                          ),
                          TextSpan(
                            text: utf8.decode(widget.service!.serviceName
                                .toString()
                                .runes
                                .toList()),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 35,
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
                Container(
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
                    onPressed: btnStartBookingService,
                    child: Center(
                      child: Text(
                        "xác nhận".toUpperCase(),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> btnStartBookingService() async {
    if (!_isDisposed && mounted) {
      try {
        final int bookingServiceId = widget.service!.bookingServiceId!;
        final int accountId = await SharedPreferencesService.getAccountId();
        BookingService bookingService = BookingService();
        final result =
            await bookingService.putStartService(bookingServiceId, accountId);
        if (result['statusCode'] == 200) {
          Get.to(() => ServiceBookingProcessingScreen(
                bookingId: widget.bookingId,
                professional: widget.service!.professional,
                index: widget.index,
                service: widget.service,
              ));
        } else {
          _errorMessage(result['message']);
          print(result['error']);
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

  // ignore: unused_element
  void _successMessage(String? message) {
    try {
      ShowSnackBar.SuccessSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }
}

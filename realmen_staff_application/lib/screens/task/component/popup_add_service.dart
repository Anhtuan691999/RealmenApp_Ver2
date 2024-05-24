// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_staff_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_staff_application/screens/task/booking_processing.dart';

class PopUpAddService extends StatefulWidget {
  PopUpAddService({super.key, required this.selectedBookingServices});
  List<serviceDemoModel> selectedBookingServices;

  @override
  State<PopUpAddService> createState() => _PopUpAddServiceState();
}

class _PopUpAddServiceState extends State<PopUpAddService> {
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
                "xác nhận thêm dịch vụ".toUpperCase(),
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
              height: 15,
            ),
            widget.selectedBookingServices.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.selectedBookingServices.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(
                          widget.selectedBookingServices[index].name.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: Text(
                      "Không có dịch vụ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
            const SizedBox(
              height: 20,
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
                widget.selectedBookingServices.isNotEmpty
                    ? Container(
                        width: 200,
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
                          onPressed: () {
                            // call api update service
                            Get.toNamed(MainScreen.MainScreenRoute);
                          },
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
                        width: 0,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:realmen_staff_application/screens/history_booking/components/card_history_hair_cut.dart';
import 'package:sizer/sizer.dart';

class HistoryBookingScreen extends StatefulWidget {
  const HistoryBookingScreen({super.key});

  @override
  State<HistoryBookingScreen> createState() => _HistoryBookingScreenState();
  static const String HistoryBookingScreenRoute = "/history-booking-screen";
}

class _HistoryBookingScreenState extends State<HistoryBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
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
                  child: ListView(
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
                                  icon: const Icon(Icons.keyboard_arrow_left),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Lịch sử đặt lịch".toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CardHistoryHairCut(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ))
      ],
    )

        //  SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Container(
        //         child: const Padding(
        //           padding: EdgeInsets.all(16.0),
        //           child: CardHistoryHairCut(),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}

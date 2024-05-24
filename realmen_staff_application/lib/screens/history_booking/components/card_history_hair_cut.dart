// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_staff_application/screens/history_booking/detail_history_hair_cut_screen.dart';

class CardHistoryHairCut extends StatefulWidget {
  const CardHistoryHairCut({super.key});

  @override
  State<CardHistoryHairCut> createState() => _CardHistoryHairCutState();
}

class _CardHistoryHairCutState extends State<CardHistoryHairCut> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Số lượng thẻ lịch sử cắt tóc
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.red,
                          size: 24,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Le Van Si",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("20/10/2023"),
                                    SizedBox(width: 10),
                                    Text("09:01"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/admin.png",
                            height: 170,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Stylist: Le Anh Tuan"),
                                    const SizedBox(height: 10),
                                    const Text("Skinner: Be Dep"),
                                    const SizedBox(height: 10),
                                    const Text("PTTT: The"),
                                    const SizedBox(height: 10),
                                    const Text("Tong Hoa Don: 355.000"),
                                    const SizedBox(height: 25),
                                    ElevatedButton(
                                      onPressed: () => Get.toNamed(
                                          DetailHistoryBookingScreen
                                              .DetailHistoryBookingScreenRoute),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                      ),
                                      child: const Text(
                                        'Xem chi tiết ->',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

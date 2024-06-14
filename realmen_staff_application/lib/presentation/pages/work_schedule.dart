// ignore_for_file: must_be_immutable, constant_identifier_names, unused_field, unused_local_variable, sized_box_for_whitespace, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class WorkScheduleScreen extends StatefulWidget {
  const WorkScheduleScreen({super.key});

  @override
  State<WorkScheduleScreen> createState() => _WorkScheduleState();
  static const String WorkScheduleScreenRoute = "/work-schedule-screen";
}

class _WorkScheduleState extends State<WorkScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
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
                child: Container(
                  padding: const EdgeInsets.only(top: 30),
                  width: 90.w,
                  height: 90.h,
                  // height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}

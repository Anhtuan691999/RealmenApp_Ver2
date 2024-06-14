// ignore_for_file: must_be_immutable, unnecessary_null_comparison, avoid_print, constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';

class RegisterWorkScheduleScreen extends StatefulWidget {
  const RegisterWorkScheduleScreen({super.key});

  @override
  State<RegisterWorkScheduleScreen> createState() =>
      _RegisterWorkScheduleScreenState();
  static const String RegisterWorkScheduleScreenRoute =
      "/register-work-schedule-screen";
}

class _RegisterWorkScheduleScreenState
    extends State<RegisterWorkScheduleScreen> {
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

// ignore_for_file: must_be_immutable, constant_identifier_names, unused_field, prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
  static const String ProfileScreenRoute = "/task-screen";
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
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
      ),
    );
  }
}

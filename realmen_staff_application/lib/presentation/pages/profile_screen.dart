// ignore_for_file: must_be_immutable, constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  static const String ProfileScreenRoute = "/profile-screen";
}

class _ProfileScreenState extends State<ProfileScreen> {
  //UI
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
                    fit: BoxFit.cover),
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
              ),
            ],
          ))
        ],
      ),
    );
  }

  // Logic
  @override
  void initState() {
    super.initState();
  }
}

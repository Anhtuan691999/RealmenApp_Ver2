// ignore_for_file: must_be_immutable, constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_staff_application/data/shared_preferences/auth_pref.dart';

import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  Function callback;
  ProfileScreen(this.callback, {super.key});

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: <Widget>[
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: avatarUrl ?? avatarDefault,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/default.png",
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: 70.w),
                            margin: const EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                name ?? '',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: Center(
                              child: Text(
                                phone ?? "",
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              width: 82.w,
                              margin: const EdgeInsets.only(top: 24),
                              padding: const EdgeInsets.only(top: 13),
                              height: 400,
                              child: Row(
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 82.w,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0x4D444444),
                                                width: 1.0),
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {},
                                          //   Get.toNamed(ViewEditProfileScreen
                                          //       .ViewEditProfileScreenRoute);
                                          // },
                                          style: TextButton.styleFrom(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                          ),
                                          child: Row(
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(
                                                  CommunityMaterialIcons
                                                      .account_circle,
                                                  color: Colors.black,
                                                  size: 24,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Thông tin tài khoản",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   width: 82.w,
                                      //   height: 40,
                                      //   decoration: const BoxDecoration(
                                      //     border: Border(
                                      //       top: BorderSide(
                                      //           color: Color(0x4D444444),
                                      //           width: 1.0),
                                      //     ),
                                      //   ),
                                      //   child: TextButton(
                                      //     onPressed: () {},
                                      //     style: TextButton.styleFrom(
                                      //       padding:
                                      //           const EdgeInsets.only(left: 0),
                                      //     ),
                                      //     child: Row(
                                      //       children: [
                                      //         const Align(
                                      //           alignment: Alignment.centerLeft,
                                      //           child: Icon(
                                      //             CommunityMaterialIcons
                                      //                 .history,
                                      //             color: Colors.black,
                                      //             size: 24,
                                      //           ),
                                      //         ),
                                      //         Container(
                                      //           margin: const EdgeInsets.only(
                                      //               left: 10.0),
                                      //           child: const Align(
                                      //             alignment:
                                      //                 Alignment.centerLeft,
                                      //             child: Text(
                                      //               "Lịch sử cắt tóc",
                                      //               style: TextStyle(
                                      //                   fontSize: 15,
                                      //                   fontWeight:
                                      //                       FontWeight.w400,
                                      //                   color: Colors.black),
                                      //             ),
                                      //           ),
                                      //         )
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      // Container(
                                      //   width: 82.w,
                                      //   height: 40,
                                      //   decoration: const BoxDecoration(
                                      //     border: Border(
                                      //       top: BorderSide(
                                      //           color: Color(0x4D444444),
                                      //           width: 1.0),
                                      //     ),
                                      //   ),
                                      //   child: TextButton(
                                      //     onPressed: () {},
                                      //     style: TextButton.styleFrom(
                                      //       padding:
                                      //           const EdgeInsets.only(left: 0),
                                      //     ),
                                      //     child: Row(
                                      //       children: [
                                      //         const Align(
                                      //           alignment: Alignment.centerLeft,
                                      //           child: Icon(
                                      //             CommunityMaterialIcons
                                      //                 .history,
                                      //             color: Colors.black,
                                      //             size: 24,
                                      //           ),
                                      //         ),
                                      //         Container(
                                      //           margin: const EdgeInsets.only(
                                      //               left: 10.0),
                                      //           child: const Align(
                                      //             alignment:
                                      //                 Alignment.centerLeft,
                                      //             child: Text(
                                      //               "KHÁCH ĐÃ CHECK-OUT",
                                      //               style: TextStyle(
                                      //                   fontSize: 15,
                                      //                   fontWeight:
                                      //                       FontWeight.w400,
                                      //                   color: Colors.black),
                                      //             ),
                                      //           ),
                                      //         )
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        width: 82.w,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0x4D444444),
                                                width: 1.0),
                                          ),
                                        ),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                          ),
                                          onPressed: () => AuthPref.logout(),
                                          child: Row(
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(
                                                  CommunityMaterialIcons.logout,
                                                  color: Color(0xffFF0000),
                                                  size: 24,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Đăng xuất',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xffFF0000)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
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
    name = AuthPref.getName();
    phone = AuthPref.getPhone();
  }

  String? name;
  String? phone;
  String? avatarUrl;

  String avatarDefault = "assets/images/default.png";
}

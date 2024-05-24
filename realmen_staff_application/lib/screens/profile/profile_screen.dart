// ignore_for_file: must_be_immutable, constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_staff_application/models/account/account_info_model.dart';
import 'package:realmen_staff_application/screens/login/login_phone_screen.dart';
import 'package:realmen_staff_application/screens/message/logout_popup.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';

import 'package:realmen_staff_application/screens/profile/view_edit_profile.dart';

import 'package:realmen_staff_application/service/account/account_info_service.dart';
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
                                          onPressed: () {
                                            Get.toNamed(ViewEditProfileScreen
                                                .ViewEditProfileScreenRoute);
                                          },
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
                                                    "Chỉnh sửa thông tin cơ bản",
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
                                          onPressed: _logout,
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
    getAccountInfo();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  AccountInfoModel? accountInfo = AccountInfoModel();
  String? name;
  String? phone;
  String? avatarUrl;
  final storage = FirebaseStorage.instance;
  String avatarDefault =
      "https://cdn.vectorstock.com/i/preview-1x/62/38/avatar-13-vector-42526238.jpg";

  Future<void> getAccountInfo() async {
    if (!_isDisposed) {
      try {
        AccountService accountService = AccountService();
        final result = await accountService.getAccountInfo();
        if (result['statusCode'] == 200) {
          accountInfo = result['data'] as AccountInfoModel;
          if (accountInfo!.thumbnailUrl != null &&
              accountInfo!.thumbnailUrl != "") {
            try {
              var reference = storage.ref(accountInfo!.thumbnailUrl);
              avatarUrl = await reference.getDownloadURL();
            } catch (e) {
              var reference = storage.ref('avatar/default.png');
              avatarUrl = await reference.getDownloadURL();
            }
          } else {
            var reference = storage.ref('avatar/default.png');
            avatarUrl = await reference.getDownloadURL();
          }
          if (!_isDisposed && mounted) {
            setState(() {
              name =
                  "${accountInfo!.firstName ?? ''} ${accountInfo!.lastName ?? ''}";
              name = utf8.decode(name!.runes.toList());
              phone = accountInfo!.phone ?? '';
              avatarUrl;
            });
          }
        } else {
          _errorMessage(result['message']);
          print(result);
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

  Future<void> _logout() async {
    if (!_isDisposed) {
      return showModalBottomSheet(
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: false,
        context: context,
        backgroundColor: Colors.white,
        barrierColor: const Color(0x8c111111),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) => const LogoutPopup(),
      );
    }
  }
}

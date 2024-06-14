// ignore_for_file: must_be_immutable, camel_case_types, use_build_context_synchronously, avoid_unnecessary_containers, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';

class branchShopNearYou extends StatefulWidget {
  branchShopNearYou(this.callback, {super.key});
  Function callback;

  @override
  State<branchShopNearYou> createState() => _branchShopNearYouState();
}

class _branchShopNearYouState extends State<branchShopNearYou> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: const Text(
            "Chi Nhánh Gần Bạn",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 331,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemCount: 5,
            itemBuilder: (context, index) {
              // final openBranchWidget =
              //     DateTime.parse("${branchesForCity![index].open}");
              // final closeBranchWidget =
              //     DateTime.parse('${branchesForCity![index].close}');

              // String openBranch = DateFormat.H().format(openBranchWidget);
              // String closeBranch =
              //     DateFormat.H().format(closeBranchWidget);
              String openBranch = "7:00";
              String closeBranch = "21:00";
              return InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  margin: const EdgeInsets.only(
                      left: 15, top: 5, bottom: 5, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: "assets/images/barber1.jpg",
                            height: 160,
                            width: MediaQuery.of(context).size.width / 1.4,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/barber1.jpg",
                              height: 160,
                              width: MediaQuery.of(context).size.width / 1.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                height: 50,
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Barber Name",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.location_on,
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                            ),
                                          ),
                                          const WidgetSpan(
                                            child: SizedBox(width: 4),
                                          ),
                                          TextSpan(
                                              text: "1.0 km",
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "123 Địa chỉ",
                                maxLines: 2,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 40,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xff444444),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${openBranch}h - ${closeBranch}h",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      widget.callback(2);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffE3E3E3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Container(
                                      height: 40,
                                      width: 120,
                                      padding: const EdgeInsets.all(0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            // margin: const EdgeInsets.only(left: 5.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'đặt lịch'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              CommunityMaterialIcons
                                                  .arrow_right,
                                              color: Colors.black,
                                              size: 24,
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
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Logic
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> urlList = [
    "barber1.jpg",
    "barber2.jpg",
    "barber3.jpg",
  ];
}
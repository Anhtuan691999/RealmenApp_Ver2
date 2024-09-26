// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:custom_rounded_rectangle_border/custom_rounded_rectangle_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/features/data/shared_preferences/auth_pref.dart';
import 'package:realmen_customer_application/features/presentation/home/bloc/home_page_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../pages/branches/branches_overview.dart';
import '../widgets/branch_shop_near_you.dart';
import '../widgets/card_holder_widget.dart';
import '../widgets/recoment_services.dart';
import '../widgets/top_barber.dart';

class HomePage extends StatefulWidget {
  final Function callback;
  const HomePage(
    this.callback, {
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
  static const String HomePageRoute = "/home-page";
}

class _HomePageState extends State<HomePage> {
  final HomePageBloc homePageBloc = HomePageBloc();
  String time = "sáng";
  String name = "";

  @override
  void initState() {
    homePageBloc.add(HomePageInitialEvent());
    super.initState();
    name = AuthPref.getNameCus();
    time = getTimeOfDay();
  }

  String getTimeOfDay() {
    final now = DateTime.now();
    if (now.hour >= 0 && now.hour < 12) {
      return "sáng";
    } else if (now.hour >= 12 && now.hour < 15) {
      return "trưa";
    } else if (now.hour >= 15 && now.hour < 19) {
      return "chiều";
    } else if (now.hour >= 19) {
      return "tối";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      bloc: homePageBloc,
      listenWhen: (previous, current) => current is HomePageActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ShowBranchOverviewPageState:
            Get.to(() => BranchesOverviewScreen(
                  bloc: homePageBloc,
                ));
            break;
        }
      },
      builder: (context, state) {
        HomePageLoadedSuccessState? successState;
        if (state is HomePageLoadedSuccessState) {
          successState = state;
        }
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.only(top: 20, left: 0),
                        width: 90.w,
                        height: 90.h,
                        // height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.topLeft,
                                child: Image.asset('assets/images/logo.png'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 70,
                                margin: const EdgeInsets.only(right: 15),
                                padding: const EdgeInsets.only(left: 25),
                                decoration: const ShapeDecoration(
                                  shape: CustomRoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    // leftSide: BorderSide.none,
                                    topRightCornerSide: BorderSide(
                                      width: 1,
                                      color: Color(0x73444444),
                                    ),
                                    bottomRightCornerSide: BorderSide(
                                      width: 1,
                                      color: Color(0x73444444),
                                    ),
                                    bottomSide: BorderSide(
                                      width: 1,
                                      color: Color(0x73444444),
                                    ),
                                    topSide: BorderSide(
                                      width: 1,
                                      color: Color(0x73444444),
                                    ),
                                    rightSide: BorderSide(
                                      width: 1,
                                      color: Color(0x73444444),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.white,
                                      width: 60,
                                      height: 60,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: "assets/images/Quang.jpg",
                                            fit: BoxFit.cover,
                                            width: 120,
                                            height: 120,
                                            progressIndicatorBuilder:
                                                (context, url, progress) =>
                                                    Center(
                                              child: CircularProgressIndicator(
                                                value: progress.progress,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              "assets/images/default.png",
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: 58.9.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            // ignore: unnecessary_null_comparison
                                            " ${time != null ? "Chào buổi $time," : ""} $name",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                          // const Text(
                                          //   "Level 1",
                                          //   style: TextStyle(
                                          //     fontWeight: FontWeight.w600,
                                          //     fontSize: 16,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.transparent,
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 3.5 / 3.2,
                                  children: [
                                    cardHolder(
                                      'Đặt lịch',
                                      Icons.calendar_month,
                                      const Color(0xffE3E3E3),
                                      () {
                                        widget.callback(2);
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        widget.callback(1);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                color: Color(0xffE3E3E3),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                CommunityMaterialIcons
                                                    .view_list_outline,
                                                color: Color(0xff323232),
                                                size: 24,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Dịch vụ'.toUpperCase(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        homePageBloc
                                            .add(ShowBranchOverviewPageEvent());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                color: Color(0xffE3E3E3),
                                                shape: BoxShape.circle,
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/icons/store-marker-outline.svg',
                                                // ignore: deprecated_member_use
                                                color: const Color(0xff323232),
                                                height: 24,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Chi nhánh'.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    // cardHolder(
                                    //   'Ưu Đãi',
                                    //   CommunityMaterialIcons
                                    //       .ticket_percent_outline,
                                    //   const Color(0xffE3E3E3),
                                    //   () {},
                                    // ),
                                    // cardHolder(
                                    //   'Realmen Member',
                                    //   CommunityMaterialIcons.crown,
                                    //   const Color(0xffE3E3E3),
                                    //   () {
                                    //     // Get.toNamed(
                                    //     //     MembershipScreen.MembershipScreenRoute);
                                    //   },
                                    // ),
                                    cardHolder(
                                      'Lịch sử đặt lịch',
                                      Icons.history,
                                      const Color(0xffE3E3E3),
                                      () {
                                        // Get.toNamed(HistoryBookingScreen
                                        //     .HistoryBookingScreenRoute);
                                      },
                                    ),
                                    cardHolder(
                                      'Lịch đặt của bạn',
                                      CommunityMaterialIcons
                                          .calendar_check_outline,
                                      const Color(0xffE3E3E3),
                                      () {
                                        // Get.toNamed(BookingProcessingScreen
                                        //     .BookingProcessingScreenRoute);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              state.runtimeType == HomePageLoadingState
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 30),
                                          height: 50,
                                          width: 50,
                                          child:
                                              const CircularProgressIndicator(),
                                        )
                                      ],
                                    )
                                  : state.runtimeType ==
                                          HomePageLoadedSuccessState
                                      ? Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RecommendServices(
                                                widget.callback,
                                                serviceList: successState!
                                                    .loadedServicesList,
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              barberTop(
                                                widget.callback,
                                                stylistList: successState
                                                    .loadedStylistsList,
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              branchShopNearYou(
                                                widget.callback,
                                                branchList: successState
                                                    .loadedBranchsList,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 30),
                                              height: 50,
                                              width: 50,
                                              child:
                                                  const CircularProgressIndicator(),
                                            )
                                          ],
                                        ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}

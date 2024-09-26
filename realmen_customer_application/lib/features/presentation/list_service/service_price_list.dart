import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/presentation/list_service/bloc/list_service_page_bloc.dart';
import 'package:sizer/sizer.dart';

class ServicePricePage extends StatefulWidget {
  Function? callback;
  ServicePricePage(this.callback, {super.key});

  @override
  State<ServicePricePage> createState() => _ServicePricePageState();
  static const String ServicePriceListScreenRoute =
      "/service-price-list-screen";
}

class _ServicePricePageState extends State<ServicePricePage> {
  final ListServicePageBloc listServicePageBloc = ListServicePageBloc();

  @override
  void initState() {
    super.initState();
    listServicePageBloc.add(SPLChooseServicePageInitialEvent());
  }

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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 90.w,
                    height: 90.h,
                    // height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: ListView(
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(left: 7),
                            child: Center(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: IconButton(
                                      alignment: Alignment.centerLeft,
                                      color: Colors.black,
                                      iconSize: 22,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_left),
                                      onPressed: () {
                                        widget.callback!(0);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "bảng dịch vụ".toUpperCase(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        BlocBuilder<ListServicePageBloc, ListServicePageState>(
                            bloc: listServicePageBloc,
                            builder: (context, state) {
                              NumberFormat formatter = NumberFormat("#,##0");

                              switch (state.runtimeType) {
                                case SPLChooseServicePageNoDataState:
                                  return Center(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          TextButton(
                                            onPressed: () =>
                                                listServicePageBloc.add(
                                                    SPLChooseServicePageInitialEvent()),
                                            child: const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Không tìm thấy Dịch vụ.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "Vui lòng thử lại.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                case SPLChooseServicePageLoadingPageState:
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 30),
                                        height: 50,
                                        width: 50,
                                        child:
                                            const CircularProgressIndicator(),
                                      )
                                    ],
                                  );
                                case SPLChooseServicePageLoadedSuccessState:
                                  SPLChooseServicePageLoadedSuccessState
                                      currentState = state
                                          as SPLChooseServicePageLoadedSuccessState;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.serviceCatagoryList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 4,
                                              ),
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black,
                                                    width: 8,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                currentState
                                                        .serviceCatagoryList[
                                                            index]
                                                        .title ??
                                                    "",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),

                                          // nôi dung card
                                          currentState
                                                  .serviceCatagoryList[index]
                                                  .services!
                                                  .isNotEmpty
                                              ? GridView.builder(
                                                  itemCount: currentState
                                                      .serviceCatagoryList[
                                                          index]
                                                      .services!
                                                      .length,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        2, // Thay đổi giá trị này nếu cần
                                                    crossAxisSpacing: 8.0,
                                                    mainAxisSpacing: 8.0,
                                                    childAspectRatio:
                                                        2 / 4, // width : height
                                                  ),
                                                  itemBuilder: (context, i) {
                                                    ServiceDataModel services =
                                                        currentState
                                                            .serviceCatagoryList[
                                                                index]
                                                            .services![i];

                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              8),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(8),
                                                              topLeft: Radius
                                                                  .circular(8),
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: services
                                                                  .shopServiceThumbnail!,
                                                              height: 200,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.4,
                                                              fit: BoxFit.cover,
                                                              progressIndicatorBuilder:
                                                                  (context, url,
                                                                          progress) =>
                                                                      Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  value: progress
                                                                      .progress,
                                                                ),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                "assets/images/massage.jpg",
                                                                height: 200,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.4,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        6.0,
                                                                    horizontal:
                                                                        10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  height: 60,
                                                                  child: Text(
                                                                    services.shopServiceName ??
                                                                        "",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    maxLines:
                                                                        2, // Số dòng tối đa
                                                                    softWrap:
                                                                        true, // Cho phép tự động xuống dòng
                                                                    style:
                                                                        const TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                // const SizedBox(
                                                                //   height: 9,
                                                                // ),
                                                                // SizedBox(
                                                                //   height: 60,
                                                                //   child: Text(
                                                                //     service.description ==
                                                                //             null
                                                                //         ? ''
                                                                //         : utf8.decode(service
                                                                //             .description!
                                                                //             .toString()
                                                                //             .runes
                                                                //             .toList()),
                                                                //     textAlign:
                                                                //         TextAlign
                                                                //             .start,
                                                                //     maxLines: 3,
                                                                //     style: const TextStyle(
                                                                //         color: Colors
                                                                //             .white,
                                                                //         fontSize:
                                                                //             15,
                                                                //         overflow:
                                                                //             TextOverflow
                                                                //                 .ellipsis),
                                                                //   ),
                                                                // ),
                                                                // const SizedBox(
                                                                //     height: 19),
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .white,
                                                                      style: BorderStyle
                                                                          .solid,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                  ),
                                                                  child: Text(
                                                                    // "${services.durationValue.toString()} ${utf8.decode(services.durationText.toString().runes.toList())}",
                                                                    "30 phút",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 7),
                                                                Text(
                                                                  services
                                                                      .shopServicePriceS!,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                        ],
                                      );
                                    },
                                  );
                              }
                              return const SizedBox();
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

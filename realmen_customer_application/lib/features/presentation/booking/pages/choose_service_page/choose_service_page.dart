// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api, constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_branch_booking/booking_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_service_page/bloc/choose_service_page_bloc.dart';

class ChooseServicesPage extends StatefulWidget {
  final int branchId;
  final BookingBloc bookingBloc;
  List<ServiceDataModel> selectedServices;

  @override
  _ChooseServicesPageState createState() => _ChooseServicesPageState();

  static const String ChooseServiceBookingPageRoute =
      "/choose-service-booking-page";

  ChooseServicesPage({
    super.key,
    required this.branchId,
    required this.bookingBloc,
    required this.selectedServices,
  });
}

class _ChooseServicesPageState extends State<ChooseServicesPage> {
  final ChooseServicePageBloc chooseServicePageBloc = ChooseServicePageBloc();
  @override
  void initState() {
    chooseServicePageBloc.add(ChooseServicePageInitialEvent(
        branchId: widget.branchId, selectedServices: widget.selectedServices));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.bookingBloc.add(ChooseBranchBookingSelectBranchGetBackEvent());
        return false;
      },
      child: Scaffold(
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
                    bottom: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.only(top: 15, left: 0),
                        width: 90.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              color: Colors.transparent,
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
                                        icon: const Icon(
                                            Icons.keyboard_arrow_left),
                                        onPressed: () {
                                          widget.bookingBloc.add(
                                              ChooseBranchBookingSelectServiceGetBackEvent());
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "chọn dịch vụ".toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BlocConsumer<ChooseServicePageBloc,
                                    ChooseServicePageState>(
                                bloc: chooseServicePageBloc,
                                listener: (context, state) {
                                  switch (state.runtimeType) {
                                    case ChooseServiceSelectedState:
                                      chooseServicePageBloc.add(
                                          ChooseServicePageLoadedSuccessEvent());
                                      break;
                                  }
                                },
                                builder: (context, state) {
                                  NumberFormat formatter =
                                      NumberFormat("#,##0");
                                  List<ServiceDataModel> selectedServices = [];

                                  switch (state.runtimeType) {
                                    case ChooseServicePageNoDataState:
                                      return Center(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              TextButton(
                                                onPressed: () =>
                                                    chooseServicePageBloc.add(
                                                        ChooseServicePageInitialEvent(
                                                            branchId:
                                                                widget.branchId,
                                                            selectedServices:
                                                                selectedServices)),
                                                child: const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Không tìm thấy Dịch vụ.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Vui lòng thử lại.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        decoration:
                                                            TextDecoration
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
                                    case ChooseServicePageLoadingPageState:
                                      return Column(
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
                                      );
                                    case ChooseServicePageLoadedSuccessState:
                                      ChooseServicePageLoadedSuccessState
                                          currentState = state
                                              as ChooseServicePageLoadedSuccessState;
                                      selectedServices =
                                          currentState.selectedServices;
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Dịch vụ đã chọn: ${selectedServices.length}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: state
                                                  .serviceCatagoryList.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(
                                                          8.0), // Điều chỉnh khoảng cách xung quanh tiêu đề
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 15,
                                                          vertical: 4,
                                                        ),
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            left: BorderSide(
                                                              color:
                                                                  Colors.black,
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
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    currentState
                                                            .serviceCatagoryList[
                                                                index]
                                                            .services!
                                                            .isNotEmpty
                                                        ? GridView.builder(
                                                            gridDelegate:
                                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount:
                                                                  2, // Thay đổi giá trị này nếu cần
                                                              crossAxisSpacing:
                                                                  8.0,
                                                              mainAxisSpacing:
                                                                  8.0,
                                                              childAspectRatio: 2 /
                                                                  3.33, // width : height
                                                            ),
                                                            shrinkWrap: true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemCount: currentState
                                                                .serviceCatagoryList[
                                                                    index]
                                                                .services!
                                                                .length,
                                                            itemBuilder:
                                                                (context, i) {
                                                              // return serviceLists[
                                                              //     index];
                                                              ServiceDataModel
                                                                  services =
                                                                  currentState
                                                                      .serviceCatagoryList[
                                                                          index]
                                                                      .services![i];
                                                              bool isSelected =
                                                                  selectedServices.any((service) =>
                                                                      service
                                                                          .branchServiceId ==
                                                                      services
                                                                          .branchServiceId);

                                                              return Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        2.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(8),
                                                                        topLeft:
                                                                            Radius.circular(8),
                                                                      ),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            services.shopServiceThumbnail!,
                                                                        height:
                                                                            140,
                                                                        width: MediaQuery.of(context).size.width /
                                                                            1.4,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        progressIndicatorBuilder: (context,
                                                                                url,
                                                                                progress) =>
                                                                            Center(
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            value:
                                                                                progress.progress,
                                                                          ),
                                                                        ),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            Image.asset(
                                                                          "assets/images/massage.jpg",
                                                                          height:
                                                                              140,
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 1.4,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                60,
                                                                            child:
                                                                                Text(
                                                                              services.shopServiceName ?? "",
                                                                              textAlign: TextAlign.start,
                                                                              style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          // const SizedBox(
                                                                          //     height:
                                                                          //         5),
                                                                          // SizedBox(
                                                                          //   height: 60,
                                                                          //   child: Text(
                                                                          //     widget.description ==
                                                                          //             null
                                                                          //         ? ''
                                                                          //         : utf8.decode(widget
                                                                          //             .description!
                                                                          //             .toString()
                                                                          //             .runes
                                                                          //             .toList()),
                                                                          //     textAlign:
                                                                          //         TextAlign
                                                                          //             .start,
                                                                          //     style:
                                                                          //         const TextStyle(
                                                                          //       color: Colors
                                                                          //           .white,
                                                                          //       fontSize:
                                                                          //           15,
                                                                          //     ),
                                                                          //   ),
                                                                          // ),
                                                                          // const SizedBox(
                                                                          //     height: 7),
                                                                          Text(
                                                                            services.shopServicePriceS!,
                                                                            style: const TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          400,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(15)),
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          chooseServicePageBloc
                                                                              .add(ChooseServiceSelectedEvent(selectedService: services));
                                                                        },
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              WidgetStateProperty.all<Color>(
                                                                            isSelected
                                                                                ? Colors.red
                                                                                : Colors.white,
                                                                          ),
                                                                          shape:
                                                                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8.0), // Độ bo tròn cho nút
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          isSelected
                                                                              ? 'Hủy'
                                                                              : 'Chọn',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color: isSelected
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          )
                                                        : Container()
                                                  ],
                                                );
                                              }),
                                          Positioned(
                                            bottom: 12.0,
                                            left: 20.0,
                                            right: 20.0,
                                            child: Container(
                                              height: 50,
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  widget.bookingBloc.add(
                                                      ChooseBranchBookingSelectedServiceEvent(
                                                          selectedServices:
                                                              selectedServices));
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all<
                                                          Color>(Colors.black),
                                                  shape: WidgetStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0), // Độ bo tròn cho nút
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  selectedServices.isEmpty
                                                      ? 'Chọn dịch vụ'
                                                          .toUpperCase()
                                                      : 'Chọn ${selectedServices.length} dịch vụ'
                                                          .toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                  }
                                  return const SizedBox();
                                })

                            // nội dung service list
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Button chọn các dịch vụ và quay lại
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //
  }

  // void updateSelectedServiceCount(
  //     bool isSelected, BranchServiceModel serviceName) {
  //   if (!_isDisposed && mounted) {
  //     setState(() {
  //       if (isSelected) {
  //         selectedServices.add(serviceName);
  //       } else {
  //         selectedServices.remove(serviceName);
  //       }
  //     });
  //     print(selectedServices);
  //   }
  // }
}

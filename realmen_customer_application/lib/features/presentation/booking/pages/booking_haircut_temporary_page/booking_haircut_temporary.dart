// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/booking_haircut_temporary_page/bloc/booking_haircut_temporary_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_account_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';

class BookingHaircutTemporary extends StatefulWidget {
  Function? callback;
  List<ServiceDataModel> selectedServices = [];
  BranchDataModel selectedBranch;

  Map<String, dynamic> selectedDate;
  DailyPlanAccountModel selectedStaff;
  String selectedTimeSlot;
  BookingHaircutTemporary({
    Key? key,
    this.callback,
    required this.selectedServices,
    required this.selectedBranch,
    required this.selectedDate,
    required this.selectedStaff,
    required this.selectedTimeSlot,
  }) : super(key: key);

  @override
  State<BookingHaircutTemporary> createState() =>
      _BookingHaircutTemporaryState();
  static const String BookingHaircutTemporaryScreenRoute =
      "/booking-temporary-screen";
}

class _BookingHaircutTemporaryState extends State<BookingHaircutTemporary> {
  BookingHaircutTemporaryBloc bloc = BookingHaircutTemporaryBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingHaircutTemporaryBloc,
        BookingHaircutTemporaryState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) {
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
                          padding: const EdgeInsets.only(top: 15, left: 0),
                          width: 90.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: ListView(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(left: 7),
                                child: Center(
                                  child: Stack(
                                    // mainAxisAlignment: MainAxisAlignment.center,
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
                                            Get.back();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "hóa đơn lịch đặt".toUpperCase(),
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
                              isLoading
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
                                  : Column(
                                      children: [
                                        _buildInfoUser(
                                            widget.selectedBranch,
                                            widget.selectedStaff,
                                            widget.selectedDate,
                                            widget.selectedTimeSlot),
                                        _buildService(widget.selectedServices),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Divider(
                                            color: Colors.black,
                                            height: 2,
                                            thickness: 1,
                                          ),
                                        ),
                                        // _buildButton(),
                                        _buildTotalMoney(),
                                        _buildButton(),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoUser(
      dynamic branch, dynamic stylist, dynamic date, dynamic time) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ngày và giờ
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Ngày: ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Text(
                date ?? " ",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
            ],
          ),

          // Giờ
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Giờ booking: ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Text(
                time != null ? "$time" : "",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          //Stylist
          const SizedBox(
            height: 12,
          ),
          // widget.oneToOne == null || !widget.oneToOne!
          //     ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Stylist: ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  stylist != null && stylist.accountId != null
                      ? utf8.decode(("${stylist.firstName} ${stylist.lastName}")
                          .toString()
                          .runes
                          .toList())
                      : "REALMEN sẽ chọn giúp anh",
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
          // : Container(),

          const SizedBox(height: 12),
          // Barber Shop:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Barber Shop: ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  utf8.decode(branch.address.toString().runes.toList()),
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildService(List<ServiceDataModel> service) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dịch vụ: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Divider(
            color: Colors.black,
            height: 2,
            thickness: 1,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: service != []
              ? service.length
              : 1, // The number of items in the list
          itemBuilder: (context, index) {
            // Return a Card widget for each item in the list
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 280),
                        child: Expanded(
                          child: Text(
                            service != []
                                ? "${service[index].shopServiceName}"
                                : "",
                            maxLines: 2,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Text(
                        service[index].shopServicePriceS != null
                            ? service[index].shopServicePriceS.toString()
                            : "0 VNĐ",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  // widget.oneToOne != null
                  //     ? widget.oneToOne!
                  //         ? Container(
                  //             constraints: const BoxConstraints(maxWidth: 280),
                  //             child: Expanded(
                  //               child: Text(
                  //                 service[index].thumbnailUrl == ''
                  //                     ? ''
                  //                     : 'Stylist- ${service[index].thumbnailUrl!.toString()}',
                  //                 maxLines: 2,
                  //                 style: const TextStyle(fontSize: 16),
                  //               ),
                  //             ),
                  //           )
                  //         : Container()
                  //     : Container(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTotalMoney() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       "Tổng Tiền:",
          //       style: TextStyle(
          //         fontSize: 17,
          //       ),
          //     ),
          //     // SizedBox(width: 140),
          //     Text(
          //       formatter.format(total),
          //       style: const TextStyle(fontSize: 17),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          // const Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Tổng Giảm Giá:",
          //       style: TextStyle(
          //         fontSize: 17,
          //       ),
          //     ),
          //     // SizedBox(width: 140),
          //     Text(
          //       "0",
          //       style: TextStyle(fontSize: 17),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 7,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tạm tính:",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(width: 140),
              Text(
                formatter.format(total),
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      width: 81.w,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff302E2E),
              Color(0xe6444141),
              Color(0x8c484646),
              Color(0x26444141),
            ]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: const Text(
          "Xác Nhận",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.add(BookingHaircutTemporaryInitialEvent());
    getTotal();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  int total = 0;
  getTotal() {
    for (var element in widget.selectedServices!) {
      if (element.branchServicePrice != null) {
        total += element.branchServicePrice!;
      } else if (element.branchServicePrice != null) {
        total += element.branchServicePrice!;
      }
    }
    setState(() {
      total;
    });
  }

  bool isLoading = true;
  NumberFormat formatter = NumberFormat("#,##0");

  List<int> massuerIdList = [];
  List<int> stylistIdList = [];

  String appointmentDate = '';
  DateFormat format = DateFormat.Hm();
  String bookingServiceType = "CHOSEN_STYLIST";
  int massuerId = 0;
  List<Map<String, dynamic>> noti = [];
}

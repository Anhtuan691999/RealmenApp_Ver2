// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_stylist_booking/choose_stylist_booking_bloc.dart';

import 'package:timeline_tile/timeline_tile.dart';

class CSChooseStylistBooking extends StatefulWidget {
  final ChooseStylistBookingBloc bloc;
  const CSChooseStylistBooking({
    super.key,
    required this.bloc,
  });

  @override
  State<CSChooseStylistBooking> createState() => _CSChooseStylistBookingState();
}

class _CSChooseStylistBookingState extends State<CSChooseStylistBooking> {
  @override
  void initState() {
    super.initState();
  }

  bool isActived = true;
  String buttonText = 'Tất cả Stylist REALMEN';
  bool hasSelectedServices = false;
  AccountModel stylistData = AccountModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseStylistBookingBloc, ChooseStylistBookingState>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (state is CSBSelectedStylistState) {
          buttonText =
              "${(state).selectedStylist.firstName.toString()} ${(state).selectedStylist.lastName.toString()}";
        }
        return TimelineTile(
          isLast: false,

          beforeLineStyle: isActived
              ? const LineStyle(color: Colors.black, thickness: 2)
              : const LineStyle(color: Colors.grey, thickness: 2),

          // icon
          indicatorStyle: IndicatorStyle(
            color: Colors.transparent,
            width: 35,
            height: 40,
            padding: const EdgeInsets.only(top: 4, bottom: 4, right: 5),
            indicator: Image.asset('assets/images/logo-no-text.png'),
            indicatorXY: 0.0,
          ),

          // content
          endChild: Container(
            padding: const EdgeInsets.only(top: 10, right: 15),
            constraints: const BoxConstraints(minHeight: 120),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "1. Chọn stylist",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.bloc.add(CSBShowStylistEvent());
                    // if (!_isDisposed) {
                    //   var selectedStylist = await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ChangeNotifierProvider<
                    //           ChangeNotifierServices>.value(
                    //         value: selectedServicesProvider,
                    //         child: const ChooseStylistScreen(),
                    //       ),
                    //     ),
                    //   );
                    //   if (selectedStylist != null) {
                    //     setState(() {
                    //       buttonText = selectedStylist.accountId != null
                    //           ? utf8.decode(
                    //               ("${selectedStylist.firstName!.substring(selectedStylist.firstName!.lastIndexOf(" ") + 1)} ${selectedStylist.lastName!}")
                    //                   .toString()
                    //                   .runes
                    //                   .toList())
                    //           : 'Tất cả Stylist REALMEN';
                    //       stylistData = selectedStylist;
                    //       widget.onStylistSelected(stylistData);
                    //       // ignore: unnecessary_null_in_if_null_operators
                    //       widget.onBranchSelected(stylistData.branch ?? null);
                    //     });
                    //   }
                    // }

                    // // Get.toNamed(ChooseBranchesScreen.ChooseBranchesScreenRoute);
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.only(right: 0, left: 10)),
                  child: Container(
                    // color: Colors.amber,
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: ClipRRect(
                            child: Row(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.perm_identity,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                                Flexible(
                                  child: ClipRRect(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        buttonText,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_right, color: Colors.black))
                      ],
                    ),
                  ),
                ),
                stylistData.accountId != null
                    ? Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: stylistData.thumbnail!,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                                  Center(
                                            child: CircularProgressIndicator(
                                              value: progress.progress,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Stylist: ",
                                                    style:
                                                        GoogleFonts.ebGaramond(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "${stylistData.firstName.toString()} ${stylistData.lastName.toString()}",
                                                    style:
                                                        GoogleFonts.ebGaramond(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          // RichText(
                                          //   text: TextSpan(
                                          //     children: [
                                          //       TextSpan(
                                          //         text: "Chuyên môn: ",
                                          //         style: GoogleFonts.ebGaramond(
                                          //           textStyle: const TextStyle(
                                          //               fontSize: 17,
                                          //               color: Colors.black,
                                          //               fontWeight:
                                          //                   FontWeight.w400),
                                          //         ),
                                          //       ),
                                          //       TextSpan(
                                          //         text:
                                          //             stylistData['specialization']
                                          //                 .join(', ')
                                          //                 .toString(),
                                          //         style: GoogleFonts.ebGaramond(
                                          //           textStyle: const TextStyle(
                                          //               fontSize: 18,
                                          //               color: Colors.black,
                                          //               fontWeight:
                                          //                   FontWeight.w500),
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                stylistData.branch != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            const Text(
                              "Chi nhánh theo stylist",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: CachedNetworkImage(
                                            imageUrl: stylistData
                                                .branch!.branchThumbnail!,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder:
                                                (context, url, progress) =>
                                                    Center(
                                              child: CircularProgressIndicator(
                                                value: progress.progress,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: utf8.decode(
                                                              stylistData
                                                                  .branch!
                                                                  .branchName
                                                                  .toString()
                                                                  .runes
                                                                  .toList()),
                                                          style: GoogleFonts
                                                              .ebGaramond(
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                RichText(
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: stylistData
                                                            .branch!
                                                            .branchAddress
                                                            .toString(),

                                                        //  "Cắt",
                                                        // utf8.decode(_selectedStylist!.name
                                                        //     .toString()
                                                        //     .runes
                                                        //     .toList()),
                                                        style: GoogleFonts
                                                            .ebGaramond(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ])
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_account_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_branch_booking/booking_bloc.dart';

class BCSChooseStaff extends StatefulWidget {
  final List<DailyPlanAccountModel> accountStaffList;
  final BookingBloc bloc;
  const BCSChooseStaff({
    super.key,
    required this.accountStaffList,
    required this.bloc,
  });

  @override
  State<BCSChooseStaff> createState() => _BCSChooseStaffState();
}

class _BCSChooseStaffState extends State<BCSChooseStaff> {
  DailyPlanAccountModel selectedStaff = DailyPlanAccountModel();
  bool isDefaultSelected = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (state is BranchChooseSelectedStaffState) {
          selectedStaff = state.selectedStaff;
          isDefaultSelected = state.isDefaultSelected;
        }
        return ExpansionTile(
          shape: const Border(bottom: BorderSide.none),
          title: Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.black,
                size: 16,
              ),
              const SizedBox(width: 10),
              Text(
                selectedStaff.accountId != null
                    ? "${selectedStaff.fullName}"
                    : "Chọn Stylist",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.bloc
                              .add(BranchChooseSelectDefaultStaffEvent());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 0, left: 0, right: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 72,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isDefaultSelected
                                            ? Colors.black
                                            : Colors.transparent,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.black,
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20,
                                          child: ClipOval(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "assets/images/logo-no-text.png",
                                                scale: 1,
                                                fit: BoxFit.fitHeight,
                                                width: 70,
                                                height: 70,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  isDefaultSelected
                                      ? Positioned(
                                          bottom: 1,
                                          right: 4,
                                          child: Container(
                                            height: 22,
                                            width: 22,
                                            // color: Colors.white,
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.black,
                                              child: ClipOval(
                                                child: Icon(
                                                  Icons.done,
                                                  size: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 76),
                                  child: const Text(
                                    "REALMEN sẽ chọn hộ bạn ",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      widget.accountStaffList.isNotEmpty
                          ? SizedBox(
                              width: 245,
                              height: 142,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(left: 0),
                                  itemCount: widget.accountStaffList.length,
                                  itemBuilder: (context, index) {
                                    final stylist =
                                        widget.accountStaffList[index];
                                    final isSelected = stylist == selectedStaff;

                                    return GestureDetector(
                                      onTap: () {
                                        widget.bloc.add(
                                            BranchChooseSelectStaffEvent(
                                                selectedStaff: stylist));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 0,
                                            left: 0,
                                            right: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  width: 72,
                                                  height: 72,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? Colors.black
                                                          : Colors.transparent,
                                                      width: 1,
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.white,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Center(
                                                    child: Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: 1,
                                                          style:
                                                              BorderStyle.solid,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors.black,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 20,
                                                        child: ClipOval(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: stylist
                                                                .thumbnail!,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const CircularProgressIndicator(),
                                                            fit: BoxFit.cover,
                                                            width: 70,
                                                            height: 70,
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Image.asset(
                                                              "assets/images/s1.jpg",
                                                              fit: BoxFit.cover,
                                                              width: 70,
                                                              height: 70,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                isSelected
                                                    ? Positioned(
                                                        bottom: 1,
                                                        right: 4,
                                                        child: Container(
                                                          height: 22,
                                                          width: 22,
                                                          // color: Colors.white,
                                                          child:
                                                              const CircleAvatar(
                                                            backgroundColor:
                                                                Colors.black,
                                                            child: ClipOval(
                                                              child: Icon(
                                                                Icons.done,
                                                                size: 18,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 76),
                                                child: Text(
                                                  "${stylist.fullName}",
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )),
                                            isSelected
                                                ? const Icon(
                                                    Icons.keyboard_arrow_up,
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

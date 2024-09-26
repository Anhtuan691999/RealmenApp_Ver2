// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable, avoid_unnecessary_containers, library_private_types_in_public_api, non_constant_identifier_names

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_account_model.dart';
import 'package:realmen_customer_application/features/data/models/working_slot_model.dart';
import 'package:realmen_customer_application/features/data/models/working_slot_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_branch_booking/booking_bloc.dart';

class BCSChooseTimeSlot extends StatefulWidget {
  final BookingBloc bloc;
  final DailyPlanAccountModel selectedStaff;
  const BCSChooseTimeSlot({
    super.key,
    required this.bloc,
    required this.selectedStaff,
  });

  @override
  State<BCSChooseTimeSlot> createState() => _BCSChooseTimeSlotState();
}

class _BCSChooseTimeSlotState extends State<BCSChooseTimeSlot> {
  String _selectedTimeSlot = '';
  List<Widget> timeSlotCards = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget TimeSlotCard(TimeSlotCardModel timeSlotCard) {
      bool isSelected = false;
      isSelected = timeSlotCard.timeSlot == _selectedTimeSlot;
      var backgroundColor = isSelected
          ? (timeSlotCard.type == "Ngày thường"
              ? const Color(0xff207A20)
              : const Color(0xff964444))
          : (timeSlotCard.isSelectable ? Colors.white : Colors.grey);
      var textColor = isSelected ? Colors.white : Colors.black;

      return GestureDetector(
        onTap: () {
          if (timeSlotCard.isSelectable) {
            widget.bloc
                .add(onTimeSlotSelectedEvent(timeSlot: timeSlotCard.timeSlot));
          }
        },
        child: Container(
          // height: 20.0,
          // width: 40.0,
          decoration: BoxDecoration(
            border: timeSlotCard.isSelectable
                ? Border.all(color: Colors.black, width: 1.0)
                : null,
            borderRadius: BorderRadius.circular(5.0),
            color: backgroundColor,
          ),
          child: Center(
            child: Text(
              timeSlotCard.timeSlot,
              style: TextStyle(fontSize: 23, color: textColor),
            ),
          ),
        ),
      );
    }

    return BlocBuilder<BookingBloc, BookingState>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (state is BranchChooseStaffLoadedState) {
          widget.bloc.add(GetTimeSlotEvent());
        } else if (state is BranchChooseTimeSlotLoadedState) {
          timeSlotCards = [];
          for (TimeSlotCardModel timeSlot
              in (state).timeSlotCards) {
            timeSlotCards.add(TimeSlotCard(timeSlot));
            _selectedTimeSlot = '';
          }
        } else if (state is BranchChooseSelectedTimeSlotState) {
          timeSlotCards = [];
          _selectedTimeSlot =
              (state).selectedTimeSlot;
          for (TimeSlotCardModel timeSlot
              in (state).timeSlotCards) {
            timeSlotCards.add(TimeSlotCard(timeSlot));
          }
        } else if (state is BranchChooseSelectedStaffState) {
          widget.bloc.add(GetTimeSlotEvent());
        }

        // listDate!.isNotEmpty
        //     ?
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Giờ hẹn:",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          _selectedTimeSlot,
                          style: const TextStyle(fontSize: 23),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Center(
                    child: SizedBox(
                      width: 230.0,
                      height: 220.0, // Limit height

                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        // controller: scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 1 / 1.5),
                        itemCount: timeSlotCards.length,
                        itemBuilder: (BuildContext context, int index) {
                          return timeSlotCards[index];
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        // : Column(
        //     children: [
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       widget.selectedStaff.accountId != null
        //           ? Center(
        //               child: Text(
        //                   "Thợ cắt ${widget.selectedStaff.nickName} hiện chưa có lịch làm!"),
        //             )
        //           : const Center(
        //               child: Text("Anh vui lòng chọn thợ cắt khác"),
        //             )
        //     ],
        //   );
      },
    );
  }
}

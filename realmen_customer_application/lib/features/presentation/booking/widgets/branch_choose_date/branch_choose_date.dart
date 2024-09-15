import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch_choose_date/bloc/branch_choose_date_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ChooseDateBooking extends StatefulWidget {
  final BookingBloc bloc;
  const ChooseDateBooking({
    super.key,
    required this.bloc,
  });

  @override
  State<ChooseDateBooking> createState() => _ChooseDateBookingState();
}

class _ChooseDateBookingState extends State<ChooseDateBooking> {
  final BranchChooseDateBloc _branchChooseDateBloc = BranchChooseDateBloc();
  @override
  void initState() {
    super.initState();
    _branchChooseDateBloc.add(BranchChooseDateInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchChooseDateBloc, BranchChooseDateState>(
      bloc: _branchChooseDateBloc,
      builder: (context, state) {
        String? dateController;
        String? type;
        List<Map<String, dynamic>> listDate = [];
        Map<String, dynamic>? dateSeleted;
        if (state is LoadDateState) {
          dateController = state.dateController;
          dateSeleted = state.dateSeleted;
          listDate = state.listDate!;
          type = state.type;
        } else if (state is BranchChooseSelectDateState) {
          dateController = state.dateController;
          dateSeleted = state.dateSeleted;
          type = state.type;
          // widget.bloc.add(ChooseDateBookingSelectedDateEvent());
        }
        return TimelineTile(
          // false la hien thanh
          isLast: false,
          beforeLineStyle: const LineStyle(color: Colors.black, thickness: 2),

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
              height: 150,
              padding: const EdgeInsets.only(top: 10, right: 15),
              constraints: const BoxConstraints(minHeight: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "2. Chọn ngày ",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 0, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 1.5),
                            blurRadius: 1,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                            listDate.isNotEmpty
                                ? Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          alignment: Alignment.center,
                                          value: dateController,
                                          items: listDate != null
                                              ? listDate
                                                  .asMap()
                                                  .entries
                                                  .map(
                                                    (item) => DropdownMenuItem(
                                                      value: item.value['id'],
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 5,
                                                                bottom: 5,
                                                                left: 0),
                                                        // width: 220,
                                                        // height: 40,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          10.0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      item.value[
                                                                              'date']
                                                                          as String,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            item.value['type'] ==
                                                                    "Ngày thường"
                                                                ? Container(
                                                                    width: 100,
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            5,
                                                                        vertical:
                                                                            5),
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: Color(
                                                                          0xff207A20),
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        "Ngày thường",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    width: 100,
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            5,
                                                                        vertical:
                                                                            5),
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: Color(
                                                                          0xff964444),
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        "Cuối tuần",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList()
                                              : [],
                                          onChanged: (value) {
                                            // setstate
                                            // setState(() {
                                            //   dateController = value as String?;
                                            //   dateSeleted = listDate!
                                            //       .where((date) =>
                                            //           date['id'] == value.toString())
                                            //       .toList()
                                            //       .first;
                                            //   print("onchange: $dateSeleted");
                                            //   type = dateSeleted!['type'].toString();
                                            //   type == "Thứ bảy" || type == "Chủ nhật"
                                            //       ? type = "Cuối tuần"
                                            //       : type = "Ngày thường";
                                            //   isCurrentDate = _isCurrentDate(
                                            //       dateSeleted!['date']);
                                            //   widget.onDateSelected(dateSeleted);
                                            //   if (widget.oneToOne) {
                                            //     widget.choseDateUpdateStylist!(
                                            //         dateSeleted!['chosenDate']);
                                            //   } else {
                                            //     getTimeSlot(
                                            //         dateSeleted!['chosenDate']);
                                            //   }
                                            // });

                                            // timeSlotKey.currentState
                                            //     ?.rebuildTimeslot();
                                          },
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: 200,
                                            width: 325,
                                            padding: const EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              // borderRadius: BorderRadius.circular(14),
                                              color: Colors.grey.shade200,
                                            ),
                                            offset: const Offset(-35, -6),
                                            scrollbarTheme: ScrollbarThemeData(
                                              // radius: const Radius.circular(40),
                                              // thickness: MaterialStateProperty.all(6),
                                              thumbVisibility:
                                                  WidgetStateProperty.all(
                                                      true),
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                            padding: EdgeInsets.only(
                                                left: 35, right: 24),
                                          ),
                                          buttonStyleData:
                                              const ButtonStyleData(
                                            padding: EdgeInsets.all(0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
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
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

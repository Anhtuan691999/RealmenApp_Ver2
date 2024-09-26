// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_account_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch/BCS_choose_staff.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch/BCS_choose_time_slot.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_branch_booking/booking_bloc.dart';

class ChooseStaffBooking extends StatefulWidget {
  final BookingBloc bloc;

  const ChooseStaffBooking({
    super.key,
    required this.bloc,
  });

  @override
  State<ChooseStaffBooking> createState() => _ChooseStaffBookingState();
}

class _ChooseStaffBookingState extends State<ChooseStaffBooking> {
  String? staffOtpController;
  List<DailyPlanAccountModel> _accountStylistList = [];
  List<DailyPlanAccountModel> _accountMassurList = [];
  List<ServiceDataModel> selectedServicesStylist = [];
  List<ServiceDataModel> selectedServicesMassur = [];
  List<String> options = [
    'Chọn stylist cho Tất cả dịch vụ',
    'Chọn stylist cho Mỗi dịch vụ'
  ];
  DailyPlanAccountModel selectedStaff = DailyPlanAccountModel();

  @override
  void initState() {
    super.initState();
    staffOtpController = options.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (state is BranchChooseDateLoadDateState) {
          widget.bloc.add(BranchChooseStaffLoadedEvent());
        } else if (state is BranchChooseSelectDateState) {
          widget.bloc.add(BranchChooseStaffLoadedEvent());
        } else if (state is BranchChooseStaffLoadedState) {
          BranchChooseStaffLoadedState currentState =
              state;
          _accountStylistList = currentState.accountStylistList!;
          _accountMassurList = currentState.accountMassurList!;
          selectedServicesStylist = currentState.selectedServicesStylist;
          selectedServicesMassur = currentState.selectedServicesMassur;
        } else if (state is BranchChooseSelectedStaffState) {
          BranchChooseSelectedStaffState currentState =
              state;
          selectedStaff = currentState.selectedStaff;
        }
        print("selectedServicesStylist  ${selectedServicesStylist.length}");

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // selectedServicesStylist.length >= 2
            //     ? ClipRRect(
            //         borderRadius: BorderRadius.circular(5),
            //         child: Container(
            //           height: 40,
            //           padding: const EdgeInsets.only(
            //               left: 10, right: 0, top: 1, bottom: 1),
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //               color: Colors.grey,
            //               width: 1,
            //               style: BorderStyle.solid,
            //             ),
            //             borderRadius: BorderRadius.circular(5),
            //             color: Colors.white,
            //             boxShadow: const [
            //               BoxShadow(
            //                 color: Colors.black26,
            //                 offset: Offset(0, 1.5),
            //                 blurRadius: 1,
            //                 spreadRadius: 0,
            //               ),
            //             ],
            //           ),
            //           child: DropdownButtonHideUnderline(
            //             child: DropdownButton2<String>(
            //               isExpanded: true,
            //               hint: Text(
            //                 'Chọn stylist cho Tất cả dịch vụ',
            //                 style: TextStyle(
            //                   overflow: TextOverflow.ellipsis,
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.w400,
            //                   color: Theme.of(context).hintColor,
            //                 ),
            //               ),
            //               alignment: Alignment.center,
            //               value: staffOtpController,
            //               items: options != [] && options.isNotEmpty
            //                   ? options
            //                       .map((option) => DropdownMenuItem<String>(
            //                             value: option,
            //                             child: Text(
            //                               option,
            //                               style: const TextStyle(
            //                                 fontSize: 15,
            //                                 fontWeight: FontWeight.w400,
            //                                 color: Colors.black,
            //                                 overflow: TextOverflow.ellipsis,
            //                               ),
            //                             ),
            //                           ))
            //                       .toList()
            //                   : [],
            //               onChanged: (option) => {}
            //               // setState(() {
            //               //   optionController = option!;
            //               //   print(optionController);
            //               //   setData();
            //               //   if (optionController ==
            //               //       'Chọn stylist cho Tất cả dịch vụ') {
            //               //     widget.onUpdateOption(false);
            //               //   } else {
            //               //     widget.onUpdateOption(true);
            //               //   }
            //               //   isChangeOptional = true;
            //               //   // getBranches(option, false);
            //               // })
            //               ,
            //               dropdownStyleData: DropdownStyleData(
            //                 maxHeight: 200,
            //                 width: 325,
            //                 padding: const EdgeInsets.all(0),
            //                 decoration: BoxDecoration(
            //                   // borderRadius: BorderRadius.circular(14),
            //                   color: Colors.grey.shade200,
            //                 ),
            //                 offset: const Offset(-10, -6),
            //                 scrollbarTheme: ScrollbarThemeData(
            //                   // radius: const Radius.circular(40),
            //                   // thickness: MaterialStateProperty.all(6),
            //                   thumbVisibility: MaterialStateProperty.all(true),
            //                 ),
            //               ),
            //               menuItemStyleData: const MenuItemStyleData(
            //                 height: 40,
            //                 padding: EdgeInsets.only(left: 35, right: 24),
            //               ),
            //               buttonStyleData: const ButtonStyleData(
            //                 padding: EdgeInsets.all(0),
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     : Container(),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       margin: const EdgeInsets.only(top: 30),
            //       height: 50,
            //       width: 50,
            //       child: const CircularProgressIndicator(),
            //     )
            //   ],
            // ),
            staffOtpController == 'Chọn stylist cho Mỗi dịch vụ'
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: stylistService.asMap().entries.map((item) {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           SizedBox(
                      //             height: 20,
                      //           ),

                      //           // Service
                      //           Text(
                      //             "${item.key + 1}.${utf8.decode(item.value.serviceName.toString().runes.toList())}"
                      //                 .toUpperCase(),
                      //             style: TextStyle(
                      //                 fontSize: 18, color: Colors.black),
                      //           ),

                      //           // Chọn Stylist
                      //           ChooseStylist(),
                      //         ],
                      //       );
                      //     }).toList()),
                      // SizedBox(
                      //   height: 50,
                      // ),

                      // Time Slot
                      // ChooseDateAndTimeSlot(
                      //   // hàm trả ngày chọn
                      //   onDateSelected: widget.onDateSelected,

                      //   // hàm trả timeslot chọn
                      //   onTimeSelected: widget.onTimeSelected,

                      //   // thay bằng serviceOTOList
                      //   stylistSelected: null,
                      //   isChangeStylist: isChangeStylist,

                      //   // One by One
                      //   oneToOne: true,

                      //   // truyền service chỉ cho STYLIST
                      //   serviceOTOList: serviceOTOList,

                      //   // truyền stylist đã đc chọn để kiểm tra với post booking
                      //   staffOneToOne: staffOneToOne,

                      //   // truyền data staff cho One To One
                      //   accountStaffBranchList: accountStaffBranchList,

                      //   // Hàm để nhận data về thay đổi lịch là đổi ngi
                      //   onSetStylistShowOTO: setStylistShowOTO,

                      //   // lịch của 1 thg đại diện, dựa vào nó
                      //   // để làm drop dowwn
                      //   listDate: listDate,
                      //   isChangeOptional: isChangeOptional,

                      //   //
                      //   allowUpdateTimeslot: allowUpdateTimeslot,
                      //   updateStylistDone: updateStylistDone,

                      //   // change date
                      //   choseDateUpdateStylist: choseDateUpdateStylist,
                      //   isChangeDate: isChangeDate,
                      //   changeDateDone: changeDateDone,

                      //   // open branch
                      //   openBranch: widget.openBranch,
                      //   //close branch
                      //   closeBranch: widget.closeBranch,
                      // ),
                      SizedBox(height: 20),
                    ],
                  )
                : // giữ nguyên cái cũ 1 - N
                Column(
                    children: [
                      BCSChooseStaff(
                        bloc: widget.bloc,
                        accountStaffList: _accountStylistList,
                      ),
                      BCSChooseTimeSlot(
                          bloc: widget.bloc, selectedStaff: selectedStaff),
                      const SizedBox(height: 20),
                    ],
                  ),
          ],
        );
      },
    );
  }
}

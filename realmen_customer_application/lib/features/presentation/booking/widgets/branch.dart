// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_branch_page/choose_branch_page.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch_choose_branch.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch_choose_date/branch_choose_date.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BranchOptionBooking extends StatefulWidget {
  final BookingBloc bloc;
  Function? callback;
  BranchOptionBooking(this.callback, {super.key, required this.bloc});
  @override
  State<BranchOptionBooking> createState() => _BranchOptionBookingState();
}

class _BranchOptionBookingState extends State<BranchOptionBooking>
    with AutomaticKeepAliveClientMixin {
  BranchDataModel? selectedBranch;
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) async {
          switch (state.runtimeType) {
            case ShowBookingBranchState:
              Get.to(() => ChooseBranchesPage(bookingBloc: widget.bloc));

            case ChooseBranchBookingSelectBranchGetBackState:
              Get.back();

            case ChooseBranchBookingSelectedBranchState:
              selectedBranch = (state as ChooseBranchBookingSelectedBranchState)
                  .selectedBranch;
              Get.back();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
              child: Column(
            children: [
              // 1 chon chi nhanh
              ChooseBranchBooking(bloc: widget.bloc),

              // 2 chon ngay
              selectedBranch != null
                  ? ChooseDateBooking(bloc: widget.bloc)
                  : Container(),

              // 3
              // ChooseServiceBooking(bloc: widget.bloc)

              // TimelineTile(
              //   // false la hien thanh
              //   isLast: false,
              //   beforeLineStyle:
              //       const LineStyle(color: Colors.black, thickness: 2),

              //   // icon
              //   indicatorStyle: IndicatorStyle(
              //     color: Colors.transparent,
              //     width: 35,
              //     height: 40,
              //     padding: const EdgeInsets.only(top: 4, bottom: 4, right: 5),
              //     indicator: Image.asset('assets/images/logo-no-text.png'),
              //     indicatorXY: 0.0,
              //   ),

              //   // content
              //   endChild: selectedBranch.branchId != null
              //       ? (selectedBranch.branchServiceList != null &&
              //               selectedBranch.branchServiceList!.isNotEmpty
              //           ? ChooseServiceBooking(
              //               onServiceSelected: updateSelectedService,
              //               branchServiceList: selectedBranch.branchServiceList!,
              //               isUpdateBranch: isUpdateBranch)
              //           : Container(
              //               height: 150,
              //               padding: const EdgeInsets.only(top: 10, right: 15),
              //               constraints: const BoxConstraints(minHeight: 120),
              //               child: const Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     "2. Chọn dịch vụ ",
              //                     style: TextStyle(fontSize: 20),
              //                   ),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Center(
              //                     child: Text("Chi nhánh hiện chưa có dịch vụ."),
              //                   ),
              //                   Center(
              //                     child: Text(
              //                         "Quý khách hành vui lòng chọn Chi nhánh khác!"),
              //                   ),
              //                 ],
              //               ),
              //             ))
              //       : Container(
              //           height: 150,
              //           padding: const EdgeInsets.only(top: 10, right: 15),
              //           constraints: const BoxConstraints(minHeight: 120),
              //           child: const Text(
              //             "2. Chọn dịch vụ ",
              //             style: TextStyle(fontSize: 20),
              //           )),
              // ),
              // // button Đặt Lịch
              // selectedBranch.branchId != null && selectedService != []
              //     ? Column(
              //         children: [
              //           Container(
              //             width: 81.w,
              //             margin: const EdgeInsets.symmetric(horizontal: 15),
              //             padding: const EdgeInsets.all(0),
              //             decoration: BoxDecoration(
              //               gradient: const LinearGradient(
              //                   begin: Alignment.topLeft,
              //                   end: Alignment.bottomRight,
              //                   colors: [
              //                     Color(0xff302E2E),
              //                     Color(0xe6444141),
              //                     Color(0x8c484646),
              //                     Color(0x26444141),
              //                   ]),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: ElevatedButton(
              //               onPressed: () {
              //                 _onBooking();
              //               },
              //               style: ElevatedButton.styleFrom(
              //                 foregroundColor: Colors.black,
              //                 backgroundColor: Colors.black12,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(10.0),
              //                 ),
              //                 minimumSize: const Size(200, 50),
              //                 padding: const EdgeInsets.all(0),
              //                 shadowColor: Colors.transparent,
              //               ),
              //               child: const Text(
              //                 'Đặt Lịch',
              //                 style: TextStyle(
              //                     fontSize: 24,
              //                     color: Colors.white,
              //                     letterSpacing: 1.5,
              //                     fontWeight: FontWeight.w700),
              //               ),
              //             ),
              //           ),
              //           const Center(
              //             child: Text("Cắt xong trả tiền, hủy lịch không sao"),
              //           )
              //         ],
              //       )
              //     : Container(),

              const SizedBox(
                height: 20,
              ),
            ],
          ));
        },
      ),
    );
  }
}

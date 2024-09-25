// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_branch_booking/booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_stylist_booking/choose_stylist_booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_service_page/choose_service_page.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_stylist_page/choose_stylist_page.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/service/stylist_choose_date.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/service/stylist_choose_service.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/service/stylist_choose_stylist.dart';

class StylistOptionBooking extends StatefulWidget {
  final ChooseStylistBookingBloc bloc;
  Function? callback;
  StylistOptionBooking(this.callback, {super.key, required this.bloc});

  @override
  State<StylistOptionBooking> createState() => _StylistOptionBookingState();
}

class _StylistOptionBookingState extends State<StylistOptionBooking>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  AccountModel? selectedStylist;
  Map<String, dynamic>? selectedDate;
  BranchDataModel? selectedBranch;
  List<ServiceDataModel> selectedServices = [];
  String tabChooseBooking = "Stylist";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ChooseStylistBookingBloc, ChooseStylistBookingState>(
      bloc: widget.bloc,
      listener: (context, state) async {
        switch (state.runtimeType) {
          // choose stylist
          case CSBShowStylistState:
            Get.to(() => ChooseStylistPage(bloc: widget.bloc));
            break;

          case CSBSelectStylistGetBackState:
            Get.back();
            break;

          case CSBSelectedStylistState:
            selectedStylist =
                (state as CSBSelectedStylistState).selectedStylist;
            Get.back();
            break;

          // choose date
          case CSBLoadDateState:
            selectedDate = (state as CSBLoadDateState).dateSeleted;
            break;

          case CSBSelectDateState:
            selectedDate = (state as CSBSelectDateState).dateSeleted;
            break;

          // choose service
          case CSBShowServiceState:
            Get.to(() => ChooseServicesPage(
                CSbookingBloc: widget.bloc,
                // branchId: selectedBranch!.branchId!,
                branchId: 1,
                selectedServices: selectedServices,
                tabChooseBooking: tabChooseBooking));
            break;

          case CSBSelectServiceGetBackState:
            Get.back();
            break;
          case CSBSelectServiceState:
            selectedServices =
                (state as CSBSelectServiceState).selectedServices;
            Get.back();
            break;
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // 1 chon stylist
                CSChooseStylistBooking(bloc: widget.bloc),

                // 2 chon lịch
                selectedStylist != null
                    ? CSChooseDateBooking(bloc: widget.bloc)
                    : Container(),

                // 3 chon service
                selectedStylist != null && selectedDate != null
                    ? CSChooseServiceBooking(bloc: widget.bloc)
                    : Container(),

                // TimelineTile(
                //   // false la hien thanh

                //   isLast: false,
                //   beforeLineStyle: const LineStyle(color: Colors.black, thickness: 2),

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
                //   endChild: selectedBranch.branchId != null &&
                //           selectedService.isNotEmpty &&
                //           selectedBranch.branchServiceList != null &&
                //           selectedBranch.branchServiceList!.isNotEmpty
                //       ? ChooseTimeSlot(
                //           onDateSelected: updateSelectedDate,
                //           onTimeSelected: updateSelectedTime,
                //           selectedStylist: selectedStylist,
                //           openBranch: selectedBranch.open!,
                //           closeBranch: selectedBranch.close!,
                //         )
                //       : Container(
                //           height: 150,
                //           padding: const EdgeInsets.only(top: 10, right: 15),
                //           constraints: const BoxConstraints(minHeight: 120),
                //           child: const Text(
                //             "3. Chọn ngày, giờ ",
                //             style: TextStyle(fontSize: 20),
                //           )),
                // ),
                // // button Đặt Lịch
                // selectedBranch.branchId != null &&
                //         selectedStylist.accountId != null &&
                //         selectedService.isNotEmpty &&
                //         selectedService != []
                //     ? Container(
                //         width: 81.w,
                //         margin: const EdgeInsets.symmetric(horizontal: 15),
                //         padding: const EdgeInsets.all(0),
                //         decoration: BoxDecoration(
                //           gradient: const LinearGradient(
                //               begin: Alignment.topLeft,
                //               end: Alignment.bottomRight,
                //               colors: [
                //                 Color(0xff302E2E),
                //                 Color(0xe6444141),
                //                 Color(0x8c484646),
                //                 Color(0x26444141),
                //               ]),
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: ElevatedButton(
                //           onPressed: () {
                //             _onBooking();
                //           },
                //           style: ElevatedButton.styleFrom(
                //             foregroundColor: Colors.black,
                //             backgroundColor: Colors.black12,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10.0),
                //             ),
                //             minimumSize: const Size(200, 50),
                //             padding: const EdgeInsets.all(0),
                //             shadowColor: Colors.transparent,
                //           ),
                //           child: const Text(
                //             'Đặt Lịch',
                //             style: TextStyle(
                //                 fontSize: 24,
                //                 color: Colors.white,
                //                 letterSpacing: 1.5,
                //                 fontWeight: FontWeight.w700),
                //           ),
                //         ),
                //       )
                //     : Container(),

                // const SizedBox(
                //   height: 20,
                // )
              ],
            ));
      },
    );
  }
}

// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/core/widgets/snackbar/snackbar.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_account_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_branch_booking/booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_stylist_booking/choose_stylist_booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/booking_haircut_temporary_page/booking_haircut_temporary.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_service_page/choose_service_page.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_stylist_page/choose_stylist_page.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/service/stylist_choose_date.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/service/stylist_choose_service.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/service/stylist_choose_stylist.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/service/stylist_choose_timeslot.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
  String selectedTimeSlot = '';
  DailyPlanAccountModel selectedStaff = DailyPlanAccountModel();

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
            selectedBranch =
                // ----------------------- //
                BranchDataModel();
            Get.back();
            break;

          // choose date
          case CSBLoadDateState:
            selectedDate = (state as CSBLoadDateState).dateSeleted;
            selectedStaff = (state as CSBLoadDateState).selectedStaff;
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
          case CSBChooseSelectedTimeSlotState:
            selectedTimeSlot =
                (state as CSBChooseSelectedTimeSlotState).selectedTimeSlot;
            break;
          case CSBShowBookingTemporaryState:
            Get.to(() => BookingHaircutTemporary(
                callback: widget.callback!,
                selectedServices: selectedServices,
                selectedBranch: selectedBranch!,
                selectedDate: selectedDate!,
                selectedStaff: selectedStaff,
                selectedTimeSlot: selectedTimeSlot));
            break;
          case CSBShowSnackBarActionState:
            final snackBarState = state as ShowSnackBarActionState;
            if (snackBarState.status == true) {
              ShowSnackBar.SuccessSnackBar(context, snackBarState.message);
            } else {
              ShowSnackBar.ErrorSnackBar(context, snackBarState.message);
            }
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
                    : TimelineTile(
                        isLast: false,
                        beforeLineStyle:
                            const LineStyle(color: Colors.black, thickness: 2),

                        // icon
                        indicatorStyle: IndicatorStyle(
                          color: Colors.transparent,
                          width: 35,
                          height: 40,
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4, right: 5),
                          indicator:
                              Image.asset('assets/images/logo-no-text.png'),
                          indicatorXY: 0.0,
                        ),

                        // content
                        endChild: Container(
                          height: 150,
                          padding: const EdgeInsets.only(top: 10, right: 15),
                          constraints: const BoxConstraints(minHeight: 120),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "2. Chọn ngày ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )),

                // 3 chon service
                selectedStylist != null && selectedDate != null
                    ? CSChooseServiceBooking(bloc: widget.bloc)
                    : TimelineTile(
                        isLast: false,
                        beforeLineStyle:
                            const LineStyle(color: Colors.black, thickness: 2),

                        // icon
                        indicatorStyle: IndicatorStyle(
                          color: Colors.transparent,
                          width: 35,
                          height: 40,
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4, right: 5),
                          indicator:
                              Image.asset('assets/images/logo-no-text.png'),
                          indicatorXY: 0.0,
                        ),

                        // content
                        endChild: Container(
                          height: 150,
                          padding: const EdgeInsets.only(top: 10, right: 15),
                          constraints: const BoxConstraints(minHeight: 120),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "3. Chọn dịch vụ ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )),
                // 4 chon time slott
                selectedBranch != null &&
                        selectedDate != null &&
                        selectedServices.isNotEmpty
                    ? CSChooseTimeSlotBooking(
                        bloc: widget.bloc,
                      )
                    : TimelineTile(
                        isLast: false,
                        beforeLineStyle:
                            const LineStyle(color: Colors.black, thickness: 2),

                        // icon
                        indicatorStyle: IndicatorStyle(
                          color: Colors.transparent,
                          width: 35,
                          height: 40,
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4, right: 5),
                          indicator:
                              Image.asset('assets/images/logo-no-text.png'),
                          indicatorXY: 0.0,
                        ),

                        // content
                        endChild: Container(
                          height: 150,
                          padding: const EdgeInsets.only(top: 10, right: 15),
                          constraints: const BoxConstraints(minHeight: 120),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "4. Chọn giờ hẹn ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )),

                // button Đặt Lịch
                // selectedBranch != null &&
                selectedServices != [] && selectedTimeSlot != ''
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
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
                              onPressed: () {
                                widget.bloc.add(CSBBookingSubmitEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.black12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                minimumSize: const Size(200, 50),
                                padding: const EdgeInsets.all(0),
                                shadowColor: Colors.transparent,
                              ),
                              child: const Text(
                                'Đặt Lịch',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          const Center(
                            child:
                                Text("Cắt xong trả tiền, hủy lịch không sao"),
                          )
                        ],
                      )
                    : Container(),

                const SizedBox(
                  height: 20,
                ),
              ],
            ));
      },
    );
  }
}

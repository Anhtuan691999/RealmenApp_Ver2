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
import 'package:realmen_customer_application/features/presentation/booking/pages/booking_haircut_temporary_page/booking_haircut_temporary.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_branch_page/choose_branch_page.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_service_page/choose_service_page.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch/branch_choose_branch.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch/branch_choose_date.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch/branch_choose_service.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch/branch_choose_staff.dart';
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
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BranchDataModel? selectedBranch;
    List<ServiceDataModel> selectedServices = [];

    Map<String, dynamic>? selectedDate;
    DailyPlanAccountModel selectedStaff = DailyPlanAccountModel();
    String tabChooseBooking = "Branch";
    String selectedTimeSlot = '';

    return BlocConsumer<BookingBloc, BookingState>(
      bloc: widget.bloc,
      listener: (context, state) async {
        switch (state.runtimeType) {
          case ShowBookingBranchState:
            Get.to(() => ChooseBranchesPage(bookingBloc: widget.bloc));
            break;
          case ChooseBranchBookingSelectBranchGetBackState:
            Get.back();
            break;

          case ChooseBranchBookingSelectedBranchState:
            selectedBranch = (state as ChooseBranchBookingSelectedBranchState)
                .selectedBranch;
            selectedServices = (state as ChooseBranchBookingSelectedBranchState)
                    .selectedServices ??
                [];
            Get.back();
            break;

          // choose service
          case BookingShowServiceState:
            Get.to(() => ChooseServicesPage(
                CBbookingBloc: widget.bloc,
                branchId: selectedBranch!.branchId!,
                selectedServices: selectedServices,
                tabChooseBooking: tabChooseBooking));
            break;

          case ChooseBranchBookingSelectServiceGetBackState:
            Get.back();
            break;
          case ChooseBranchBookingSelectedServiceState:
            selectedServices =
                (state as ChooseBranchBookingSelectedServiceState)
                    .selectedServices;
            Get.back();
            break;

          // choose date
          case BranchChooseDateLoadDateState:
            selectedDate = (state as BranchChooseDateLoadDateState).dateSeleted;
            break;
          case BranchChooseSelectDateState:
            selectedDate = (state as BranchChooseSelectDateState).dateSeleted;
            selectedTimeSlot = '';

            break;

          // choose staff
          case BranchChooseSelectedStaffState:
            selectedStaff =
                (state as BranchChooseSelectedStaffState).selectedStaff;
            selectedTimeSlot = '';
            break;

          case BranchChooseSelectedTimeSlotState:
            selectedTimeSlot =
                (state as BranchChooseSelectedTimeSlotState).selectedTimeSlot;
            break;
          case ShowBookingTemporaryState:
            Get.to(() => BookingHaircutTemporary(
                callback: widget.callback!,
                selectedServices: selectedServices,
                selectedBranch: selectedBranch!,
                selectedDate: selectedDate!,
                selectedStaff: selectedStaff,
                selectedTimeSlot: selectedTimeSlot));
            break;
          case ShowSnackBarActionState:
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
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // 1 chon chi nhanh
                ChooseBranchBooking(bloc: widget.bloc),

                // 2 chon chi nhanh
                selectedBranch != null
                    ? ChooseServiceBooking(
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
                                "2. Chọn dịch vụ ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )),
                // 3 chon ngay
                selectedBranch != null && selectedServices.isNotEmpty
                    ? ChooseDateBooking(
                        bloc: widget.bloc,
                        selectedServices: selectedServices,
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
                                "3. Chọn ngày ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )),

                // 4 chon staff
                selectedBranch != null &&
                        selectedServices.isNotEmpty &&
                        selectedDate != null
                    ? TimelineTile(
                        // false la hien thanh
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
                        endChild: Container(
                            // height: 150,
                            padding: const EdgeInsets.only(top: 10, right: 15),
                            constraints: const BoxConstraints(minHeight: 120),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "4. Chọn nhân viên & giờ hẹn ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ChooseStaffBooking(
                                  bloc: widget.bloc,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),
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
                                "4. Chọn nhân viên & giờ hẹn ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )),

                // button Đặt Lịch
                selectedBranch != null &&
                        selectedServices != [] &&
                        selectedTimeSlot != ''
                    ? Column(
                        children: [
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
                                widget.bloc.add(BookingSubmitEvent());
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

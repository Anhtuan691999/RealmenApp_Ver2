// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/booking_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ChooseServiceBooking extends StatefulWidget {
  final BookingBloc bloc;
  const ChooseServiceBooking({
    super.key,
    required this.bloc,
  });

  @override
  State<ChooseServiceBooking> createState() => _ChooseServiceBookingState();
}

class _ChooseServiceBookingState extends State<ChooseServiceBooking> {
  List<ServiceDataModel>? servicesList = [];
  String buttonText = 'Xem tất cả danh sách dịch vụ';
  List<Widget> textContainers = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (state is ChooseBranchBookingSelectedServiceState) {
          final currentState = state;
          bool hasSelectedServices = currentState.selectedServices.isNotEmpty;
          servicesList = currentState.selectedServices;
          if (hasSelectedServices) {
            textContainers = currentState.selectedServices.map((service) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  service.shopServiceName ?? "Dịch vụ",
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              );
            }).toList();
            // Update the button text

            // widget.bloc.add(ChooseBranchBookingSelectServiceGetBackEvent());
          } else {
            textContainers = [];
          }
          buttonText = hasSelectedServices
              ? 'Đã chọn ${currentState.selectedServices.length} dịch vụ'
              : 'Xem tất cả danh sách dịch vụ';
        }

        return TimelineTile(
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
            padding: const EdgeInsets.only(top: 10, right: 15),
            constraints: const BoxConstraints(minHeight: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "2. Chọn dịch vụ ",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    widget.bloc.add(BookingShowServiceEvent());
                    // if (!_isDisposed && mounted) {
                    //   List<BranchServiceModel> _servicesList =
                    //       List<BranchServiceModel>.from(servicesList!);
                    //   List<BranchServiceModel>? selectedServices =
                    //       await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ChooseServiceBookingScreen(
                    //         selectedServices: _servicesList,
                    //         branchServiceList: widget.branchServiceList,
                    //       ),
                    //     ),
                    //   );

                    //   // Handle the selected services here
                    //   if (selectedServices != null) {
                    //     setState(() {
                    //       _getTextContainers(selectedServices);
                    //       servicesList = selectedServices;
                    //     });
                    //     widget.onServiceSelected(selectedServices);
                    //   }
                    // }
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
                        Row(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.cut,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  buttonText,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_right, color: Colors.black))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: textContainers,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

// giữ

  @override // giữ
  void initState() {
    super.initState();
  }

//   _getTextContainers(List<BranchServiceModel> selectedServices) {
// // Update your UI or perform other actions with selectedServices
//     hasSelectedServices = selectedServices.isNotEmpty;
//     if (hasSelectedServices) {
//       textContainers = selectedServices.map((service) {
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Text(
//             utf8.decode(service.serviceName.toString().runes.toList()),
//             style: const TextStyle(fontSize: 12, color: Colors.black),
//           ),
//         );
//       }).toList();
//     }
//     // Update the button text
//     buttonText = hasSelectedServices
//         ? 'Đã chọn ${selectedServices.length} dịch vụ'
//         : 'Xem tất cả danh sách dịch vụ';
//   }
}

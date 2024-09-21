// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';

import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_stylist_booking/choose_stylist_booking_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CSChooseServiceBooking extends StatefulWidget {
  final ChooseStylistBookingBloc bloc;

  const CSChooseServiceBooking({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  State<CSChooseServiceBooking> createState() => _CSChooseServiceBookingState();
}

class _CSChooseServiceBookingState extends State<CSChooseServiceBooking> {
  List<ServiceDataModel>? servicesList = [];
  String buttonText = 'Xem tất cả danh sách dịch vụ';
  List<Widget> textContainers = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseStylistBookingBloc, ChooseStylistBookingState>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (state is CSBSelectServiceState) {
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
                  "3. Chọn dịch vụ ",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    widget.bloc.add(CSBShowServiceEvent());
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
}

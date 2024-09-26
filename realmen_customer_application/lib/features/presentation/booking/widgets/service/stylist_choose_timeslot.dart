import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmen_customer_application/features/data/models/working_slot_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_stylist_booking/choose_stylist_booking_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CSChooseTimeSlotBooking extends StatefulWidget {
  final ChooseStylistBookingBloc bloc;

  const CSChooseTimeSlotBooking({
    super.key,
    required this.bloc,
  });

  @override
  State<CSChooseTimeSlotBooking> createState() =>
      _CSChooseTimeSlotBookingState();
}

class _CSChooseTimeSlotBookingState extends State<CSChooseTimeSlotBooking> {
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
            widget.bloc.add(
                CSBonTimeSlotSelectedEvent(timeSlot: timeSlotCard.timeSlot));
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

    return BlocBuilder<ChooseStylistBookingBloc, ChooseStylistBookingState>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (state is CSBSelectServiceState) {
          widget.bloc.add(CSBGetTimeSlotEvent());
        } else if (state is CSBSelectDateState) {
          widget.bloc.add(CSBGetTimeSlotEvent());
        } else if (state is CSBLoadDateState) {
          widget.bloc.add(CSBGetTimeSlotEvent());
        } else if (state is CSBChooseTimeSlotLoadedState) {
          timeSlotCards = [];
          for (TimeSlotCardModel timeSlot
              in (state).timeSlotCards) {
            timeSlotCards.add(TimeSlotCard(timeSlot));
            _selectedTimeSlot = '';
          }
        } else if (state is CSBChooseSelectedTimeSlotState) {
          timeSlotCards = [];
          _selectedTimeSlot =
              (state).selectedTimeSlot;
          for (TimeSlotCardModel timeSlot
              in (state).timeSlotCards) {
            timeSlotCards.add(TimeSlotCard(timeSlot));
          }
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
              // height: 100,
              padding: const EdgeInsets.only(top: 10, right: 15),
              constraints: const BoxConstraints(minHeight: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "4. Chọn giờ hẹn ",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
              )),
        );
      },
    );
  }
}

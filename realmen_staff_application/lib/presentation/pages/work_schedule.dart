// ignore_for_file: must_be_immutable, constant_identifier_names, unused_field, unused_local_variable, sized_box_for_whitespace, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:realmen_staff_application/data/appointment_data_source.dart';

class WorkScheduleScreen extends StatefulWidget {
  Function callback;

  WorkScheduleScreen(this.callback, {super.key});

  @override
  State<WorkScheduleScreen> createState() => _WorkScheduleState();
  static const String WorkScheduleScreenRoute = "/work-schedule-screen";
}

class _WorkScheduleState extends State<WorkScheduleScreen> {
  final GlobalKey _globalKey = GlobalKey();
  Appointment? _selectedAppointment;
  final CalendarController calendarController = CalendarController();

  final List<TimeRegion> _specialTimeRegions = <TimeRegion>[];
  CalendarView _view = CalendarView.schedule;
  final WorkScheduleDataSource loadedDataSource =
      WorkScheduleDataSource(<WorkSchedule>[]);

  @override
  void initState() {
    calendarController.view = _view;
    _selectedAppointment = null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 15,
                bottom: 27,
                child: Container(
                    padding: const EdgeInsets.only(top: 30),
                    width: 90.w,
                    height: 90.h,
                    // height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 7),
                          child: Center(
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  "lịch làm".toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // width: 80.w,
                          height: 75.h,
                          key: _globalKey,
                          child: SfCalendar(
                            controller: calendarController,
                            view: _view,
                            showWeekNumber: true,
                            showDatePickerButton: true,
                            showNavigationArrow: true,
                            monthViewSettings: const MonthViewSettings(
                                showAgenda: true, numberOfWeeksInView: 2),
                            firstDayOfWeek: 1,
                            dataSource:
                                // MeetingDataSource(getAppointments()),
                                loadedDataSource,
                            timeSlotViewSettings: const TimeSlotViewSettings(
                              startHour: 7,
                              endHour: 23,
                              timeInterval: Duration(hours: 8),
                              timeIntervalHeight: 100,
                              timelineAppointmentHeight: 500,
                              timeRulerSize: 80,
                              timeFormat: "CA TỐI",
                            ),
                            specialRegions: _specialTimeRegions,
                            loadMoreWidgetBuilder: (BuildContext context,
                                LoadMoreCallback loadMoreAppointments) {
                              return FutureBuilder<void>(
                                future: loadMoreAppointments(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<void> snapShot) {
                                  return Container(
                                      height: 50,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color?>(Colors.white)));
                                },
                              );
                            },
                          ),
                        )
                      ],
                    )),
              )
            ],
          ))
        ],
      ),
    );
  }
}

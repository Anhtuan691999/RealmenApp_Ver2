// ignore_for_file: must_be_immutable, constant_identifier_names, unused_field, unused_local_variable, sized_box_for_whitespace, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:realmen_staff_application/models/schedule/schedule_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/service/schedule/schedule_service.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WorkScheduleScreen extends StatefulWidget {
  Function callback;
  WorkScheduleScreen(this.callback, {super.key});

  @override
  State<WorkScheduleScreen> createState() => _WorkScheduleState();
  static const String WorkScheduleScreenRoute = "/work-schedule-screen";
}

class _WorkScheduleState extends State<WorkScheduleScreen> {
  _WorkScheduleState();
  _AppointmentDataSource _dataSource = _AppointmentDataSource(<Appointment>[]);
  final GlobalKey _globalKey = GlobalKey();
  Appointment? _selectedAppointment;
  final CalendarController calendarController = CalendarController();

  @override
  void initState() {
    calendarController.view = _view;
    _selectedAppointment = null;
    _dataSource = _AppointmentDataSource(_getAppointmentDetails());
    _getSchedule();
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
                            allowedViews: _allowedViews,
                            view: CalendarView.month,
                            showWeekNumber: true,
                            showDatePickerButton: true,
                            showNavigationArrow: true,
                            monthViewSettings: const MonthViewSettings(
                                showAgenda: true, numberOfWeeksInView: 2),
                            firstDayOfWeek: 1,
                            dataSource:
                                // MeetingDataSource(getAppointments()),
                                _dataSource,
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
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ))
        ],
      ),
    );
  }

  _getAppointmentDetails() {
    final List<Appointment> appointments = <Appointment>[];
    return appointments;
  }

  final List<TimeRegion> _specialTimeRegions = <TimeRegion>[];
  CalendarView _view = CalendarView.week;
  SchedulesModel? schedulesModel = SchedulesModel();

  _getSchedule() async {
    final List<Appointment> appointments = <Appointment>[];
    ScheduleService scheduleService = ScheduleService();

    try {
      int staffId = await SharedPreferencesService.getStaffId();
      var result = await scheduleService.getSchedule(staffId);
      if (result['statusCode'] == 200) {
        schedulesModel = result['data'] as SchedulesModel;
        for (var schedule in schedulesModel!.scheduleModelList!) {
          Appointment? newAppointment;

          // chuyển String workingDate thành DateTime
          String dateString = schedule.workingDate!;
          var parts = dateString.split('/');
          DateTime dateSchedule = DateTime(
              int.parse(parts[2]), int.parse(parts[0]), int.parse(parts[1]));

          // Lấy start time
          final startTimeString = schedule.startShift.toString();
          List<String> partsStartTimeString = startTimeString.split(":");
          int hourStart = int.parse(partsStartTimeString[0]);
          int minuteStart = int.parse(partsStartTimeString[1]);
          DateTime startDate = DateTime(dateSchedule.year, dateSchedule.month,
              dateSchedule.day, hourStart, minuteStart);

          // Lấy end time
          final endTimeString = schedule.endShift.toString();
          List<String> partsEndTimeString = endTimeString.split(":");
          int hourEnd = int.parse(partsEndTimeString[0]);
          int minuteEnd = int.parse(partsEndTimeString[1]);
          DateTime endDate = DateTime(dateSchedule.year, dateSchedule.month,
              dateSchedule.day, hourEnd, minuteEnd);

          String subject = '';
          Color colorSchedule = Colors.transparent;
          if (schedule.shift == 'MORNING') {
            subject = "CA SÁNG";
            colorSchedule = Colors.deepOrange.shade400;
            final DateTime startTimeRegion = DateTime(dateSchedule.year,
                dateSchedule.month, dateSchedule.day, 15, 0, 0);
            final DateTime endTimeRegion = DateTime(dateSchedule.year,
                dateSchedule.month, dateSchedule.day, 23, 0, 0);
            // if (_specialTimeRegions.any((region) =>
            //         region.startTime.isAtSameMomentAs(startTimeRegion) &&
            //         region.endTime.isAtSameMomentAs(endTimeRegion)) ==
            //     false) {
            //   _specialTimeRegions.add(TimeRegion(
            //     startTime: startTimeRegion,
            //     endTime: endTimeRegion,
            //     enablePointerInteraction: false,
            //   ));
            // }
          } else if (schedule.shift == 'NIGHT') {
            subject = "CA TỐI";
            colorSchedule = Colors.deepPurple.shade400;
            final DateTime startTimeRegion = DateTime(dateSchedule.year,
                dateSchedule.month, dateSchedule.day, 7, 0, 0);
            final DateTime endTimeRegion = DateTime(dateSchedule.year,
                dateSchedule.month, dateSchedule.day, 15, 0, 0);
            // if (_specialTimeRegions.any((region) =>
            //         region.startTime.isAtSameMomentAs(startTimeRegion) &&
            //         region.endTime.isAtSameMomentAs(endTimeRegion)) ==
            //     false) {
            //   _specialTimeRegions.add(TimeRegion(
            //     startTime: startTimeRegion,
            //     endTime: endTimeRegion,
            //     enablePointerInteraction: false,
            //   ));
            // }
          }

          newAppointment = Appointment(
            startTime: startDate,
            endTime: endDate,
            color: colorSchedule,
            subject: subject,
          );

          setState(() {
            _dataSource.notifyListeners(
                CalendarDataSourceAction.add, <Appointment>[newAppointment!]);
          });
        }
      } else {
        _errorMessage(result['message']);
        print(result);
        return appointments;
      }
    } catch (e) {
      _errorMessage("Vui lòng thử lại");
      print(e.toString());
      return appointments;
    }
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.week,
    CalendarView.month,
    CalendarView.schedule,
  ];
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(this.source);
  List<Appointment> source;
  @override
  List<dynamic> get appointments => source;
}

// ignore_for_file: must_be_immutable, unnecessary_null_comparison, avoid_print, constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_staff_application/models/schedule/schedule_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/screens/register_work_schedule/appointment_editor.dart';

import 'package:realmen_staff_application/service/schedule/schedule_service.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RegisterWorkScheduleScreen extends StatefulWidget {
  Function callback;
  RegisterWorkScheduleScreen(this.callback, {super.key});

  @override
  State<RegisterWorkScheduleScreen> createState() =>
      _RegisterWorkScheduleScreenState();
  static const String RegisterWorkScheduleScreenRoute =
      "/register-work-schedule-screen";
}

class _RegisterWorkScheduleScreenState
    extends State<RegisterWorkScheduleScreen> {
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
                                  "đăng ký lịch làm".toUpperCase(),
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
                          height: 65.h,
                          key: _globalKey,
                          child: SfCalendar(
                            controller: calendarController,
                            allowedViews: _allowedViews,
                            initialDisplayDate: DateTime.now(),
                            // minDate: DateTime(
                            //     DateTime.now().year,
                            //     DateTime.now().month,
                            //     DateTime.now().day -
                            //         DateTime.now().weekday +
                            //         1),
                            // maxDate: maxDateSfCalendar,
                            // DateTime(
                            //     DateTime.now().year,
                            //     DateTime.now().month,
                            //     DateTime.now().day +
                            //         (8 - DateTime.now().weekday)),
                            // DateTime.now()
                            //     .add(Duration(
                            //         days: 8 - DateTime.now().weekday))
                            //     .add(Duration(days: 6)),

                            showWeekNumber: true,
                            showDatePickerButton: true,
                            monthViewSettings:
                                const MonthViewSettings(showAgenda: true),
                            firstDayOfWeek: 1,
                            dataSource:
                                // MeetingDataSource(getAppointments()),
                                _dataSource,
                            onTap: _onCalendarTapped,
                            timeSlotViewSettings: const TimeSlotViewSettings(
                              startHour: 7,
                              endHour: 23,
                              timeInterval: Duration(hours: 8),
                              timeIntervalHeight: 100,
                              timelineAppointmentHeight: 500,
                              timeRulerSize: 80,
                              timeFormat: "CA TỐI",
                            ),
                            // ignore: prefer_if_null_operators,
                            // specialRegions: _specialTimeRegions != null
                            //     ? _specialTimeRegions
                            //     : <TimeRegion>[],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.resolveWith((states) {
                                  return const EdgeInsets.all(0);
                                }),
                              ),
                              onPressed: _registerSchedule,
                              child: const Text(
                                "ĐĂNG KÝ LỊCH LÀM",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                              ),
                            ),
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

  _RegisterWorkScheduleScreenState();
  _AppointmentDataSource _dataSource = _AppointmentDataSource(<Appointment>[]);
  List<Appointment> _appointmentSoucre = [];
  final GlobalKey _globalKey = GlobalKey();
  Appointment? _selectedAppointment;
  final CalendarController calendarController = CalendarController();

  @override
  void initState() {
    calendarController.view = _view;
    _selectedAppointment = null;
    _dataSource = _AppointmentDataSource(_getAppointmentDetails());
    _getSchedule();
    DateTime nextWeekEnd = DateTime.now()
        .add(Duration(days: 8 - DateTime.now().weekday))
        .add(const Duration(days: 6));
    maxDateSfCalendar = DateTime(
        nextWeekEnd.year, nextWeekEnd.month, nextWeekEnd.day + 1, 0, 0, 0);

    super.initState();
  }

  _getAppointmentDetails() {
    final List<Appointment> appointments = <Appointment>[];

    // //Recurrence Appointment 1
    // final DateTime currentDate = DateTime.now();
    // final DateTime startTime =
    //     DateTime(currentDate.year, currentDate.month, currentDate.day, 7);
    // final DateTime endTime =
    //     DateTime(currentDate.year, currentDate.month, currentDate.day, 15);

    // final RecurrenceProperties recurrencePropertiesForAlternativeDay =
    //     RecurrenceProperties(
    //         startDate: startTime,
    //         interval: 2,
    //         recurrenceRange: RecurrenceRange.count,
    //         recurrenceCount: 20);
    // // data
    // final Appointment alternativeDayAppointment = Appointment(
    //   startTime: startTime,
    //   endTime: endTime,
    //   color: Colors.deepOrangeAccent,
    //   subject: 'CA SÁNG',
    // );
    // // add data vào list data
    // appointments.add(alternativeDayAppointment);

    return appointments;
  }

  void _onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    /// Condition added to open the editor, when the calendar elements tapped
    /// other than the header.
    if (calendarTapDetails.targetElement == CalendarElement.header ||
        calendarTapDetails.targetElement == CalendarElement.viewHeader) {
      return;
    }

    _selectedAppointment = null;

    final DateTime selectedDate = calendarTapDetails.date!;
    final CalendarElement targetElement = calendarTapDetails.targetElement;

    /// Navigates the calendar to day view,
    /// when we tap on month cells in mobile.

    if (calendarTapDetails.appointments != null &&
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final dynamic appointment = calendarTapDetails.appointments![0];
      if (appointment is Appointment) {
        _selectedAppointment = appointment;
      }
      Get.to(() => AppointmentEditorRWS(
          _selectedAppointment, // null
          targetElement,
          selectedDate,
          _dataSource,
          _specialTimeRegions));
    } else {
// tạo mới

      Appointment? newAppointment;
      newAppointment = Appointment(
        startTime: selectedDate,
        endTime: selectedDate.add(const Duration(hours: 8)),
        color: Colors.white,
        subject: '(No title)',
      );
      _selectedAppointment = newAppointment;
      if (!_dataSource.appointments.any((element) =>
          (element.startTime as DateTime).isAtSameMomentAs(selectedDate))) {
        Get.to(() => AppointmentEditorRWS(
            _selectedAppointment, // null
            targetElement,
            selectedDate,
            _dataSource,
            _specialTimeRegions));
      }
    }

    /// Navigates to the appointment editor page on mobile

    // Dialog

    // showDialog<Widget>(
    //     context: context,
    //     builder: (BuildContext context) => AppointmentEditorRWS(
    //         _selectedAppointment, // null
    //         targetElement,
    //         selectedDate,
    //         _dataSource,
    //         _specialTimeRegions)).then((dynamic value) => setState(() {}));
  }

  final List<TimeRegion> _specialTimeRegions = <TimeRegion>[];
  // ignore: prefer_final_fields
  CalendarView _view = CalendarView.week;

  _registerSchedule() async {
    SchedulesModel schedulesModel = SchedulesModel();
    schedulesModel.scheduleModelList = <ScheduleModel>[];
    ScheduleService scheduleService = ScheduleService();

    if (_dataSource != null) {
      for (var data in _dataSource.appointments) {
        // ignore: prefer_typing_uninitialized_variables
        var shiftId;
        if (data.subject == "CA SÁNG") {
          shiftId = 1;
        } else if (data.subject == "CA TỐI") {
          shiftId = 2;
        }
        if (!_appointmentSoucre.contains(data)) {
          if (data.appointmentType == AppointmentType.normal) {
            var workingDate = DateFormat('yyyy-MM-dd').format(data.startTime);
            if (shiftId != null && workingDate != null) {
              schedulesModel.scheduleModelList!.add(
                  ScheduleModel(shiftId: shiftId, workingDate: workingDate));
            }
          } else if (data.appointmentType != AppointmentType.normal &&
              data.recurrenceRule != null) {
            if (shiftId != null) {
              List<DateTime> recurrentDate =
                  SfCalendar.getRecurrenceDateTimeCollection(
                      data.recurrenceRule, data.startTime);
              List<String> recurrentDateList = recurrentDate
                  .map((date) =>
                      DateFormat('yyyy-MM-dd').format(date).toString())
                  .toList();
              for (var element in recurrentDateList) {
                schedulesModel.scheduleModelList!
                    .add(ScheduleModel(shiftId: shiftId, workingDate: element));
              }
            }
          }
        }
      }
      if (schedulesModel.scheduleModelList!.isNotEmpty) {
        try {
          int staffId = await SharedPreferencesService.getStaffId();
          var result =
              await scheduleService.postSchedule(staffId, schedulesModel);
          if (result['statusCode'] == 200) {
            widget.callback(1);
            _successMessage("Đăng ký thành công");
          } else {
            _errorMessage("Đăng ký thất bại");
          }
        } catch (e) {
          _errorMessage("Vui lòng thử lại");
          print(e.toString());
        }
      } else {
        _errorMessage("Vui lòng đăng ký ca làm");
      }
    }
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  void _successMessage(String? message) {
    try {
      ShowSnackBar.SuccessSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

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
            if (_specialTimeRegions.any((region) =>
                    region.startTime.isAtSameMomentAs(startTimeRegion) &&
                    region.endTime.isAtSameMomentAs(endTimeRegion)) ==
                false) {
              _specialTimeRegions.add(TimeRegion(
                startTime: startTimeRegion,
                endTime: endTimeRegion,
                enablePointerInteraction: false,
              ));
            }
          } else if (schedule.shift == 'NIGHT') {
            subject = "CA TỐI";
            colorSchedule = Colors.deepPurple.shade400;
            final DateTime startTimeRegion = DateTime(dateSchedule.year,
                dateSchedule.month, dateSchedule.day, 7, 0, 0);
            final DateTime endTimeRegion = DateTime(dateSchedule.year,
                dateSchedule.month, dateSchedule.day, 15, 0, 0);
            if (_specialTimeRegions.any((region) =>
                    region.startTime.isAtSameMomentAs(startTimeRegion) &&
                    region.endTime.isAtSameMomentAs(endTimeRegion)) ==
                false) {
              _specialTimeRegions.add(TimeRegion(
                startTime: startTimeRegion,
                endTime: endTimeRegion,
                enablePointerInteraction: false,
              ));
            }
          }

          newAppointment = Appointment(
            startTime: startDate,
            endTime: endDate,
            color: colorSchedule,
            subject: subject,
          );

          setState(() {
            _dataSource.source.add(newAppointment!);
            // _dataSource.notifyListeners();
            _dataSource.notifyListeners(
                CalendarDataSourceAction.add, <Appointment>[newAppointment]);
          });
        }
        _appointmentSoucre = List.from(_dataSource.source);
      } else {
        _errorMessage(result['message']);
        return appointments;
      }
    } catch (e) {
      _errorMessage("Vui lòng thử lại");
      print(e.toString());
      return appointments;
    }
  }

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.week,
    CalendarView.month,
    CalendarView.schedule,
  ];

  DateTime maxDateSfCalendar = DateTime.now();
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(this.source);
  List<Appointment> source;
  @override
  List<dynamic> get appointments => source;
}

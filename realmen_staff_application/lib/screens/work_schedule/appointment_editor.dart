// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_staff_application/service/change_notifier_provider/change_notifier_provider_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentEditor extends StatefulWidget {
  const AppointmentEditor(this.selectedAppointment, this.targetElement,
      this.selectedDate, this._dataSource, this._specialTimeRegions,
      [this.selectedResource]);

  /// Selected appointment
  final Appointment? selectedAppointment;

  /// Calendar element
  final CalendarElement targetElement;

  /// Seelcted date value
  final DateTime selectedDate;

  /// Selected calendar resource
  final CalendarResource? selectedResource;

  /// Holds the events value
  final CalendarDataSource _dataSource;

  final List<TimeRegion> _specialTimeRegions;

  @override
  State<AppointmentEditor> createState() => _AppointmentEditorState();
}

class _AppointmentEditorState extends State<AppointmentEditor> {
  String _subject = '';
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    _updateAppointmentProperties();
    getDate();
    super.initState();
  }

  @override
  void didUpdateWidget(AppointmentEditor oldWidget) {
    _updateAppointmentProperties();
    super.didUpdateWidget(oldWidget);
  }

  void _updateAppointmentProperties() {
    _startDate = widget.selectedAppointment!.startTime;
    _endDate = widget.selectedAppointment!.endTime;
    colorWorkShift = widget.selectedAppointment!.color;
    _subject = widget.selectedAppointment!.subject == '(No title)'
        ? ''
        : widget.selectedAppointment!.subject;
    if (_subject == "CA SÁNG") {
      isMorningSelected = true;
      isNightSelected = false;
    } else if (_subject == "CA TỐI") {
      isMorningSelected = false;
      isNightSelected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        width: double.maxFinite,
        height: 340,
        child: Column(
          children: [
            Container(
              color: colorWorkShift,
              padding: const EdgeInsets.only(left: 7),
              child: Center(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 50,
                      child: IconButton(
                        alignment: Alignment.centerLeft,
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: isMorningSelected || isNightSelected
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "CHỌN CA LÀM".toUpperCase(),
                          style: TextStyle(
                            color: isMorningSelected || isNightSelected
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Combo
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: <Widget>[
                _getAppointmentEditor(context, Colors.white, Colors.black87)
              ],
            ),
          ],
        ),
      ),
    );
  }

  save() {
    if (widget.selectedAppointment != null) {
      if (widget.selectedAppointment!.subject == '(No title)') {
        final Appointment newAppointment = Appointment(
          startTime: _startDate,
          endTime: _endDate,
          color: colorWorkShift,
          subject: workShift!.name!,
        );
        final apointment = newAppointment;
        final datasource = widget._dataSource.appointments;
        datasource!.add(apointment);
        // widget._dataSource.appointments!.add(newAppointment);

        widget._dataSource.notifyListeners(
            CalendarDataSourceAction.add, <Appointment>[newAppointment]);
        if (workShift!.id! == 1) {
          final DateTime startTimeRegion = DateTime(
              _startDate.year, _startDate.month, _startDate.day, 15, 0, 0);
          final DateTime endTimeRegion =
              DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 0, 0);
          if (widget._specialTimeRegions.any((region) =>
                  region.startTime.isAtSameMomentAs(startTimeRegion) &&
                  region.endTime.isAtSameMomentAs(endTimeRegion)) ==
              false) {
            widget._specialTimeRegions.add(TimeRegion(
              startTime: startTimeRegion,
              endTime: endTimeRegion,
              enablePointerInteraction: false,
            ));
          }
        } else if (workShift!.id! == 2) {
          final DateTime startTimeRegion = DateTime(
              _startDate.year, _startDate.month, _startDate.day, 7, 0, 0);
          final DateTime endTimeRegion =
              DateTime(_endDate.year, _endDate.month, _endDate.day, 15, 0, 0);
          if (widget._specialTimeRegions.any((region) =>
                  region.startTime.isAtSameMomentAs(startTimeRegion) &&
                  region.endTime.isAtSameMomentAs(endTimeRegion)) ==
              false) {
            widget._specialTimeRegions.add(TimeRegion(
              startTime: startTimeRegion,
              endTime: endTimeRegion,
              enablePointerInteraction: false,
            ));
          }
        }

        Future.delayed(const Duration(milliseconds: 200), () {
          // When task is over, close the dialog
          Navigator.pop(context);
        });
      } else {
        if (widget.selectedAppointment != null) {
          widget._dataSource.appointments!.removeAt(widget
              ._dataSource.appointments!
              .indexOf(widget.selectedAppointment));
          widget._dataSource.notifyListeners(CalendarDataSourceAction.remove,
              <Appointment>[widget.selectedAppointment!]);
          ChangeNotifierServices changeNotifierServices =
              ChangeNotifierServices();

          changeNotifierServices
              .removeSpecialTimeRegion(widget.selectedAppointment!);
        }
        if (workShift == null) {
          if (widget.selectedAppointment!.subject == "CA SÁNG") {
            workShift = workshifts[0];
          } else if (widget.selectedAppointment!.subject == "CA TỐI") {
            workShift = workshifts[1];
          }
        }
        final Appointment newAppointment = Appointment(
          startTime: _startDate,
          endTime: _endDate,
          color: colorWorkShift,
          subject: workShift!.name!,
        );
        final apointment = newAppointment;
        final datasource = widget._dataSource.appointments;
        datasource!.add(apointment);
        // widget._dataSource.appointments!.add(newAppointment);

        widget._dataSource.notifyListeners(
            CalendarDataSourceAction.add, <Appointment>[newAppointment]);

        if (workShift!.id! == 1) {
          final DateTime startTimeRegion = DateTime(
              _startDate.year, _startDate.month, _startDate.day, 15, 0, 0);
          final DateTime endTimeRegion =
              DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 0, 0);
          if (widget._specialTimeRegions.any((region) =>
                  region.startTime.isAtSameMomentAs(startTimeRegion) &&
                  region.endTime.isAtSameMomentAs(endTimeRegion)) ==
              false) {
            widget._specialTimeRegions.add(TimeRegion(
              startTime: startTimeRegion,
              endTime: endTimeRegion,
              enablePointerInteraction: false,
            ));
          }
        } else if (workShift!.id! == 2) {
          final DateTime startTimeRegion = DateTime(
              _startDate.year, _startDate.month, _startDate.day, 7, 0, 0);
          final DateTime endTimeRegion =
              DateTime(_endDate.year, _endDate.month, _endDate.day, 15, 0, 0);
          if (widget._specialTimeRegions.any((region) =>
                  region.startTime.isAtSameMomentAs(startTimeRegion) &&
                  region.endTime.isAtSameMomentAs(endTimeRegion)) ==
              false) {
            widget._specialTimeRegions.add(TimeRegion(
              startTime: startTimeRegion,
              endTime: endTimeRegion,
              enablePointerInteraction: false,
            ));
          }
        }
        Future.delayed(const Duration(milliseconds: 200), () {
          // When task is over, close the dialog
          Navigator.pop(context);
        });
      }
    }
  }

  Widget _getAppointmentEditor(
      BuildContext context, Color backgroundColor, Color defaultColor) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              txtSelectedDate!,
              style: const TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                    color: isMorningSelected
                        ? Colors.deepOrange.shade400
                        : Colors.transparent),
                child: TextButton(
                  onPressed: () {
                    _onSelected(1);
                  },
                  child: SizedBox(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "CA SÁNG",
                          style: TextStyle(
                              color: isMorningSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 23),
                        ),
                        Text(
                          "( 7:00 - 15:00 )",
                          style: TextStyle(
                              color: isMorningSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                    color: isNightSelected
                        ? Colors.deepPurple.shade400
                        : Colors.transparent),
                child: TextButton(
                  onPressed: () {
                    _onSelected(2);
                  },
                  child: SizedBox(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "CA TỐI",
                          style: TextStyle(
                              color:
                                  isNightSelected ? Colors.white : Colors.black,
                              fontSize: 23),
                        ),
                        Text(
                          "( 15:00 - 23:00 )",
                          style: TextStyle(
                              color:
                                  isNightSelected ? Colors.white : Colors.black,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Colors.black54, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
                color: colorWorkShift),
            child: TextButton(
              onPressed: save,
              child: Center(
                child: Text(
                  "xác nhận".toUpperCase(),
                  style: TextStyle(
                    color: isMorningSelected || isNightSelected
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 29,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isMorningSelected = false;
  bool isNightSelected = false;
  WorkShift? workShift;
  Color colorWorkShift = Colors.grey;
  void _onSelected(int id) {
    if (id == 1) {
      setState(() {
        isMorningSelected = true;
        isNightSelected = false;
        workShift = workshifts[0];
        colorWorkShift = Colors.deepOrange.shade400;
        _startDate = DateTime(
            _startDate.year, _startDate.month, _startDate.day, 7, 0, 0);
        _endDate =
            DateTime(_endDate.year, _endDate.month, _endDate.day, 15, 0, 0);
      });
    } else if (id == 2) {
      setState(() {
        isMorningSelected = false;
        isNightSelected = true;
        workShift = workshifts[1];
        colorWorkShift = Colors.deepPurple.shade400;
        _startDate = DateTime(
            _startDate.year, _startDate.month, _startDate.day, 15, 0, 0);
        _endDate =
            DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 0, 0);
      });
    }
  }

  final List<WorkShift> workshifts = [
    WorkShift(
        id: 1,
        name: "CA SÁNG",
        timeSlot: "( 7:00 - 15:00 )",
        startTime: 7,
        endTime: 15),
    WorkShift(
        id: 2,
        name: "CA TỐI",
        timeSlot: "( 15:00 - 23:00 )",
        startTime: 15,
        endTime: 23),
  ];
  String? txtSelectedDate;
  getDate() {
    DateTime selectedDate = widget.selectedDate;
    String day = DateFormat('EEEE').format(selectedDate);
    day = formatDay(day);
    setState(() {
      txtSelectedDate =
          "$day, ${DateFormat('dd/MM/yyyy').format(selectedDate)}";
    });
  }

  String formatDay(String day) {
    return dayNames[day.toLowerCase()] ?? day;
  }

  final Map<String, String> dayNames = {
    'monday': 'Thứ hai',
    'tuesday': 'Thứ ba',
    'wednesday': 'Thứ tư',
    'thursday': 'Thứ năm',
    'friday': 'Thứ sáu',
    'saturday': 'Thứ bảy',
    'sunday': 'Chủ nhật'
  };
}

class WorkShift {
  int? id;
  String? name;
  String? timeSlot;
  int? startTime;
  int? endTime;
  WorkShift({
    this.id,
    this.name,
    this.timeSlot,
    this.startTime,
    this.endTime,
  });
}

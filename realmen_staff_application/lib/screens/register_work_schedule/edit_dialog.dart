import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EditDialog extends StatefulWidget {
  const EditDialog(this.newAppointment, this.selectedAppointment,
      this.recurrenceProperties, this._dataSource,
      {super.key});

  final Appointment newAppointment, selectedAppointment;
  final RecurrenceProperties? recurrenceProperties;
  final CalendarDataSource _dataSource;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  _Edit _edit = _Edit.event;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Container(
          width: 380,
          height: 210,
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: 370,
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 30,
                  padding: const EdgeInsets.only(top: 5),
                  child: Center(
                    child: Text(
                      'lưu ca làm'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                ),
                RadioListTile<_Edit>(
                  title: const Text('Chỉ ca làm này'),
                  value: _Edit.event,
                  groupValue: _edit,
                  activeColor: Colors.blueAccent,
                  onChanged: (_Edit? value) {
                    setState(() {
                      _edit = value!;
                    });
                  },
                ),
                RadioListTile<_Edit>(
                  title: const Text('Cho tất cả ca làm lặp lại'),
                  value: _Edit.series,
                  groupValue: _edit,
                  activeColor: Colors.blueAccent,
                  onChanged: (_Edit? value) {
                    setState(() {
                      _edit = value!;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RawMaterialButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Quay lại',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                    RawMaterialButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      onPressed: () {
                        _save();
                      },
                      child: Text(
                        'Lưu'.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _save() {
    if (_edit == _Edit.event) {
      final Appointment? parentAppointment = widget._dataSource
              .getPatternAppointment(widget.selectedAppointment, '')
          as Appointment?;

      final Appointment newAppointment = Appointment(
        startTime: widget.newAppointment.startTime,
        endTime: widget.newAppointment.endTime,
        color: widget.newAppointment.color,
        notes: widget.newAppointment.notes,
        subject: widget.newAppointment.subject,
        resourceIds: widget.newAppointment.resourceIds,
        id: widget.selectedAppointment.appointmentType ==
                AppointmentType.changedOccurrence
            ? widget.selectedAppointment.id
            : null,
        recurrenceId: parentAppointment!.id,
      );

      parentAppointment.recurrenceExceptionDates != null
          ? parentAppointment.recurrenceExceptionDates!
              .add(widget.selectedAppointment.startTime)
          : parentAppointment.recurrenceExceptionDates = <DateTime>[
              widget.selectedAppointment.startTime
            ];
      widget._dataSource.appointments!.removeAt(
          widget._dataSource.appointments!.indexOf(parentAppointment));
      widget._dataSource.notifyListeners(
          CalendarDataSourceAction.remove, <Appointment>[parentAppointment]);
      widget._dataSource.appointments!.add(parentAppointment);
      widget._dataSource.notifyListeners(
          CalendarDataSourceAction.add, <Appointment>[parentAppointment]);
      if (widget.selectedAppointment.appointmentType ==
          AppointmentType.changedOccurrence) {
        widget._dataSource.appointments!.removeAt(widget
            ._dataSource.appointments!
            .indexOf(widget.selectedAppointment));
        widget._dataSource.notifyListeners(CalendarDataSourceAction.remove,
            <Appointment>[widget.selectedAppointment]);
      }
      widget._dataSource.appointments!.add(newAppointment);
      widget._dataSource.notifyListeners(
          CalendarDataSourceAction.add, <Appointment>[newAppointment]);
    } else {
      Appointment? parentAppointment = widget._dataSource.getPatternAppointment(
          widget.selectedAppointment, '') as Appointment?;

      final List<DateTime>? exceptionDates =
          parentAppointment!.recurrenceExceptionDates;
      if (exceptionDates != null && exceptionDates.isNotEmpty) {
        for (int i = 0; i < exceptionDates.length; i++) {
          final Appointment? changedOccurrence = widget._dataSource
              .getOccurrenceAppointment(
                  parentAppointment, exceptionDates[i], '');
          if (changedOccurrence != null) {
            widget._dataSource.appointments!.remove(changedOccurrence);
            widget._dataSource.notifyListeners(CalendarDataSourceAction.remove,
                <Appointment>[changedOccurrence]);
          }
        }
      }
      widget._dataSource.appointments!.removeAt(
          widget._dataSource.appointments!.indexOf(parentAppointment));
      widget._dataSource.notifyListeners(
          CalendarDataSourceAction.remove, <Appointment>[parentAppointment]);
      DateTime startDate, endDate;
      if (widget.newAppointment.startTime
          .isBefore(parentAppointment.startTime)) {
        startDate = widget.newAppointment.startTime;
        endDate = widget.newAppointment.endTime;
      } else {
        startDate = DateTime(
            parentAppointment.startTime.year,
            parentAppointment.startTime.month,
            parentAppointment.startTime.day,
            widget.newAppointment.startTime.hour,
            widget.newAppointment.startTime.minute);
        endDate = DateTime(
            parentAppointment.endTime.year,
            parentAppointment.endTime.month,
            parentAppointment.endTime.day,
            widget.newAppointment.endTime.hour,
            widget.newAppointment.endTime.minute);
      }
      parentAppointment = Appointment(
          startTime: startDate,
          endTime: endDate,
          color: widget.newAppointment.color,
          notes: widget.newAppointment.notes,
          isAllDay: widget.newAppointment.isAllDay,
          location: widget.newAppointment.location,
          subject: widget.newAppointment.subject,
          resourceIds: widget.newAppointment.resourceIds,
          id: parentAppointment.id,
          recurrenceRule: widget.recurrenceProperties == null
              ? null
              : SfCalendar.generateRRule(
                  widget.recurrenceProperties!, startDate, endDate),
          startTimeZone: widget.newAppointment.startTimeZone,
          endTimeZone: widget.newAppointment.endTimeZone);
      widget._dataSource.appointments!.add(parentAppointment);
      widget._dataSource.notifyListeners(
          CalendarDataSourceAction.add, <Appointment>[parentAppointment]);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

enum _Edit { event, series }

// ignore: unused_element, unused_field
enum _Delete { event, series }

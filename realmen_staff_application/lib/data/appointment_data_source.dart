// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WorkScheduleDataSource extends CalendarDataSource {
  List<WorkSchedule> source;
  WorkScheduleDataSource(this.source);

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].startTime!;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].endTime!;
  }

  @override
  String getSubject(int index) {
    return source[index].subject!;
  }

  @override
  Color getColor(int index) {
    return source[index].color!;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    final List<WorkSchedule> workSchedules = <WorkSchedule>[];
    DateTime date = DateTime(startDate.year, startDate.month, startDate.day);
    final DateTime appEndDate =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
    while (date.isBefore(appEndDate)) {
      final List<WorkSchedule> data = [];
      if (data == []) {
        date = date.add(const Duration(days: 1));
        continue;
      }

      for (final WorkSchedule workSchedule in data) {
        if (appointments.contains(workSchedule)) {
          continue;
        }

        workSchedules.add(workSchedule);
      }
      date = date.add(const Duration(days: 1));
    }

    appointments.addAll(workSchedules);
    notifyListeners(CalendarDataSourceAction.add, workSchedules);
  }
}

class WorkSchedule {
  String? subject;
  DateTime? startTime;
  DateTime? endTime;
  Color? color;
  WorkSchedule({
    this.subject,
    this.startTime,
    this.endTime,
    this.color,
  });
}

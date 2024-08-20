import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:realmen_staff_application/data/appointment_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'work_schedule_event.dart';
part 'work_schedule_state.dart';

class WorkScheduleBloc extends Bloc<WorkScheduleEvent, WorkScheduleState> {
  WorkScheduleBloc() : super(WorkScheduleInitial()) {
    on<WorkScheduleInitialEvent>(_workScheduleInitialEvent);
  }

  Future<FutureOr<void>> _workScheduleInitialEvent(
      WorkScheduleInitialEvent event, Emitter<WorkScheduleState> emit) async {
    emit(WorkScheduleLoadingState());
    WorkScheduleDataSource loadedDataSource =
        WorkScheduleDataSource(<WorkSchedule>[]);
    String shiftMorning = "MORNING";
    String shiftNight = "NIGHT";
    Color colorMorning = Colors.deepOrange.shade400;
    Color colorNight = Colors.deepPurple.shade400;

    List<WorkSchedule> loadedAppointment = [
      // SANG
      WorkSchedule(
        startTime: DateTime(2024, 8, 14, 7, 0, 0),
        endTime: DateTime(2024, 8, 14, 15, 0, 0),
        color: colorMorning,
        subject: shiftMorning,
      ),
      WorkSchedule(
        startTime: DateTime(2024, 8, 17, 7, 0, 0),
        endTime: DateTime(2024, 8, 17, 15, 0, 0),
        color: colorMorning,
        subject: shiftMorning,
      ),
      WorkSchedule(
        startTime: DateTime(2024, 8, 16, 7, 0, 0),
        endTime: DateTime(2024, 8, 16, 15, 0, 0),
        color: colorMorning,
        subject: shiftMorning,
      ),

      // TOI
      WorkSchedule(
        startTime: DateTime(2024, 8, 21, 15, 0, 0),
        endTime: DateTime(2024, 8, 21, 23, 0, 0),
        color: colorNight,
        subject: shiftNight,
      ),
      WorkSchedule(
        startTime: DateTime(2024, 8, 23, 15, 0, 0),
        endTime: DateTime(2024, 8, 23, 23, 0, 0),
        color: colorNight,
        subject: shiftNight,
      ),

      // SO LE
      WorkSchedule(
        startTime: DateTime(2024, 8, 26, 7, 0, 0),
        endTime: DateTime(2024, 8, 26, 15, 0, 0),
        color: colorMorning,
        subject: shiftMorning,
      ),
      WorkSchedule(
        startTime: DateTime(2024, 8, 26, 15, 0, 0),
        endTime: DateTime(2024, 8, 26, 23, 0, 0),
        color: colorNight,
        subject: shiftNight,
      ),
      WorkSchedule(
        startTime: DateTime(2024, 8, 30, 7, 0, 0),
        endTime: DateTime(2024, 8, 30, 15, 0, 0),
        color: colorMorning,
        subject: shiftMorning,
      ),
    ];
    await Future.delayed(const Duration(seconds: 2));
    loadedDataSource.appointments.addAll(loadedAppointment);
    loadedDataSource.notifyListeners(
        CalendarDataSourceAction.add, loadedAppointment);
    emit(WorkScheduleLoadedSuccessState(loadedDataSource: loadedDataSource));
  }
}

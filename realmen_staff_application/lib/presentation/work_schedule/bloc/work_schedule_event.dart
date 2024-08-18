part of 'work_schedule_bloc.dart';

sealed class WorkScheduleEvent extends Equatable {
  const WorkScheduleEvent();

  @override
  List<Object> get props => [];
}

class WorkScheduleInitialEvent extends WorkScheduleEvent {}

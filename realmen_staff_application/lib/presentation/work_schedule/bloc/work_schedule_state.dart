part of 'work_schedule_bloc.dart';

sealed class WorkScheduleState extends Equatable {
  const WorkScheduleState();

  @override
  List<Object> get props => [];
}

final class WorkScheduleInitial extends WorkScheduleState {}

final class WorkScheduleLoadingState extends WorkScheduleState {}

final class WorkScheduleLoadedSuccessState extends WorkScheduleState {
  final WorkScheduleDataSource? loadedDataSource;

  WorkScheduleLoadedSuccessState({required this.loadedDataSource});
}

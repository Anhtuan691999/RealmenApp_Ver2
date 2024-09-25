// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_bloc.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class BookingInitialEvent extends BookingEvent {}

class BookingShowBranchEvent extends BookingEvent {}

class ChooseBranchBookingSelectBranchEvent extends BookingEvent {}

class ChooseBranchBookingSelectBranchGetBackEvent extends BookingEvent {}

class ChooseBranchBookingSelectedBranchEvent extends BookingEvent {
  final BranchDataModel selectedBranch;
  const ChooseBranchBookingSelectedBranchEvent({
    required this.selectedBranch,
  });
  @override
  List<Object> get props => [selectedBranch];
}

class BookingShowServiceEvent extends BookingEvent {}

class ChooseBranchBookingSelectedServiceEvent extends BookingEvent {
  final List<ServiceDataModel> selectedServices;
  const ChooseBranchBookingSelectedServiceEvent({
    required this.selectedServices,
  });
  @override
  List<Object> get props => [selectedServices];
}

class ChooseBranchBookingSelectServiceGetBackEvent extends BookingEvent {}

class BranchChooseSelectDateEvent extends BookingEvent {
  Object? value;
  BranchChooseSelectDateEvent({
    this.value,
  });
}

class BranchChooseDateLoadedEvent extends BookingEvent {
  List<ServiceDataModel> selectedServices;
  BranchChooseDateLoadedEvent({
    required this.selectedServices,
  });
}

//staff

class BranchChooseStaffLoadedEvent extends BookingEvent {}

class BranchChooseSelectStaffEvent extends BookingEvent {
  DailyPlanAccountModel selectedStaff;
  BranchChooseSelectStaffEvent({
    required this.selectedStaff,
  });
}

class BranchChooseSelectDefaultStaffEvent extends BookingEvent {}

class BranchChooseSelectOptAllOrSingleModeEvent extends BookingEvent {}

// time slot
class onTimeSlotSelectedEvent extends BookingEvent {
  String timeSlot;
  onTimeSlotSelectedEvent({
    required this.timeSlot,
  });
}

class GetTimeSlotEvent extends BookingEvent {}

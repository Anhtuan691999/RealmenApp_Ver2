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

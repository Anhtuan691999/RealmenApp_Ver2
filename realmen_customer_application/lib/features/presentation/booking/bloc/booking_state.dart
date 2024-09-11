part of 'booking_bloc.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingDataState extends BookingState {
  BranchDataModel? selectedBranch;
  List<ServiceDataModel>? selectedService;
  // AccountInfoModel? selectedStylist;
  // AccountInfoModel? selectedMassur;
  dynamic selectedDate;
  dynamic selectedTime;
}

final class BookingInitial extends BookingState {}

class ShowBookingBranchState extends BookingState {}

class ChooseBranchBookingSelectBranchGetBackState extends BookingState {}

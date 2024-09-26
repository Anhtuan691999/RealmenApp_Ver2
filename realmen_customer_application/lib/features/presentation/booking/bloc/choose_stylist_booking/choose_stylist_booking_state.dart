// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'choose_stylist_booking_bloc.dart';

sealed class ChooseStylistBookingState extends Equatable {
  const ChooseStylistBookingState();

  @override
  List<Object> get props => [];
}

final class ChooseStylistBookingInitial extends ChooseStylistBookingState {}

class CSBLoadingState extends ChooseStylistBookingState {}

// choose stylist
class CSBShowStylistState extends ChooseStylistBookingState {}

class CSBSelectStylistGetBackState extends ChooseStylistBookingState {}

class CSBSelectedStylistState extends ChooseStylistBookingState {
  AccountModel selectedStylist;
  CSBSelectedStylistState({
    required this.selectedStylist,
  });
}

//choose date
class ShowBookingDateState extends ChooseStylistBookingState {}

class CSBLoadDateState extends ChooseStylistBookingState {
  List<Map<String, dynamic>>? listDate;
  String? dateController;
  Map<String, dynamic>? dateSeleted;
  DailyPlanAccountModel selectedStaff ;

  CSBLoadDateState({
    this.listDate,
    this.dateController,
    this.dateSeleted,
     required this.selectedStaff,
  });
}

class CSBSelectDateState extends ChooseStylistBookingState {
  String? dateController;
  Map<String, dynamic>? dateSeleted;
  List<Map<String, dynamic>>? listDate;

  CSBSelectDateState({
    this.listDate,
    this.dateController,
    this.dateSeleted,
  });
}

// choose service
class CSBSelectServiceState extends ChooseStylistBookingState {
  List<ServiceDataModel> selectedServices;
  CSBSelectServiceState({
    required this.selectedServices,
  });
}

class CSBShowServiceState extends ChooseStylistBookingState {}

class CSBSelectServiceGetBackState extends ChooseStylistBookingState {}

// choose time slot
class CSBChooseTimeSlotLoadedState extends ChooseStylistBookingState {
  List<TimeSlotCardModel> timeSlotCards;
  CSBChooseTimeSlotLoadedState({
    required this.timeSlotCards,
  });
}

class CSBShowBookingTemporaryState extends ChooseStylistBookingState {}

class CSBChooseSelectedTimeSlotState extends ChooseStylistBookingState {
  String selectedTimeSlot;
  List<TimeSlotCardModel> timeSlotCards;

  CSBChooseSelectedTimeSlotState({
    required this.selectedTimeSlot,
    required this.timeSlotCards,
  });
}

class CSBShowSnackBarActionState extends ChooseStylistBookingState {
  final String message;
  final bool status;

  const CSBShowSnackBarActionState({required this.status, required this.message});
}

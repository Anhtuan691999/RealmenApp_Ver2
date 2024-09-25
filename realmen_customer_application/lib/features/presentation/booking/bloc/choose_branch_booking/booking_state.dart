// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_bloc.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class BookingDataState extends BookingState {
  BranchDataModel? selectedBranch;
  List<ServiceDataModel>? selectedService;
  List<ServiceDataModel>? selectedServicesStylist;
  List<ServiceDataModel>? selectedServicesMassur;
  // AccountInfoModel? selectedStylist;
  // AccountInfoModel? selectedMassur;
  dynamic selectedDate;
  dynamic selectedTime;
  BookingDataState({
    this.selectedBranch,
    this.selectedService,
    this.selectedDate,
    this.selectedTime,
    this.selectedServicesStylist,
    this.selectedServicesMassur,
  });
}

final class BookingInitial extends BookingState {}

class LoadingState extends BookingState {}

class ShowBookingBranchState extends BookingState {}

class ChooseBranchBookingSelectBranchGetBackState extends BookingState {}

class ChooseBranchBookingSelectedBranchState extends BookingState {
  BranchDataModel? selectedBranch;
  List<ServiceDataModel>? selectedServices;
  List<ServiceDataModel>? selectedServicesStylist;
  List<ServiceDataModel>? selectedServicesMassur;
  ChooseBranchBookingSelectedBranchState({
    this.selectedBranch,
    this.selectedServices,
    this.selectedServicesStylist,
    this.selectedServicesMassur,
  });
}

class BookingShowServiceState extends BookingState {}

class ChooseBranchBookingSelectedServiceState extends BookingState {
  List<ServiceDataModel> selectedServices;
  List<ServiceDataModel> selectedServicesStylist;
  List<ServiceDataModel> selectedServicesMassur;
  ChooseBranchBookingSelectedServiceState({
    required this.selectedServices,
    required this.selectedServicesStylist,
    required this.selectedServicesMassur,
  });
}

class ChooseBranchBookingSelectServiceGetBackState extends BookingState {}

class ShowBookingDateState extends BookingState {}

// choose date
class BranchChooseDateLoadDateState extends BookingState {
  List<Map<String, dynamic>>? listDate;
  String? dateController;
  Map<String, dynamic>? dateSeleted;

  List<ServiceDataModel> selectedServices;
  BranchChooseDateLoadDateState({
    this.listDate,
    this.dateController,
    this.dateSeleted,
    required this.selectedServices,
  });
}

class BranchChooseSelectDateState extends BookingState {
  String? dateController;
  Map<String, dynamic>? dateSeleted;
  List<ServiceDataModel> selectedServices;
  List<Map<String, dynamic>>? listDate;

  BranchChooseSelectDateState({
    this.listDate,
    this.dateController,
    required this.selectedServices,
    this.dateSeleted,
  });
}

class BranchChooseStaffLoadedState extends BookingState {
  List<DailyPlanAccountModel>? accountStylistList;
  List<DailyPlanAccountModel>? accountMassurList;
  List<ServiceDataModel> selectedServicesStylist;
  List<ServiceDataModel> selectedServicesMassur;
  BranchChooseStaffLoadedState({
    required this.accountStylistList,
    required this.accountMassurList,
    required this.selectedServicesStylist,
    required this.selectedServicesMassur,
  });
}

class BranchChooseSelectedStaffState extends BookingState {
  DailyPlanAccountModel selectedStaff;
  bool isDefaultSelected;
  BranchChooseSelectedStaffState({
    required this.selectedStaff,
    required this.isDefaultSelected,
  });
}

class BranchChooseTimeSlotLoadedState extends BookingState {
  List<TimeSlotCardModel> timeSlotCards;
  BranchChooseTimeSlotLoadedState({
    required this.timeSlotCards,
  });
}

class ShowBookingTemporaryState extends BookingState {}

class BranchChooseSelectedTimeSlotState extends BookingState {
  String selectedTimeSlot;
  List<TimeSlotCardModel> timeSlotCards;

  BranchChooseSelectedTimeSlotState({
    required this.selectedTimeSlot,
    required this.timeSlotCards,
  });
}

class ShowSnackBarActionState extends BookingState {
  final String message;
  final bool status;

  ShowSnackBarActionState({required this.status, required this.message});
}

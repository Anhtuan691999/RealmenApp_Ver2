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
  // AccountInfoModel? selectedStylist;
  // AccountInfoModel? selectedMassur;
  dynamic selectedDate;
  dynamic selectedTime;
  BookingDataState({
    this.selectedBranch,
    this.selectedService,
    this.selectedDate,
    this.selectedTime,
  });

  BookingDataState copyWith({
    BranchDataModel? selectedBranch,
    List<ServiceDataModel>? selectedService,
    dynamic selectedDate,
    dynamic selectedTime,
  }) {
    return BookingDataState(
      selectedBranch: selectedBranch ?? this.selectedBranch,
      selectedService: selectedService ?? this.selectedService,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
}

final class BookingInitial extends BookingState {}

class LoadingState extends BookingState {}

class ShowBookingBranchState extends BookingState {}

class ChooseBranchBookingSelectBranchGetBackState extends BookingState {}

class ChooseBranchBookingSelectedBranchState extends BookingState {
  BranchDataModel? selectedBranch;
  List<ServiceDataModel> selectedServices;
  ChooseBranchBookingSelectedBranchState(
      {this.selectedBranch, required this.selectedServices});
}

class BookingShowServiceState extends BookingState {}

class ChooseBranchBookingSelectedServiceState extends BookingState {
  List<ServiceDataModel> selectedServices;
  ChooseBranchBookingSelectedServiceState({
    required this.selectedServices,
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
  List<AccountModel>? accountStylistList;
  List<AccountModel>? accountMassurList;
  BranchChooseStaffLoadedState({
    required this.accountMassurList,
    required this.accountStylistList,
  });
}

class BranchChooseSelectedStaffState extends BookingState {
  AccountModel selectedStaff;
  bool isDefaultSelected;
  BranchChooseSelectedStaffState({
    required this.selectedStaff,
    required this.isDefaultSelected,
  });
}

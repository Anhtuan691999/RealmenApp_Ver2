part of 'choose_stylist_booking_bloc.dart';

sealed class ChooseStylistBookingEvent extends Equatable {
  const ChooseStylistBookingEvent();

  @override
  List<Object> get props => [];
}

class CSBInitialEvent extends ChooseStylistBookingEvent {}

// choose stylist
class CSBShowStylistEvent extends ChooseStylistBookingEvent {}

class CSBSelectStylistGetBackEvent extends ChooseStylistBookingEvent {}

class CSBSelectedStylistEvent extends ChooseStylistBookingEvent {
  AccountModel selectedStylist;
  CSBSelectedStylistEvent({
    required this.selectedStylist,
  });
}

// choose date
class CSBChooseSelectDateEvent extends ChooseStylistBookingEvent {
  Object? value;
  CSBChooseSelectDateEvent({
    this.value,
  });
}

class CSBChooseDateLoadedEvent extends ChooseStylistBookingEvent {}

// choose service
class CSBShowServiceEvent extends ChooseStylistBookingEvent {}

class CSBSelectedServiceEvent extends ChooseStylistBookingEvent {
  final List<ServiceDataModel> selectedServices;
  const CSBSelectedServiceEvent({
    required this.selectedServices,
  });
  @override
  List<Object> get props => [selectedServices];
}

class CSBSelectServiceGetBackEvent extends ChooseStylistBookingEvent {}

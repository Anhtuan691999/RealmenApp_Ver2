// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'choose_service_page_bloc.dart';

sealed class ChooseServicePageEvent extends Equatable {
  const ChooseServicePageEvent();

  @override
  List<Object> get props => [];
}

class ChooseServicePageInitialEvent extends ChooseServicePageEvent {
  final int branchId;
  final List<ServiceDataModel> selectedServices;
  const ChooseServicePageInitialEvent({
    required this.branchId,
    required this.selectedServices,
  });
}

class ChooseServiceSelectedEvent extends ChooseServicePageEvent {
  ServiceDataModel selectedService;
  ChooseServiceSelectedEvent({
    required this.selectedService,
  });
}

class ChooseServicePageLoadedSuccessEvent extends ChooseServicePageEvent {}

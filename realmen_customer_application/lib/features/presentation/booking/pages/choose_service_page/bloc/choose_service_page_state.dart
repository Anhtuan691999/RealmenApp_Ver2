// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'choose_service_page_bloc.dart';

sealed class ChooseServicePageState extends Equatable {
  const ChooseServicePageState();

  @override
  List<Object> get props => [];
}

final class ChooseServicePageInitial extends ChooseServicePageState {}

class LoadingState extends ChooseServicePageState {}

class ChooseServicePageLoadingPageState extends ChooseServicePageState {}

class ChooseServicePageLoadedSuccessState extends ChooseServicePageState {
  List<ServiceCategoryModel> serviceCatagoryList;
  List<ServiceDataModel> selectedServices;
  ChooseServicePageLoadedSuccessState({
    required this.serviceCatagoryList,
    required this.selectedServices,
  });
}

class ChooseServicePageNoDataState extends ChooseServicePageState {}

class ChooseServiceSelectedState extends ChooseServicePageState {}

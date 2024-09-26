part of 'list_service_page_bloc.dart';

sealed class ListServicePageState extends Equatable {
  const ListServicePageState();

  @override
  List<Object> get props => [];
}

final class ListServicePageInitial extends ListServicePageState {}

class SPLLoadingState extends ListServicePageState {}

class SPLChooseServicePageLoadingPageState extends ListServicePageState {}

class SPLChooseServicePageLoadedSuccessState extends ListServicePageState {
  List<ServiceCategoryModel> serviceCatagoryList;

  SPLChooseServicePageLoadedSuccessState({
    required this.serviceCatagoryList,
  });
}

class SPLChooseServicePageNoDataState extends ListServicePageState {}

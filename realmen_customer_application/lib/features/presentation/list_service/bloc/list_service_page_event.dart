part of 'list_service_page_bloc.dart';

sealed class ListServicePageEvent extends Equatable {
  const ListServicePageEvent();

  @override
  List<Object> get props => [];
}

class SPLChooseServicePageInitialEvent extends ListServicePageEvent {}

class SPLChooseServicePageLoadedSuccessEvent extends ListServicePageEvent {}

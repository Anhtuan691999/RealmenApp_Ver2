// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class HomePageInitialEvent extends HomePageEvent {}

class ShowBranchPageEvent extends HomePageEvent {}

class LoadedBranchProvinceListEvent extends HomePageEvent {}

class ShowRealMenMemberPageEvent extends HomePageEvent {}

class ShowBookingHistoryPageEvent extends HomePageEvent {}

class ShowBookingConfirmationPageEvent extends HomePageEvent {}

class ShowServicePageEvent extends HomePageEvent {
  final List<ServiceDataModel>? loadedServicesList;
  ShowServicePageEvent({
    this.loadedServicesList,
  });
}

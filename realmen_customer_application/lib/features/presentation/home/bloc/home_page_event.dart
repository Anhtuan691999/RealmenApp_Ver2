// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class HomePageInitialEvent extends HomePageEvent {}

class ShowBranchEvent extends HomePageEvent {
  final List<BranchDataModel>? loadedBranchsList;
  ShowBranchEvent({
    this.loadedBranchsList,
  });
}

class ShowRealMenMemberEvent extends HomePageEvent {}

class ShowBookingHistoryEvent extends HomePageEvent {}

class ShowBookingConfirmationEvent extends HomePageEvent {}

class ShowServiceEvent extends HomePageEvent {
  final List<ServiceDataModel>? loadedServicesList;
  ShowServiceEvent({
    this.loadedServicesList,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

abstract class HomePageActionState extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageLoadedSuccessState extends HomePageState {
  final List<BranchDataModel> loadedBranchsList;
  // final List<StylistDataModel> loadedStylistsList;
  final List<ServiceDataModel> loadedServicesList;

  HomePageLoadedSuccessState({
    required this.loadedBranchsList,
    // required this.loadedStylistsList,
    required this.loadedServicesList,
  });
}

class ShowBranchOverviewPageState extends HomePageActionState {}

class LoadedBranchProvinceListState extends HomePageActionState {
  final List<BranchProvince> branchProvinceList;
  LoadedBranchProvinceListState({
    required this.branchProvinceList,
  });
}

class LoadingBranchProvinceListState extends HomePageActionState {}

class ShowRealMenMemberPageState extends HomePageActionState {}

class ShowBookingHistoryPageState extends HomePageActionState {}

class ShowBookingConfirmationPageState extends HomePageActionState {}

part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageLoadedSuccessState extends HomePageState {
  final List<BranchDataModel> loadedBranchsList;
  // final List<StylistDataModel> loadedStylistsList;
  // final List<ServiceDataModel> loadedServicesList;

  HomePageLoadedSuccessState({
    required this.loadedBranchsList,
    // required this.loadedStylistsList,
    // required this.loadedServicesList,
  });
}

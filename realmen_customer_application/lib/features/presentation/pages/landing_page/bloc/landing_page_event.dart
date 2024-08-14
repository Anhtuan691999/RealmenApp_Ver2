part of 'landing_page_bloc.dart';

@immutable
sealed class LandingPageEvent extends Equatable {
  const LandingPageEvent();

  @override
  List<Object> get props => [];
}

class LandingPageInitialEvent extends LandingPageEvent {}

class LandingPageTabChangeEvent extends LandingPageEvent {
  final int bottomIndex;

  const LandingPageTabChangeEvent({required this.bottomIndex});
}

class ShowServiceEvent extends LandingPageEvent {
  final List<ServiceDataModel>? loadedServicesList;
  ShowServiceEvent({
    this.loadedServicesList,
  });
}

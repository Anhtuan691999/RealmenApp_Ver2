part of 'landing_page_bloc.dart';

sealed class LandingPageState extends Equatable {
  const LandingPageState();

  @override
  List<Object> get props => [];
}

class LandingPageInitial extends LandingPageState {
  final int bottomIndex;

  const LandingPageInitial({required this.bottomIndex});
}

class TabChangeActionState extends LandingPageInitial {
  const TabChangeActionState({required super.bottomIndex});
}

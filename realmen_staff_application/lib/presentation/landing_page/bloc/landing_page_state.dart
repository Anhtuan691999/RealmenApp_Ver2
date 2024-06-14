part of 'landing_page_bloc.dart';

@immutable
sealed class LandingPageState {}

class LandingPageInitial extends LandingPageState {
  final int bottomIndex;

  LandingPageInitial({required this.bottomIndex});
}

class TabChangeActionState extends LandingPageInitial {
  TabChangeActionState({required super.bottomIndex});
}

part of 'auth_bloc.dart';

sealed class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

abstract class AuthenticationActionState extends AuthenticationState {}

class ShowLoginPageState extends AuthenticationState {}

class ShowLoadingActionState extends AuthenticationActionState {}

class ShowSnackBarActionState extends AuthenticationActionState {
  final String message;
  final bool status;

  ShowSnackBarActionState({required this.status, required this.message});
}

class ShowLandingPageState extends AuthenticationActionState {}

class AuthenticationLoadingState extends AuthenticationActionState {
  final bool isLoading;

  AuthenticationLoadingState({required this.isLoading});
}

class AuthenticationSuccessState extends AuthenticationActionState {
  final String token;

  AuthenticationSuccessState({required this.token});
}

class AuthPageInvalidPhoneActionState extends AuthenticationActionState {}

class AuthPageInvalidPasswordActionState extends AuthenticationActionState {}

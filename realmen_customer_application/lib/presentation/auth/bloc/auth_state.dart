part of 'auth_bloc.dart';

sealed class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

abstract class AuthenticationActionState extends AuthenticationState {}

class ShowCreateOtpPageState extends AuthenticationState {
  final String? phone;

  ShowCreateOtpPageState({this.phone});
}

class ShowLoginPageState extends AuthenticationState {}

class ShowLoadingActionState extends AuthenticationActionState {}

class ShowSnackBarActionState extends AuthenticationActionState {
  final String message;
  final bool status;

  ShowSnackBarActionState({required this.status, required this.message});
}

class ShowRegisterPageState extends AuthenticationState {
  final String? phone;

  ShowRegisterPageState({this.phone});
}

class RegisterLoadingState extends AuthenticationActionState {}

class AuthenticationLoadingState extends AuthenticationActionState {
  final bool isLoading;

  AuthenticationLoadingState({required this.isLoading});
}

class RegisterSuccessState extends AuthenticationActionState {}

class AuthenticationSuccessState extends AuthenticationActionState {
  final String token;

  AuthenticationSuccessState({required this.token});
}

class AuthPageInvalidPhoneActionState extends AuthenticationActionState {}

class AuthPageInvalidOtpActionState extends AuthenticationActionState {}

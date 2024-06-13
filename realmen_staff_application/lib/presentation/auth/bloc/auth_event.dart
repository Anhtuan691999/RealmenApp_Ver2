// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

//1
class AuthenticationInitialEvent extends AuthenticationEvent {}

//2
class AuthenticationShowLoginEvent extends AuthenticationEvent {}


//3
class AuthenticationLoginEvent extends AuthenticationEvent {
  final String phone;
  final String password;
  AuthenticationLoginEvent({
    required this.phone,
    required this.password,
  });
}


//4
class AuthenticationInvalidPhoneInLoginEvent extends AuthenticationEvent {}

//5
class AuthenticationInvalidPasswordInLoginEvent extends AuthenticationEvent {}

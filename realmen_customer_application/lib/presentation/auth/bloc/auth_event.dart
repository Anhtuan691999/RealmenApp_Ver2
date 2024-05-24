// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

//1
class AuthenticationInitialEvent extends AuthenticationEvent {}

//2
class AuthenticationShowCreateOtpEvent extends AuthenticationEvent {
  final String? phone;

  AuthenticationShowCreateOtpEvent({this.phone});
}

class AuthenticationShowLoginEvent extends AuthenticationEvent {}

//3
class AuthenticationShowRegisterEvent extends AuthenticationEvent {
  final String? phone;

  AuthenticationShowRegisterEvent({this.phone});
}

//4
class AuthenticationInputPhoneEvent extends AuthenticationEvent {
  final String phone;
  AuthenticationInputPhoneEvent({
    required this.phone,
  });
}

//5
class AuthenticationLoginEvent extends AuthenticationEvent {
  final String phone;
  final String otp;
  AuthenticationLoginEvent({
    required this.phone,
    required this.otp,
  });
}

//6
class AuthenticationRegisterEvent extends AuthenticationEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String thumbnail;
  final String dob;
  final String gender;

  AuthenticationRegisterEvent(
      {required this.firstName,
      required this.lastName,
      required this.phone,
      required this.thumbnail,
      required this.dob,
      required this.gender});
}

//7
class AuthenticationInvalidPhoneInLoginEvent extends AuthenticationEvent {}

//8
class AuthenticationInvalidOtpInLoginEvent extends AuthenticationEvent {}

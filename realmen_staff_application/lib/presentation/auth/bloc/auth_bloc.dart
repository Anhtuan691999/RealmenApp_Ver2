import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realmen_staff_application/data/models/account_model.dart';
import 'package:realmen_staff_application/data/shared_preferences/auth_pref.dart';

import '../../../repository/AuthRepo/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationInitialEvent>(_authenticationInitialEvent);

    on<AuthenticationShowLoginEvent>(_authenticationShowLoginEvent);

    on<AuthenticationLoginEvent>(_authenticationLoginEvent);

    on<AuthenticationInvalidPhoneInLoginEvent>(
        _authenticationInvalidPhoneInLoginEvent);
    on<AuthenticationInvalidPasswordInLoginEvent>(
        _authenticationInvalidPasswordInLoginEvent);
  }

  //1
  FutureOr<void> _authenticationInitialEvent(
      AuthenticationInitialEvent event, Emitter<AuthenticationState> emit) {
    emit(ShowLoginPageState());
  }

  //2

  FutureOr<void> _authenticationShowLoginEvent(
      AuthenticationShowLoginEvent event, Emitter<AuthenticationState> emit) {
    emit(ShowLoginPageState());
  }

  //5
  late String rawToken;
  FutureOr<void> _authenticationLoginEvent(
      AuthenticationLoginEvent event, Emitter<AuthenticationState> emit) async {
    // emit(AuthenticationLoadingState(isLoading: true));
    // var results = await AuthRepository().login(event.phone, event.password);
    // var responseMessage = results['message'];
    // var responseStatus = results['status'];
    // var responseBody = results['body'];
    // if (responseStatus) {
    //   emit(AuthenticationLoadingState(isLoading: false));
    //   rawToken = responseBody['value']['accessToken'];
    //   String role = responseBody['value']['accessToken'];

    //   // save info acc
    //   AuthPref.setToken(rawToken);
    //   AuthPref.setRole(role);

    //   emit(ShowSnackBarActionState(
    //       message: "Đăng nhập thành công", status: responseStatus));
    //   emit(AuthenticationSuccessState(token: rawToken));
    // } else {
    //   emit(AuthenticationLoadingState(isLoading: false));
    //   emit(ShowSnackBarActionState(
    //       message: responseMessage, status: responseStatus));
    // }
    emit(ShowLandingPageState());
  }

  //7
  FutureOr<void> _authenticationInvalidPhoneInLoginEvent(
      AuthenticationInvalidPhoneInLoginEvent event,
      Emitter<AuthenticationState> emit) {
    emit(AuthPageInvalidPhoneActionState());
  }

  //8
  FutureOr<void> _authenticationInvalidPasswordInLoginEvent(
      AuthenticationInvalidPasswordInLoginEvent event,
      Emitter<AuthenticationState> emit) {
    emit(AuthPageInvalidPasswordActionState());
  }
}

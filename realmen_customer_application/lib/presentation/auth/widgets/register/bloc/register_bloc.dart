import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterInitialEvent>(_registerInitialEvent);
    on<RegisterSelectGenderEvent>(_registerSelectGenderEvent);
  }

  //1
  FutureOr<void> _registerInitialEvent(
      RegisterInitialEvent event, Emitter<RegisterState> emit) {}

//2
  FutureOr<void> _registerSelectGenderEvent(
      RegisterSelectGenderEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterSelectGenderState(gender: event.gender));
  }
}

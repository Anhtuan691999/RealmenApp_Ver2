import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';

part 'landing_page_event.dart';
part 'landing_page_state.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageInitial> {
  LandingPageBloc() : super(LandingPageInitial(bottomIndex: 0)) {
    on<LandingPageTabChangeEvent>(_landingPageTabChangeEvent);
    on<LandingPageInitialEvent>(_landingPageInitialEvent);
  }

  FutureOr<void> _landingPageInitialEvent(
      LandingPageEvent event, Emitter<LandingPageState> emit) {}

  FutureOr<void> _landingPageTabChangeEvent(
      LandingPageTabChangeEvent event, Emitter<LandingPageState> emit) {
    emit(TabChangeActionState(bottomIndex: event.bottomIndex));
  }
}

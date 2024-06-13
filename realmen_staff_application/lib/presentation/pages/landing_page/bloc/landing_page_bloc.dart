import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'landing_page_event.dart';
part 'landing_page_state.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageInitial> {
  LandingPageBloc() : super(const LandingPageInitial(bottomIndex: 0)) {
    on<LandingPageTabChangeEvent>(_landingPageTabChangeEvent);
  }
  FutureOr<void> _landingPageTabChangeEvent(
      LandingPageTabChangeEvent event, Emitter<LandingPageState> emit) {
    emit(TabChangeActionState(bottomIndex: event.bottomIndex));
  }
}

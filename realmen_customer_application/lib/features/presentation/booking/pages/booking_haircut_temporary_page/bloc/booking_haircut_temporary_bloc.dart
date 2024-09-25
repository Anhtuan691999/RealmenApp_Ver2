import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

part 'booking_haircut_temporary_event.dart';
part 'booking_haircut_temporary_state.dart';

class BookingHaircutTemporaryBloc
    extends Bloc<BookingHaircutTemporaryEvent, BookingHaircutTemporaryState> {
  BookingHaircutTemporaryBloc() : super(BookingHaircutTemporaryInitial()) {
    on<BookingHaircutTemporaryInitialEvent>(
        _bookingHaircutTemporaryInitialEvent);
  }

  FutureOr<void> _bookingHaircutTemporaryInitialEvent(
      BookingHaircutTemporaryInitialEvent event,
      Emitter<BookingHaircutTemporaryState> emit) {}
}

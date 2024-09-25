part of 'booking_haircut_temporary_bloc.dart';

sealed class BookingHaircutTemporaryEvent extends Equatable {
  const BookingHaircutTemporaryEvent();

  @override
  List<Object> get props => [];
}

class BookingHaircutTemporaryInitialEvent
    extends BookingHaircutTemporaryEvent {}

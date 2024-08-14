part of 'booking_bloc.dart';

sealed class BookingState extends Equatable {
  const BookingState();
  
  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {}

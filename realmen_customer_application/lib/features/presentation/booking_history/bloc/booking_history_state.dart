part of 'booking_history_bloc.dart';

sealed class BookingHistoryState extends Equatable {
  const BookingHistoryState();
  
  @override
  List<Object> get props => [];
}

final class BookingHistoryInitial extends BookingHistoryState {}

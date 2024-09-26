part of 'booking_processing_page_bloc.dart';

sealed class BookingProcessingPageState extends Equatable {
  const BookingProcessingPageState();
  
  @override
  List<Object> get props => [];
}

final class BookingProcessingPageInitial extends BookingProcessingPageState {}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_processing_page_event.dart';
part 'booking_processing_page_state.dart';

class BookingProcessingPageBloc extends Bloc<BookingProcessingPageEvent, BookingProcessingPageState> {
  BookingProcessingPageBloc() : super(BookingProcessingPageInitial()) {
    on<BookingProcessingPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

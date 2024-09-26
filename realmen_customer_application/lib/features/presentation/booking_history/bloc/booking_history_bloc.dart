import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_history_event.dart';
part 'booking_history_state.dart';

class BookingHistoryBloc extends Bloc<BookingHistoryEvent, BookingHistoryState> {
  BookingHistoryBloc() : super(BookingHistoryInitial()) {
    on<BookingHistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

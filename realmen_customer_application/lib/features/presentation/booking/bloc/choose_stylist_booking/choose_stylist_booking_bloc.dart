import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'choose_stylist_booking_event.dart';
part 'choose_stylist_booking_state.dart';

class ChooseStylistBookingBloc extends Bloc<ChooseStylistBookingEvent, ChooseStylistBookingState> {
  ChooseStylistBookingBloc() : super(ChooseStylistBookingInitial()) {
    on<ChooseStylistBookingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

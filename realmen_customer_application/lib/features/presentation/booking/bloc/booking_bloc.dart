import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<BookingInitialEvent>(_bookingInitialEvent);
    on<BookingShowBranchEvent>(_bookingShowBranchEvent);
    on<ChooseBranchBookingSelectBranchGetBackEvent>(
        _chooseBranchBookingSelectBranchGetBackEvent);
    on<ChooseBranchBookingSelectedBranchEvent>(
        _chooseBranchBookingSelectedBranchEvent);
  }

  FutureOr<void> _bookingInitialEvent(
      BookingInitialEvent event, Emitter<BookingState> emit) {}

  FutureOr<void> _bookingShowBranchEvent(
      BookingShowBranchEvent event, Emitter<BookingState> emit) {
    emit(ShowBookingBranchState());
  }

  FutureOr<void> _chooseBranchBookingSelectBranchGetBackEvent(
      ChooseBranchBookingSelectBranchGetBackEvent event,
      Emitter<BookingState> emit) {
    emit(ChooseBranchBookingSelectBranchGetBackState());
  }

  FutureOr<void> _chooseBranchBookingSelectedBranchEvent(
      ChooseBranchBookingSelectedBranchEvent event,
      Emitter<BookingState> emit) async {
    try {
      emit(ChooseBranchBookingSelectedBranchState());

      // Lấy trạng thái hiện tại nếu là BookingDataState
      if (state is BookingDataState) {
        final currentState = state as BookingDataState;

        // Cập nhật state với chi nhánh mới
        emit(currentState.copyWith(
          selectedBranch: event.selectedBranch,
        ));
      } else {
        // Nếu state hiện tại không phải BookingDataState, tạo state mới với chi nhánh được chọn
        emit(BookingDataState(selectedBranch: event.selectedBranch));
      }
    } catch (e) {}
  }
}

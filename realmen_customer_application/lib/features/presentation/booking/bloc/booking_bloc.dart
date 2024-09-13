import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BranchDataModel? _selectedBranch;
  List<ServiceDataModel>? _selectedService;
  // AccountInfoModel? _selectedStylist;
  // AccountInfoModel? _selectedMassur;
  dynamic _selectedDate;
  dynamic _selectedTime;

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
      if (_selectedBranch != event.selectedBranch) {
        // Nếu state hiện tại không phải BookingDataState, tạo state mới với chi nhánh được chọn
        emit(BookingDataState(selectedBranch: event.selectedBranch));
        _selectedBranch = event.selectedBranch;
        emit(ChooseBranchBookingSelectedBranchState(
            selectedBranch: _selectedBranch));
      } else {
        // Cập nhật state với chi nhánh mới
        emit(BookingDataState().copyWith(
          selectedBranch: event.selectedBranch,
        ));
        _selectedBranch = event.selectedBranch;
        emit(ChooseBranchBookingSelectedBranchState(
            selectedBranch: _selectedBranch));
      }
    } catch (e) {}
  }
}

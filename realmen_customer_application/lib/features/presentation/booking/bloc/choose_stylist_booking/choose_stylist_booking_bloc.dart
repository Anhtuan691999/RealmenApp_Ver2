// ignore_for_file: non_constant_identifier_names, empty_catches

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';

part 'choose_stylist_booking_event.dart';
part 'choose_stylist_booking_state.dart';

class ChooseStylistBookingBloc
    extends Bloc<ChooseStylistBookingEvent, ChooseStylistBookingState> {
  //
  AccountModel _selectedStylist = AccountModel();
  List<Map<String, dynamic>>? _listDate = [];
  Map<String, dynamic>? _selectedDate;
  bool _isDefaultSelected = true;
  BranchDataModel? _selectedBranch;
  dynamic _selectedTime;
  String? _dateController;
  List<ServiceDataModel> _selectedServices = [];

  //
  ChooseStylistBookingBloc() : super(ChooseStylistBookingInitial()) {
    on<CSBInitialEvent>(_CSBInitialEvent);

    // choose stylist
    on<CSBShowStylistEvent>(_CSBShowStylistEvent);
    on<CSBSelectedStylistEvent>(_CSBSelectedStylistEvent);
    on<CSBSelectStylistGetBackEvent>(_CSBSelectStylistGetBackEvent);

    // choose date
    on<CSBChooseDateLoadedEvent>(_CSBChooseDateLoadedEvent);
    on<CSBChooseSelectDateEvent>(_CSBChooseSelectDateEvent);

    //choose service
    on<CSBShowServiceEvent>(_CSBShowServiceEvent);

    on<CSBSelectServiceGetBackEvent>(_CSBSelectServiceGetBackEvent);

    on<CSBSelectedServiceEvent>(_CSBSelectedServiceEvent);
  }

  FutureOr<void> _CSBInitialEvent(
      CSBInitialEvent event, Emitter<ChooseStylistBookingState> emit) {}

  // choose stylist
  FutureOr<void> _CSBSelectStylistGetBackEvent(
      CSBSelectStylistGetBackEvent event,
      Emitter<ChooseStylistBookingState> emit) {
    emit(CBSLoadingState());
    emit(CSBSelectStylistGetBackState());
  }

  FutureOr<void> _CSBShowStylistEvent(
      CSBShowStylistEvent event, Emitter<ChooseStylistBookingState> emit) {
    emit(CBSLoadingState());
    try {
      emit(CSBShowStylistState());
    } catch (e) {}
  }

  FutureOr<void> _CSBSelectedStylistEvent(
      CSBSelectedStylistEvent event, Emitter<ChooseStylistBookingState> emit) {
    emit(CBSLoadingState());
    try {
      if (_selectedStylist != event.selectedStylist) {
        _selectedStylist = event.selectedStylist;
        emit(CSBSelectedStylistState(selectedStylist: event.selectedStylist));
      } else {
        _selectedStylist = event.selectedStylist;
        emit(CSBSelectedStylistState(
          selectedStylist: event.selectedStylist,
        ));
      }
    } catch (e) {}
  }

  // choose date
  FutureOr<void> _CSBChooseSelectDateEvent(
      CSBChooseSelectDateEvent event, Emitter<ChooseStylistBookingState> emit) {
    emit(CBSLoadingState());
    _dateController = event.value as String?;
    _selectedDate = _listDate!
        .where((date) => date['id'] == event.value.toString())
        .toList()
        .first;

    emit(CSBSelectDateState(
      dateSeleted: _selectedDate,
      dateController: _dateController,
      listDate: _listDate,
    ));
  }

  Map<String, dynamic> formatDate(DateTime date) {
    String day = DateFormat('EEEE').format(date);
    day = _dayNames[day.toLowerCase()] ?? day;
    return {
      'date': "$day, ${DateFormat('dd/MM/yyyy').format(date)}",
      'type':
          day == "Thứ bảy" || day == "Chủ nhật" ? "Cuối tuần" : "Ngày thường",
      // ignore: unnecessary_string_interpolations
      'chosenDate': "${DateFormat('yyyy-MM-dd').format(date)}"
    };
  }

  final Map<String, String> _dayNames = {
    'monday': 'Thứ hai',
    'tuesday': 'Thứ ba',
    'wednesday': 'Thứ tư',
    'thursday': 'Thứ năm',
    'friday': 'Thứ sáu',
    'saturday': 'Thứ bảy',
    'sunday': 'Chủ nhật'
  };

  FutureOr<void> _CSBChooseDateLoadedEvent(
      CSBChooseDateLoadedEvent event, Emitter<ChooseStylistBookingState> emit) {
    emit(CBSLoadingState());
    try {
      DateTime now = DateTime.now();
      _listDate = [];

      for (int i = 0; i <= 2; i++) {
        _listDate?.add({
          'id': i.toString(),
          'date': formatDate(now.add(Duration(days: i)))['date'],
          'type': formatDate(now.add(Duration(days: i)))['type'],
          'chosenDate':
              "${formatDate(now.add(Duration(days: i)))['chosenDate']}",
        });
      }
      _dateController = _listDate?.first['id'].toString();
      _selectedDate = _listDate!
          .where((date) => date['id'] == _dateController.toString())
          .toList()
          .first;
      emit(CSBLoadDateState(
        dateController: _dateController,
        dateSeleted: _selectedDate,
        listDate: _listDate,
      ));
    } catch (e) {}
  }

  FutureOr<void> _CSBShowServiceEvent(
      CSBShowServiceEvent event, Emitter<ChooseStylistBookingState> emit) {
    emit(CBSLoadingState());

    emit(CSBShowServiceState());
  }

  FutureOr<void> _CSBSelectServiceGetBackEvent(
      CSBSelectServiceGetBackEvent event,
      Emitter<ChooseStylistBookingState> emit) {
    emit(CSBSelectServiceGetBackState());
  }

  FutureOr<void> _CSBSelectedServiceEvent(
      CSBSelectedServiceEvent event, Emitter<ChooseStylistBookingState> emit) {
    emit(CBSLoadingState());

    try {
      _selectedServices = event.selectedServices;
      emit(CSBSelectServiceState(selectedServices: _selectedServices));
    } catch (e) {
      emit(CSBSelectServiceState(selectedServices: const []));
    }
  }
}

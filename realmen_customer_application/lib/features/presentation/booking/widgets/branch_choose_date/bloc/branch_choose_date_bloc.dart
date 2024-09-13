import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'branch_choose_date_event.dart';
part 'branch_choose_date_state.dart';

class BranchChooseDateBloc
    extends Bloc<BranchChooseDateEvent, BranchChooseDateState> {
  List<Map<String, dynamic>>? _listDate = [];
  String? _dateController;
  Map<String, dynamic>? _dateSeleted;
  String _type = "Ngày thường";
  BranchChooseDateBloc() : super(BranchChooseDateInitialState()) {
    on<BranchChooseDateInitialEvent>(_branchChooseDateInitialEvent);
    on<BranchChooseSelectDateEvent>(_branchChooseSelectDateEvent);
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

  FutureOr<void> _branchChooseDateInitialEvent(
      BranchChooseDateInitialEvent event,
      Emitter<BranchChooseDateState> emit) async {
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
      _type = _listDate!.first['type'].toString();
      emit(LoadDateState(
          dateController: _dateController,
          dateSeleted: _dateSeleted,
          listDate: _listDate,
          type: _type));
    } catch (e) {}
  }

  FutureOr<void> _branchChooseSelectDateEvent(BranchChooseSelectDateEvent event,
      Emitter<BranchChooseDateState> emit) async {
    _dateController = event.value as String?;
    _dateSeleted = _listDate!
        .where((date) => date['id'] == event.value.toString())
        .toList()
        .first;
    _type = _dateSeleted!['type'].toString();
    _type == "Thứ bảy" || _type == "Chủ nhật"
        ? _type = "Cuối tuần"
        : _type = "Ngày thường";

    emit(BranchChooseSelectDateState(
        dateSeleted: _dateSeleted,
        dateController: _dateController,
        type: _type));
  }
}

import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/domain/repository/AccountRepo/account_repository.dart';
import 'package:realmen_customer_application/features/domain/repository/ServiceRepo/service_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BranchDataModel? _selectedBranch;
  List<ServiceDataModel> _selectedServices = [];
  dynamic _selectedTime;
  List<Map<String, dynamic>>? _listDate = [];
  String? _dateController;
  Map<String, dynamic>? _selectedDate;
  List<AccountModel> _selectedStylist = [];
  List<AccountModel> _selectedMassur = [];
  List<AccountModel> _accountStylistList = [];
  List<AccountModel> _accountMassurList = [];
  AccountModel _selectedStaff = AccountModel();
  bool _isDefaultSelected = true;

  BookingBloc() : super(BookingInitial()) {
    on<BookingInitialEvent>(_bookingInitialEvent);

    // choose branch
    on<BookingShowBranchEvent>(_bookingShowBranchEvent);
    on<ChooseBranchBookingSelectBranchGetBackEvent>(
        _chooseBranchBookingSelectBranchGetBackEvent);
    on<ChooseBranchBookingSelectedBranchEvent>(
        _chooseBranchBookingSelectedBranchEvent);

    on<BookingShowServiceEvent>(_bookingShowServiceEvent);
    on<ChooseBranchBookingSelectServiceGetBackEvent>(
        _chooseBranchBookingSelectServiceGetBackEvent);
    on<ChooseBranchBookingSelectedServiceEvent>(
        _chooseBranchBookingSelectedServiceEvent);

    // choose date
    on<BranchChooseDateLoadedEvent>(_branchChooseDateLoadedEvent);
    on<BranchChooseSelectDateEvent>(_branchChooseSelectDateEvent);

    // choose staff
    on<BranchChooseStaffLoadedEvent>(_branchChooseStaffLoadedEvent);
    on<BranchChooseSelectStaffEvent>(_branchChooseSelectStaffEvent);
    on<BranchChooseSelectDefaultStaffEvent>(
        _branchChooseSelectDefaultStaffEvent);
  }

  FutureOr<void> _bookingInitialEvent(
      BookingInitialEvent event, Emitter<BookingState> emit) {}

  FutureOr<void> _bookingShowBranchEvent(
      BookingShowBranchEvent event, Emitter<BookingState> emit) {
    emit(LoadingState());
    emit(ShowBookingBranchState());
  }

  FutureOr<void> _chooseBranchBookingSelectBranchGetBackEvent(
      ChooseBranchBookingSelectBranchGetBackEvent event,
      Emitter<BookingState> emit) {
    emit(LoadingState());
    emit(ChooseBranchBookingSelectBranchGetBackState());
  }

  FutureOr<void> _chooseBranchBookingSelectedBranchEvent(
      ChooseBranchBookingSelectedBranchEvent event,
      Emitter<BookingState> emit) async {
    emit(LoadingState());

    try {
      if (_selectedBranch != event.selectedBranch) {
        emit(BookingDataState(selectedBranch: event.selectedBranch));
        _selectedBranch = event.selectedBranch;
        emit(ChooseBranchBookingSelectedBranchState(
            selectedBranch: _selectedBranch, selectedServices: const []));
      } else {
        emit(BookingDataState().copyWith(
            selectedBranch: event.selectedBranch,
            selectedService: _selectedServices));
        _selectedBranch = event.selectedBranch;
        emit(ChooseBranchBookingSelectedBranchState(
            selectedBranch: _selectedBranch,
            selectedServices: _selectedServices));
      }
    } catch (e) {}
  }

  FutureOr<void> _bookingShowServiceEvent(
      BookingShowServiceEvent event, Emitter<BookingState> emit) async {
    emit(LoadingState());

    emit(BookingShowServiceState());
  }

  FutureOr<void> _chooseBranchBookingSelectedServiceEvent(
      ChooseBranchBookingSelectedServiceEvent event,
      Emitter<BookingState> emit) async {
    emit(LoadingState());

    try {
      _selectedServices = event.selectedServices;
      emit(ChooseBranchBookingSelectedServiceState(
          selectedServices: _selectedServices));
    } catch (e) {
      emit(ChooseBranchBookingSelectedServiceState(selectedServices: const []));
    }
  }

  FutureOr<void> _chooseBranchBookingSelectServiceGetBackEvent(
      ChooseBranchBookingSelectServiceGetBackEvent event,
      Emitter<BookingState> emit) {
    emit(ChooseBranchBookingSelectServiceGetBackState());
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
  FutureOr<void> _branchChooseDateLoadedEvent(
      BranchChooseDateLoadedEvent event, Emitter<BookingState> emit) async {
    emit(LoadingState());

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
      emit(BranchChooseDateLoadDateState(
          dateController: _dateController,
          dateSeleted: _selectedDate,
          listDate: _listDate,
          selectedServices: event.selectedServices));
    } catch (e) {}
  }

  FutureOr<void> _branchChooseSelectDateEvent(
      BranchChooseSelectDateEvent event, Emitter<BookingState> emit) async {
    emit(LoadingState());
    _dateController = event.value as String?;
    _selectedDate = _listDate!
        .where((date) => date['id'] == event.value.toString())
        .toList()
        .first;

    emit(BranchChooseSelectDateState(
      dateSeleted: _selectedDate,
      dateController: _dateController,
      selectedServices: _selectedServices,
      listDate: _listDate,
    ));
  }

  List<String> urlStylistList = [
    "3.png",
    "5.jpg",
  ];
  List<String> urlMassurList = [
    "massage.jpg",
  ];
  FutureOr<void> _branchChooseStaffLoadedEvent(
      BranchChooseStaffLoadedEvent event, Emitter<BookingState> emit) async {
    emit(LoadingState());
    final IAccountRepository serviceRepository = AccountRepository();
    final storage = FirebaseStorage.instance;
    List<AccountModel> accountsList = [];
    try {
      _accountStylistList = [];
      _accountMassurList = [];
      var account = await serviceRepository.getAccountList(
          _selectedBranch!.branchId, "OPERATOR_STAFF", null);
      var accountStatus = account["status"];
      var accountBody = account["body"];
      if (accountStatus) {
        accountsList = (accountBody['content'] as List)
            .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
            .toList();

        for (AccountModel account in accountsList) {
          account.firstName = Utf8Encoding().decode(account.firstName!);

          try {
            var reference = storage.ref(account.thumbnail);
            account.thumbnail = await reference.getDownloadURL();
          } catch (e) {
            try {
              account.thumbnail = 'assets/image/${account.thumbnail}';
            } catch (e) {
              final random = Random();
              if (account.professionalTypeCode == 'STYLIST') {
                var randomUrl = random.nextInt(urlStylistList.length);
                account.thumbnail = 'assets/image/${urlStylistList[randomUrl]}';
              } else {
                var randomUrl = random.nextInt(urlMassurList.length);
                account.thumbnail = 'assets/image/${urlMassurList[randomUrl]}';
              }
            }
          }
          if (account.professionalTypeCode == 'STYLIST') {
            _accountStylistList.add(account);
          } else {
            _accountMassurList.add(account);
          }
        }
        emit(BranchChooseStaffLoadedState(
            accountMassurList: _accountMassurList,
            accountStylistList: _accountStylistList));
      }
    } catch (e) {}
  }

  FutureOr<void> _branchChooseSelectStaffEvent(
      BranchChooseSelectStaffEvent event, Emitter<BookingState> emit) async {
    emit(LoadingState());
    try {
      if (event.selectedStaff.accountId == _selectedStaff.accountId) {
        _selectedStaff = AccountModel();
        _isDefaultSelected = true;
      } else {
        _selectedStaff = event.selectedStaff;
        _isDefaultSelected = false;
      }
      emit(BranchChooseSelectedStaffState(
          selectedStaff: _selectedStaff,
          isDefaultSelected: _isDefaultSelected));
    } catch (e) {}
  }

  FutureOr<void> _branchChooseSelectDefaultStaffEvent(
      BranchChooseSelectDefaultStaffEvent event,
      Emitter<BookingState> emit) async {
    emit(LoadingState());
    try {
      _selectedStaff = AccountModel();
      _isDefaultSelected = true;

      emit(BranchChooseSelectedStaffState(
          selectedStaff: _selectedStaff,
          isDefaultSelected: _isDefaultSelected));
    } catch (e) {}
  }
}

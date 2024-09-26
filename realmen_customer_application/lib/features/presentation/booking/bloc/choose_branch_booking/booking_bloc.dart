import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/booking_model.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_account_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_service_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/data/models/working_slot_model.dart';
import 'package:realmen_customer_application/features/domain/repository/BookingRepo/booking_repository.dart';
import 'package:realmen_customer_application/features/domain/repository/DailyPlanRepo/daily_plan_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BranchDataModel? _selectedBranch;
  List<ServiceDataModel> _selectedServices = [];
  List<ServiceDataModel> _selectedServicesStylist = [];
  List<ServiceDataModel> _selectedServicesMassur = [];
  List<DailyPlanServiceModel> _selectedDailyPlanServicesStylist = [];
  List<DailyPlanServiceModel> _selectedDailyPlanServicesMassur = [];

  List<Map<String, dynamic>> _listDate = [];
  List<DailyPlanModel> _dailyPlan = [];
  DailyPlanModel _selectedDailyPlan = DailyPlanModel();
  String? _dateController;
  Map<String, dynamic>? _selectedDate;
  List<DailyPlanAccountModel> _accountStylistList = [];
  List<DailyPlanAccountModel> _accountMassurList = [];
  DailyPlanAccountModel _selectedStaff = DailyPlanAccountModel();
  bool _isDefaultSelected = true;
  int _selectedDailyPlanId = 0;
  String _shiftCode = "";

  // timeSlot
  String _selectedTimeSlot = '';
  List<TimeSlotCardModel> timeSlotCards = [];

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

    // timeslot
    on<GetTimeSlotEvent>(_getTimeSlotEvent);
    on<onTimeSlotSelectedEvent>(_onTimeSlotSelectedEvent);

    // booking submit
    on<BookingSubmitEvent>(_bookingSubmitEvent);
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
            selectedBranch: _selectedBranch));
      } else {
        emit(BookingDataState(
            selectedBranch: event.selectedBranch,
            selectedService: _selectedServices,
            selectedServicesStylist: _selectedServicesStylist,
            selectedServicesMassur: _selectedServicesMassur));
        _selectedBranch = event.selectedBranch;
        emit(ChooseBranchBookingSelectedBranchState(
            selectedBranch: _selectedBranch,
            selectedServices: _selectedServices,
            selectedServicesStylist: _selectedServicesStylist,
            selectedServicesMassur: _selectedServicesMassur));
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
      _selectedServicesStylist = [];
      _selectedServicesMassur = [];

      _selectedServices = event.selectedServices;
      for (ServiceDataModel element in event.selectedServices) {
        if (element.shopCategoryCode == "HAIRCUT") {
          _selectedServicesStylist.add(element);
        } else {
          _selectedServicesMassur.add(element);
        }
      }

      emit(ChooseBranchBookingSelectedServiceState(
          selectedServices: _selectedServices,
          selectedServicesStylist: _selectedServicesStylist,
          selectedServicesMassur: _selectedServicesMassur));
    } catch (e) {
      emit(ChooseBranchBookingSelectedServiceState(
          selectedServices: const [],
          selectedServicesStylist: const [],
          selectedServicesMassur: const []));
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
    final IDailyPlanRepository dailyPlanRepository = DailyPlanRepository();
    var dailyPlansStatus;
    var dailyPlansBody;
    final storage = FirebaseStorage.instance;
    _accountStylistList = [];
    _accountMassurList = [];
    _selectedDailyPlan = DailyPlanModel();
    _shiftCode = '';
    try {
      DateTime now = DateTime.now();
      DateTime from = now.add(const Duration(days: 2));
      List<DailyPlanModel> dailyPlanList = [];
      _listDate = [];
      _dailyPlan = [];
      int branchId = _selectedBranch != null ? _selectedBranch!.branchId! : 0;

      // get dailyPlans time range
      var dailyPlans = await dailyPlanRepository.getDailyPlan(
          now, from, branchId, null, null);
      dailyPlansStatus = dailyPlans["status"];
      dailyPlansBody = dailyPlans["body"];
      if (dailyPlansStatus) {
        dailyPlanList = (dailyPlansBody['values'] as List)
            .map((e) => DailyPlanModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      if (dailyPlansStatus) {
        int maxWeeklyPlanId = dailyPlanList
            .map((e) => e.weeklyPlanId as int)
            .reduce((value, element) => value > element ? value : element);
        dailyPlanList = dailyPlanList
            .where((e) => e.weeklyPlanId == maxWeeklyPlanId)
            .toList();
        for (int i = 0; i < dailyPlanList.length; i++) {
          if (dailyPlanList[i].dailyPlanStatusCode == "PROCESSING") {
            _dailyPlan.add(dailyPlanList[i]);
            DateTime date = DateTime.parse(dailyPlanList[i].date!);
            bool check = _listDate.any((date) =>
                date['chosenDate'] == formatDate(date)['chosenDate']);
            if (_listDate.isEmpty || !check) {
              _listDate.add({
                'id': i.toString(),
                'date': formatDate(date)['date'],
                'type': formatDate(date)['type'],
                'chosenDate': "${formatDate(date)['chosenDate']}",
                'dailyPlanId': dailyPlanList[i].dailyPlanId
              });
            }
          }
        }
        for (DailyPlanModel dailyPlan in _dailyPlan) {
          // get dailyPlanAccounts & dailyPlanServices
          try {
            var dailyPlanById = await dailyPlanRepository
                .getDailyPlanById(dailyPlan.dailyPlanId!);
            var dailyPlansStatus = dailyPlanById["status"];
            var dailyPlansBody = dailyPlanById["body"];
            if (dailyPlansStatus) {
              //dailyPlanAccounts
              dailyPlan.dailyPlanAccounts =
                  DailyPlanModel.fromJson(dailyPlansBody['value'])
                      .dailyPlanAccounts;
              dailyPlan.dailyPlanAccounts = dailyPlan.dailyPlanAccounts!
                  .where((e) => e.accountStatusCode == 'ACTIVE')
                  .toList();

//dailyPlanServices
              dailyPlan.dailyPlanServices =
                  DailyPlanModel.fromJson(dailyPlansBody['value'])
                      .dailyPlanServices;

              // get workingSlots - time slot
              for (DailyPlanAccountModel account
                  in dailyPlan.dailyPlanAccounts!) {
                // set data

                account.fullName = Utf8Encoding().decode(account.fullName!);
                List<String> nameParts = account.fullName!.split(' ');
                if (nameParts.length >= 2) {
                  account.nickName =
                      '${nameParts[nameParts.length - 2]} ${nameParts[nameParts.length - 1]}';
                } else {
                  account.nickName = account.fullName;
                }
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
                      account.thumbnail =
                          'assets/image/${urlStylistList[randomUrl]}';
                    } else {
                      var randomUrl = random.nextInt(urlMassurList.length);
                      account.thumbnail =
                          'assets/image/${urlMassurList[randomUrl]}';
                    }
                  }
                }

                // call timeslot
                try {
                  var workingSlots = await dailyPlanRepository
                      .getShiftPlan(account.dailyPlanAccountId!);
                  var workingSlotsStatus = workingSlots["status"];
                  var workingSlotsBody = workingSlots["body"];
                  if (workingSlotsStatus) {
                    account.workingSlots = DailyPlanAccountModel.fromJson(
                            workingSlotsBody['value'])
                        .workingSlots;
                  }
                } catch (e) {}
              }
            }
          } catch (e) {}
        }
      }

      _dateController = _listDate.first['id'].toString();
      _selectedDate = _listDate
          .where((date) => date['id'] == _dateController.toString())
          .toList()
          .first;
      _selectedDailyPlanId = _selectedDate?['dailyPlanId'];
      for (DailyPlanModel dailyPlan in _dailyPlan) {
        if (dailyPlan.dailyPlanId == _selectedDailyPlanId) {
          _selectedDailyPlan = dailyPlan;
          for (var account in dailyPlan.dailyPlanAccounts!) {
            if (account.professionalTypeCode == 'STYLIST') {
              _accountStylistList.add(account);
            } else {
              _accountMassurList.add(account);
            }
          }
        }
      }
      for (DailyPlanAccountModel account
          in _selectedDailyPlan.dailyPlanAccounts!) {
        if (account.shiftCode == "MORNING_SHIFT" && _shiftCode == "") {
          _shiftCode = "MORNING_SHIFT";
        } else if (account.shiftCode == "NIGHT_SHIFT" && _shiftCode == "") {
          _shiftCode = "NIGHT_SHIFT";
        } else {
          _shiftCode = "ALL";
          break;
        }
      }
      _selectedDailyPlanServicesStylist = [];
      _selectedDailyPlanServicesMassur = [];
      for (ServiceDataModel element in _selectedServices) {
        if (element.shopCategoryCode == "HAIRCUT") {
          _selectedDailyPlanServicesStylist.addAll(_selectedDailyPlan
              .dailyPlanServices!
              .where((e) => e.shopServiceId == element.shopServiceId)
              .toList());
        } else {
          _selectedDailyPlanServicesMassur.addAll(_selectedDailyPlan
              .dailyPlanServices!
              .where((e) => e.shopServiceId == element.shopServiceId)
              .toList());
        }
      }

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
    _selectedStaff = DailyPlanAccountModel();
    _isDefaultSelected = true;
    _dateController = event.value as String?;
    _selectedDate = _listDate
        .where((date) => date['id'] == event.value.toString())
        .toList()
        .first;
    _selectedDailyPlanId = _selectedDate?['dailyPlanId'];
    for (DailyPlanModel dailyPlan in _dailyPlan) {
      if (dailyPlan.dailyPlanId == _selectedDailyPlanId) {
        _accountStylistList = [];
        for (var account in dailyPlan.dailyPlanAccounts!) {
          if (account.professionalTypeCode == 'STYLIST') {
            _accountStylistList.add(account);
          } else {
            _accountMassurList.add(account);
          }
        }
      }
    }
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
    "stylist.png",
  ];
  List<String> urlMassurList = [
    "massage.jpg",
  ];

  FutureOr<void> _branchChooseStaffLoadedEvent(
      BranchChooseStaffLoadedEvent event, Emitter<BookingState> emit) async {
    emit(BranchChooseStaffLoadedState(
        accountMassurList: _accountMassurList,
        accountStylistList: _accountStylistList,
        selectedServicesStylist: _selectedServicesStylist,
        selectedServicesMassur: _selectedServicesMassur));
  }

  FutureOr<void> _branchChooseSelectStaffEvent(
      BranchChooseSelectStaffEvent event, Emitter<BookingState> emit) async {
    emit(LoadingState());
    try {
      if (event.selectedStaff.accountId == _selectedStaff.accountId) {
        _selectedStaff = DailyPlanAccountModel();
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
      _selectedStaff = DailyPlanAccountModel();
      _isDefaultSelected = true;

      emit(BranchChooseSelectedStaffState(
          selectedStaff: _selectedStaff,
          isDefaultSelected: _isDefaultSelected));
    } catch (e) {}
  }

  // time slot
  FutureOr<void> _getTimeSlotEvent(
      GetTimeSlotEvent event, Emitter<BookingState> emit) async {
    // emit(LoadingState());
    try {
      timeSlotCards = [];

      List<String> timeSlots = generateTimeSlots();

      // kiểm tra ngày hôm nay
      final now = DateTime.now();
      final formatter = DateFormat('HH:mm');
      final currentTime = formatter.format(now);

      for (var timeSlot in timeSlots) {
        final isSelected = timeSlot == _selectedTimeSlot;

        // kiểm tra được chọn hay không
        // TRUE = avalible
        bool isSelectable = false;
        // kiểm tra timeslot vs thời gian rãnh của stylist
        if (_selectedStaff.accountId != null) {
          bool checkTimeSlotStylist = (_selectedStaff.workingSlots!.any((e) {
            try {
              if ("$timeSlot:00" == e.from && e.bookingCount! < 4) {
                return true;
              }
              return false;
            } on Exception {
              return false;
            }
          }));
          isSelectable = checkTimeSlotStylist;
        } else {
          isSelectable = true;
        }

        // kiểm tra ngày hôm nay
        bool isCurrentDate = _isCurrentDate();
        if (isCurrentDate) {
          if (timeSlot.compareTo(currentTime) >= 0) {
            isSelectable; // kh thay đổi
          } else {
            // buộc false
            isSelectable = false;
          }
        }
        // kiểm tra ca lam
        String to = '';
        String from = '';
        if (_selectedStaff.accountId != null) {
          if (_selectedStaff.shiftCode == "MORNING_SHIFT") {
            to = '07:00';
            from = '15:00';
          } else if (_selectedStaff.shiftCode == "NIGHT_SHIFT") {
            to = '15:00';
            from = '23:00';
          }

          if (timeSlot.compareTo(to) >= 0 && timeSlot.compareTo(from) < 0) {
            // không thay đổi
            isSelectable;
          } else {
            // buộc false
            isSelectable = false;
          }
        } else {
          if (_shiftCode == "MORNING_SHIFT") {
            to = '07:00';
            from = '15:00';
          } else if (_shiftCode == "NIGHT_SHIFT") {
            to = '15:00';
            from = '23:00';
          }
          if (_shiftCode != "ALL") {
            if (timeSlot.compareTo(to) >= 0 && timeSlot.compareTo(from) < 0) {
              // không thay đổi
              isSelectable;
            } else {
              // buộc false
              isSelectable = false;
            }
          }
        }

        TimeSlotCardModel timeSlotCard = TimeSlotCardModel(
          timeSlot: timeSlot,
          // isSelected: isSelected,
          isSelectable: isSelectable,
          type: _selectedDate!['type'],
        );
        timeSlotCards.add(timeSlotCard);
      }
      _selectedTimeSlot = '';
      emit(BranchChooseTimeSlotLoadedState(timeSlotCards: timeSlotCards));
    } catch (e) {}
  }

  List<String> generateTimeSlots() {
    List<String> timeSlots = [];
    for (int hour = 7; hour < 23; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        final formattedHour = hour.toString().padLeft(2, '0');
        final formattedMinute = minute.toString().padLeft(2, '0');
        timeSlots.add('$formattedHour:$formattedMinute');
      }
    }
    return timeSlots;
  }

  bool _isCurrentDate() {
    DateTime now = DateTime.now();
    String? dateNow = formatDate(now.add(const Duration(days: 0)))['date'];
    try {
      if (_selectedDate!['date'].toString() == dateNow) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  FutureOr<void> _onTimeSlotSelectedEvent(
      onTimeSlotSelectedEvent event, Emitter<BookingState> emit) async {
    emit(LoadingState());
    try {
      if (event.timeSlot == _selectedTimeSlot) {
        // Deselect the time slot if it's already selected
        _selectedTimeSlot = '';
      } else {
        _selectedTimeSlot = event.timeSlot;
      }

      emit(BranchChooseSelectedTimeSlotState(
          selectedTimeSlot: _selectedTimeSlot, timeSlotCards: timeSlotCards));
    } catch (e) {}
  }

  FutureOr<void> _bookingSubmitEvent(
      BookingSubmitEvent event, Emitter<BookingState> emit) async {
    emit(LoadingState());
    final IBookingRepository bookingRepository = BookingRepository();

    try {
      List<BookingServiceModel> bookingServices = [];
      if (_selectedDate == null) {
        emit(ShowSnackBarActionState(message: "Xin chọn ngày", status: false));
      } else      String beginAt = "${_selectedDate!['chosenDate']}T${_selectedTimeSlot}";
      if (_selectedDailyPlanServicesStylist.isNotEmpty) {
        int staffId =
            _selectedStaff.accountId == null ? 0 : _selectedStaff.accountId!;
        for (DailyPlanServiceModel selectedServiceStylist
            in _selectedDailyPlanServicesStylist) {
          BookingServiceModel bookingServiceModel = BookingServiceModel(
              serviceId: selectedServiceStylist.dailyPlanServiceId!,
              staffId: staffId,
              beginAtReq: beginAt);
          bookingServices.add(bookingServiceModel);
        }
      }
      if (_selectedServicesMassur.isNotEmpty) {
        for (DailyPlanServiceModel selectedServiceMassur
            in _selectedDailyPlanServicesMassur) {
          BookingServiceModel bookingServiceModel = BookingServiceModel(
              serviceId: selectedServiceMassur.dailyPlanServiceId!,
              staffId: 0,
              beginAtReq: beginAt);
          bookingServices.add(bookingServiceModel);
        }
      }
      BookingModel bookingSubmit = BookingModel(
          branchId: _selectedBranch!.branchId!,
          bookingServices: bookingServices);
      var bookings = await bookingRepository.submitBooking(bookingSubmit);
      var bookingsStatus = bookings["status"];
      var bookingsBody = bookings["body"];
      if (bookingsStatus) {
        emit(ShowBookingTemporaryState());
      }
    
      emit(ShowBookingTemporaryState());
    } catch (e) {}
  }
}

// ignore_for_file: non_constant_identifier_names, empty_catches

import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/data/models/booking_model.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_account_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/data/models/working_slot_model.dart';
import 'package:realmen_customer_application/features/domain/repository/BookingRepo/booking_repository.dart';
import 'package:realmen_customer_application/features/domain/repository/DailyPlanRepo/daily_plan_repository.dart';

part 'choose_stylist_booking_event.dart';
part 'choose_stylist_booking_state.dart';

class ChooseStylistBookingBloc
    extends Bloc<ChooseStylistBookingEvent, ChooseStylistBookingState> {
  //
  BranchDataModel? _selectedBranch;
  List<ServiceDataModel> _selectedServices = [];
  List<ServiceDataModel> _selectedServicesStylist = [];
  List<ServiceDataModel> _selectedServicesMassur = [];
  List<Map<String, dynamic>> _listDate = [];
  AccountModel _selectedStylist = AccountModel();

  Map<String, dynamic>? _selectedDate;
  bool _isDefaultSelected = true;
  dynamic _selectedTime;
  String? _dateController;

  // time slot
  List<DailyPlanModel> _dailyPlan = [];
  DailyPlanModel _selectedDailyPlan = DailyPlanModel();
  DailyPlanAccountModel _selectedStaff = DailyPlanAccountModel();
  int _selectedDailyPlanId = 0;
  String _shiftCode = "";
  String _selectedTimeSlot = '';
  List<TimeSlotCardModel> timeSlotCards = [];

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

    //choose ttime slot
    on<CSBGetTimeSlotEvent>(_getTimeSlotEvent);
    on<CSBonTimeSlotSelectedEvent>(_onTimeSlotSelectedEvent);

    // booking submit
    on<CSBBookingSubmitEvent>(_bookingSubmitEvent);
  }

  FutureOr<void> _CSBInitialEvent(
      CSBInitialEvent event, Emitter<ChooseStylistBookingState> emit) {}

  // choose stylist
  FutureOr<void> _CSBSelectStylistGetBackEvent(
      CSBSelectStylistGetBackEvent event,
      Emitter<ChooseStylistBookingState> emit) {
    emit(CSBLoadingState());
    emit(CSBSelectStylistGetBackState());
  }

  FutureOr<void> _CSBShowStylistEvent(
      CSBShowStylistEvent event, Emitter<ChooseStylistBookingState> emit) {
    emit(CSBLoadingState());
    try {
      emit(CSBShowStylistState());
    } catch (e) {}
  }

  FutureOr<void> _CSBSelectedStylistEvent(
      CSBSelectedStylistEvent event, Emitter<ChooseStylistBookingState> emit) {
    emit(CSBLoadingState());
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
    emit(CSBLoadingState());
    _dateController = event.value as String?;
    _selectedDate = _listDate!
        .where((date) => date['id'] == event.value.toString())
        .toList()
        .first;
    _selectedDailyPlanId = _selectedDate?['dailyPlanId'];

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

  FutureOr<void> _CSBChooseDateLoadedEvent(CSBChooseDateLoadedEvent event,
      Emitter<ChooseStylistBookingState> emit) async {
    emit(CSBLoadingState());
    final IDailyPlanRepository dailyPlanRepository = DailyPlanRepository();
    var dailyPlansStatus;
    var dailyPlansBody;
    final storage = FirebaseStorage.instance;

    _selectedDailyPlan = DailyPlanModel();
    _shiftCode = '';
    try {
      DateTime now = DateTime.now();
      DateTime from = now.add(const Duration(days: 2));
      List<DailyPlanModel> dailyPlanList = [];
      _listDate = [];
      _dailyPlan = [];
      int branchId = _selectedBranch != null ? _selectedBranch!.branchId! : 1;

      // get dailyPlans time range
      var dailyPlans = await dailyPlanRepository.getDailyPlan(
          now, from, branchId, _selectedStylist.accountId, null);
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
            bool check = _listDate.any((_date) =>
                _date['chosenDate'] == formatDate(date)['chosenDate']);
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
        }
      }
      for (DailyPlanAccountModel account
          in _selectedDailyPlan.dailyPlanAccounts!) {
        if (account.accountId == _selectedStylist.accountId) {
          _selectedStaff = account;
          _shiftCode = account.professionalTypeCode!;
        }
      }
      emit(CSBLoadDateState(
          dateController: _dateController,
          dateSeleted: _selectedDate,
          listDate: _listDate,
          selectedStaff: _selectedStaff));
    } catch (e) {}
  }

  FutureOr<void> _CSBShowServiceEvent(
      CSBShowServiceEvent event, Emitter<ChooseStylistBookingState> emit) {
    emit(CSBLoadingState());

    emit(CSBShowServiceState());
  }

  FutureOr<void> _CSBSelectServiceGetBackEvent(
      CSBSelectServiceGetBackEvent event,
      Emitter<ChooseStylistBookingState> emit) {
    emit(CSBSelectServiceGetBackState());
  }

  FutureOr<void> _CSBSelectedServiceEvent(
      CSBSelectedServiceEvent event, Emitter<ChooseStylistBookingState> emit) {
    emit(CSBLoadingState());

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
      emit(CSBSelectServiceState(selectedServices: _selectedServices));
    } catch (e) {
      emit(CSBSelectServiceState(selectedServices: const []));
    }
  }

  // timeslot
  FutureOr<void> _getTimeSlotEvent(CSBGetTimeSlotEvent event,
      Emitter<ChooseStylistBookingState> emit) async {
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
            } on Exception catch (e) {
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
      emit(CSBChooseTimeSlotLoadedState(timeSlotCards: timeSlotCards));
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

  FutureOr<void> _onTimeSlotSelectedEvent(CSBonTimeSlotSelectedEvent event,
      Emitter<ChooseStylistBookingState> emit) async {
    emit(CSBLoadingState());
    try {
      if (event.timeSlot == _selectedTimeSlot) {
        // Deselect the time slot if it's already selected
        _selectedTimeSlot = '';
      } else {
        _selectedTimeSlot = event.timeSlot;
      }

      emit(CSBChooseSelectedTimeSlotState(
          selectedTimeSlot: _selectedTimeSlot, timeSlotCards: timeSlotCards));
    } catch (e) {}
  }

  FutureOr<void> _bookingSubmitEvent(CSBBookingSubmitEvent event,
      Emitter<ChooseStylistBookingState> emit) async {
    emit(CSBLoadingState());
    final IBookingRepository bookingRepository = BookingRepository();

    try {
      List<BookingServiceModel> bookingServices = [];
      if (_selectedDate == null) {
        emit(CSBShowSnackBarActionState(
            message: "Xin chọn ngày", status: false));
      } else if (_selectedTimeSlot == null) {
        emit(
            CSBShowSnackBarActionState(message: "Xin chọn giờ", status: false));
      } else {
        String beginAt = "${_selectedDate!['chosenDate']}T${_selectedTimeSlot}";
        if (_selectedServicesStylist.isNotEmpty) {
          int staffId =
              _selectedStaff.accountId == null ? 0 : _selectedStaff.accountId!;
          for (ServiceDataModel selectedServiceStylist
              in _selectedServicesStylist) {
            BookingServiceModel bookingServiceModel = BookingServiceModel(
                serviceId: selectedServiceStylist.shopServiceId!,
                staffId: staffId,
                beginAtReq: beginAt);
            bookingServices.add(bookingServiceModel);
          }
        }
        if (_selectedServicesMassur.isNotEmpty) {
          for (ServiceDataModel selectedServicesMassur
              in _selectedServicesMassur) {
            BookingServiceModel bookingServiceModel = BookingServiceModel(
                serviceId: selectedServicesMassur.shopServiceId!,
                staffId: 0,
                beginAtReq: beginAt);
            bookingServices.add(bookingServiceModel);
          }
        }
        BookingModel bookingSubmit = BookingModel(
            branchId: 1,
            // branchId: _selectedBranch!.branchId!,
            bookingServices: bookingServices);
        var bookings = await bookingRepository.submitBooking(bookingSubmit);
        var bookingsStatus = bookings["status"];
        var bookingsBody = bookings["body"];
        if (bookingsStatus) {
          emit(CSBShowBookingTemporaryState());
        }
      }
      emit(CSBShowBookingTemporaryState());
    } catch (e) {}
  }
}

import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/domain/repository/AccountRepo/account_repository.dart';

part 'choose_stylist_page_event.dart';
part 'choose_stylist_page_state.dart';

class ChooseStylistPageBloc
    extends Bloc<ChooseStylistPageEvent, ChooseStylistPageState> {
  List<AccountModel> _stylistList = [];

  ChooseStylistPageBloc() : super(ChooseStylistPageInitial()) {
    on<CSPInitialEvent>(_CSPInitialEvent);
    on<CSPLoadedEvent>(_CSPLoadedEvent);
  }

  FutureOr<void> _CSPInitialEvent(
      CSPInitialEvent event, Emitter<ChooseStylistPageState> emit) {
    add(CSPLoadedEvent());
  }

  List<String> urlStylistList = [
    "1.jpg",
    "2.jpg",
    "3.jpg",
    "4.jpg",
  ];
  List<String> urlBranchList = [
    "barber1.jpg",
    "barber2.jpg",
    "barber3.jpg",
  ];
  FutureOr<void> _CSPLoadedEvent(
      CSPLoadedEvent event, Emitter<ChooseStylistPageState> emit) async {
    emit(CSPLoadingState());
    final AccountRepository stylistRepository = AccountRepository();
    final storage = FirebaseStorage.instance;

    List<AccountModel> stylistList = [];

    try {
      var stylists =
          await stylistRepository.getAccountList(null, "OPERATOR_STAFF", null);
      var stylistsStatus = stylists["status"];
      var stylistsBody = stylists["body"];
      if (stylistsStatus) {
        _stylistList = [];
        stylistList = (stylistsBody['content'] as List)
            .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
            .toList();
        for (var stylist in stylistList) {
          if (stylist.professionalTypeCode == "STYLIST") {
            stylist.firstName = Utf8Encoding().decode(stylist.firstName!);
            stylist.lastName = Utf8Encoding().decode(stylist.lastName!);
            try {
              var reference = storage.ref(stylist.thumbnail);
              stylist.thumbnail = await reference.getDownloadURL();
            } catch (e) {
              try {
                stylist.thumbnail = 'assets/image/${stylist.thumbnail}';
              } catch (e) {
                final random = Random();
                var randomUrl = random.nextInt(urlStylistList.length);
                stylist.thumbnail = 'assets/image/${urlStylistList[randomUrl]}';
              }
            }
            _stylistList.add(stylist);
          }
        }
        emit(CSPLoadedState(stylistList: _stylistList));
      }
    } catch (e) {}
  }
}

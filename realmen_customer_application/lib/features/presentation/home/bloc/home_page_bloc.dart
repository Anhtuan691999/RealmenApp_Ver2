import 'dart:async';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:realmen_customer_application/core/utils/check_asset_image.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/domain/repository/AccountRepo/account_repository.dart';
import 'package:realmen_customer_application/features/domain/repository/BranchRepo/branch_repository.dart';
import 'package:realmen_customer_application/features/domain/repository/ServiceRepo/service_repository.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageInitialEvent>(_homePageInitialEvent);
    on<ShowBranchOverviewPageEvent>(_showBranchOverviewPageEvent);
    on<LoadedBranchProvinceListEvent>(_loadedBranchProvinceListEvent);
  }
  FutureOr<void> _homePageInitialEvent(
      HomePageInitialEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageLoadingState());
    final storage = FirebaseStorage.instance;
    final IBranchRepository branchRepository = BranchRepository();
    final IServiceRepository serviceRepository = ServiceRepository();
    final IAccountRepository stylistRepository = AccountRepository();

    NumberFormat numberFormat = NumberFormat('#,##0');

    // Branch Data
    var branchs = await branchRepository.getBranch(null, null);
    var branchStatus = branchs["status"];
    var branchBody = branchs["body"];
    List<BranchDataModel> branchList = [];
    Map<String, dynamic> services;

    // Service Data
    try {
      services = await serviceRepository.getAllServices(1);
    } catch (e) {
      services = await serviceRepository.getAllServices(null);
    }
    var serviceStatus = services["status"];
    var serviceBody = services["body"];
    List<ServiceDataModel> serviceList = [];

    // Stylist Data

    var stylists =
        await stylistRepository.getAccountList(null, "OPERATOR_STAFF", null);
    var stylistsStatus = stylists["status"];
    var stylistsBody = stylists["body"];
    List<AccountModel> stylistList = [];

    // Branch data
    if (branchStatus) {
      branchList = (branchBody['content'] as List)
          .map((e) => BranchDataModel.fromJson(e as Map<String, dynamic>))
          .toList();

      List<String> urlList = [
        "barber1.jpg",
        "barber2.jpg",
        "barber3.jpg",
        "branch.png",
      ];
      for (var branch in branchList) {
        try {
          var reference = storage.ref(branch.branchThumbnail);
          branch.branchThumbnail = await reference.getDownloadURL();
        } catch (e) {
          if (await CheckIfAssetImageExists.checkIfAssetImageExists(
              'assets/images/${branch.branchThumbnail}')) {
            branch.branchThumbnail = 'assets/images/${branch.branchThumbnail}';
          } else {
            final random = Random();
            var randomUrl = random.nextInt(urlList.length);
            branch.branchThumbnail = 'assets/images/${urlList[randomUrl]}';
          }
        }

        if (branch.distanceInKm!.distance! >= 1) {
          branch.distanceKm = "${(branch.distanceInKm!.distance!).toInt()}km";
        } else {
          branch.distanceKm =
              "${(branch.distanceInKm!.distance! * 1000).toInt()}m";
        }
        branch.open = branch.open!.substring(0, 2);
        branch.close = branch.close!.substring(0, 2);
      }
    }
    // Service data
    if (serviceStatus) {
      serviceList = (serviceBody['content'] as List)
          .map((e) => ServiceDataModel.fromJson(e as Map<String, dynamic>))
          .toList();

      List<String> urlList = [
        "6.jpg",
        "massage3.jpg",
        "massage1.jpg",
        "stylist.png"
      ];
      for (var service in serviceList) {
        try {
          var reference = storage.ref(service.shopServiceThumbnail);
          service.shopServiceThumbnail = await reference.getDownloadURL();
        } catch (e) {
          if (await CheckIfAssetImageExists.checkIfAssetImageExists(
              'assets/images/${service.shopServiceThumbnail}')) {
            service.shopServiceThumbnail =
                'assets/images/${service.shopServiceThumbnail}';
          } else {
            final random = Random();
            var randomUrl = random.nextInt(urlList.length);
            service.shopServiceThumbnail =
                'assets/images/${urlList[randomUrl]}';
          }
        }
        service.shopServicePriceS = service.branchServicePrice! >= 0
            ? "${numberFormat.format(service.branchServicePrice)} VNĐ"
            : "0 VNĐ";
      }
    }

    // Stylist data
    if (stylistsStatus) {
      stylistList = (stylistsBody['content'] as List)
          .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
          .toList();
      stylistList = stylistList
          .where((e) => e.professionalTypeCode == "STYLIST")
          .toList();
      List<String> urlList = [
        "1.jpg",
        "2.jpg",
        "3.jpg",
        "4.jpg",
        "stylist.png",
      ];
      for (var stylist in stylistList) {
        if (stylist.professionalTypeCode == "STYLIST") {
          stylist.firstName = Utf8Encoding().decode(stylist.firstName!);
          stylist.lastName = Utf8Encoding().decode(stylist.lastName!);
          String fullName = "${stylist.firstName!} ${stylist.lastName!}";
          List<String> nameParts = fullName.split(' ');
          if (nameParts.length >= 2) {
            stylist.nickName =
                '${nameParts[nameParts.length - 2]} ${nameParts[nameParts.length - 1]}';
          } else {
            stylist.nickName = fullName;
          }
          try {
            var reference = storage.ref(stylist.thumbnail);
            stylist.thumbnail = await reference.getDownloadURL();
          } catch (e) {
            if (await CheckIfAssetImageExists.checkIfAssetImageExists(
                'assets/images/${stylist.thumbnail}')) {
              stylist.thumbnail = 'assets/images/${stylist.thumbnail}';
            } else {
              final random = Random();
              var randomUrl = random.nextInt(urlList.length);
              stylist.thumbnail = 'assets/images/${urlList[randomUrl]}';
            }
          }
        }
      }
    }

    if (branchStatus || serviceStatus) {
      await Future.delayed(const Duration(seconds: 2));
      emit(HomePageLoadedSuccessState(
          loadedBranchsList: branchList,
          loadedServicesList: serviceList,
          loadedStylistsList: stylistList));
    }
  }

  FutureOr<void> _showBranchOverviewPageEvent(
      ShowBranchOverviewPageEvent event, Emitter<HomePageState> emit) async {
    emit(ShowBranchOverviewPageState());
  }

  FutureOr<void> _loadedBranchProvinceListEvent(
      LoadedBranchProvinceListEvent event, Emitter<HomePageState> emit) async {
    emit(LoadingBranchProvinceListState());
    final IBranchRepository branchRepository = BranchRepository();
    // branch province data
    var branchProvinces = await branchRepository.getBranchByProvince();
    var branchProvinceStatus = branchProvinces["status"];
    var branchProvinceBody = branchProvinces["body"];
    List<BranchProvince> branchProvinceList = [];
    if (branchProvinceStatus) {
      branchProvinceList = (branchProvinceBody['content'] as List)
          .map((e) => BranchProvince.fromJson(e as Map<String, dynamic>))
          .toList();
      for (var branchProvince in branchProvinceList) {
        branchProvince.province =
            Utf8Encoding().decode(branchProvince.province!);
      }
      emit(LoadedBranchProvinceListState(
          branchProvinceList: branchProvinceList));
    }
  }
}

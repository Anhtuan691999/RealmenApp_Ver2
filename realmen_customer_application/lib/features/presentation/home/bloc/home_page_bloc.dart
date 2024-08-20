import 'dart:async';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
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
    NumberFormat numberFormat = NumberFormat('#,##0');
    // Branch Data
    var branchs = await branchRepository.getBranchForHome();
    var branchStatus = branchs["status"];
    var branchBody = branchs["body"];
    List<BranchDataModel> branchList = [];

    // Service Data
    var services = await serviceRepository.getAllServices();
    var serviceStatus = services["status"];
    var serviceBody = services["body"];
    List<ServiceDataModel> serviceList = [];

    // Branch data
    if (branchStatus) {
      branchList = (branchBody['content'] as List)
          .map((e) => BranchDataModel.fromJson(e as Map<String, dynamic>))
          .toList();

      List<String> urlList = [
        "barber1.jpg",
        "barber2.jpg",
        "barber3.jpg",
      ];
      for (var branch in branchList) {
        try {
          var reference = storage.ref(branch.branchThumbnail);
          branch.branchThumbnail = await reference.getDownloadURL();
        } catch (e) {
          final random = Random();
          var randomUrl = random.nextInt(urlList.length);
          var reference = storage.ref('branch/${urlList[randomUrl]}');
          branch.branchThumbnail = await reference.getDownloadURL();
        }
        if (branch.distanceInKm!.distance! >= 1) {
          branch.distanceKm = "${branch.distanceInKm!.distance!}km";
        } else {
          branch.distanceKm =
              "${(branch.distanceInKm!.distance! * 1000).toInt()}m";
        }
        branch.open = branch.open!.substring(0, 2);
        branch.close = branch.close!.substring(0, 2);
      }

      // Service data
      if (serviceStatus) {
        serviceList = (serviceBody['content'] as List)
            .map((e) => ServiceDataModel.fromJson(e as Map<String, dynamic>))
            .toList();

        List<String> urlList = ["6.jpg", "massage3.jpg", "massage1.jpg"];
        for (var service in serviceList) {
          try {
            var reference = storage.ref(service.shopServiceThumbnail);
            service.shopServiceThumbnail = await reference.getDownloadURL();
          } catch (e) {
            final random = Random();
            var randomUrl = random.nextInt(urlList.length);
            var reference = storage.ref('service/${urlList[randomUrl]}');
            service.shopServiceThumbnail = await reference.getDownloadURL();
          }
          service.shopServicePriceS = service.shopServicePrice! >= 0
              ? "${numberFormat.format(service.shopServicePrice)} VNĐ"
              : "0 VNĐ";
        }
      }
    }

    if (branchStatus || serviceStatus) {
      await Future.delayed(const Duration(seconds: 2));
      emit(HomePageLoadedSuccessState(
          loadedBranchsList: branchList, loadedServicesList: serviceList));
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

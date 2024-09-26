// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/domain/repository/ServiceRepo/service_repository.dart';

part 'choose_service_page_event.dart';
part 'choose_service_page_state.dart';

class ChooseServicePageBloc
    extends Bloc<ChooseServicePageEvent, ChooseServicePageState> {
  List<ServiceDataModel> _servicesList = [];
  final List<ServiceCategoryModel> _serviceCatagoryList = [];
  List<ServiceDataModel> _selectedServices = [];

  ChooseServicePageBloc() : super(ChooseServicePageInitial()) {
    on<ChooseServicePageInitialEvent>(_chooseServicePageInitialEvent);
    on<ChooseServicePageLoadedSuccessEvent>(
        _chooseServicePageLoadedSuccessEvent);
    on<ChooseServiceSelectedEvent>(_chooseServiceSelectedEvent);
  }

  FutureOr<void> _chooseServicePageInitialEvent(
      ChooseServicePageInitialEvent event,
      Emitter<ChooseServicePageState> emit) async {
    emit(ChooseServicePageLoadingPageState());
    final IServiceRepository serviceRepository = ServiceRepository();
    final storage = FirebaseStorage.instance;
    NumberFormat numberFormat = NumberFormat('#,##0');
    List<String> urlHairCutList = [
      "3.png",
      "5.jpg",
    ];
    List<String> urlMassageList = [
      "massage.jpg",
    ];
    try {
      var services = await serviceRepository.getAllServices(event.branchId);
      var servicesStatus = services["status"];
      var servicesBody = services["body"];
      List<ServiceDataModel> servicesList = [];
      List<ServiceCategoryModel> serviceCatagoryList = [];
      if (servicesStatus) {
        servicesList = (servicesBody['content'] as List)
            .map((e) => ServiceDataModel.fromJson(e as Map<String, dynamic>))
            .toList();
        if (servicesList.isNotEmpty) {
          for (var service in servicesList) {
            service.shopServiceName =
                Utf8Encoding().decode(service.shopServiceName!);

            try {
              var reference = storage.ref(service.shopServiceThumbnail);
              service.shopServiceThumbnail = await reference.getDownloadURL();
            } catch (e) {
              try {
                service.shopServiceThumbnail =
                    'assets/image/${service.shopServiceThumbnail}';
              } catch (e) {
                final random = Random();
                if (service.shopCategoryCode == 'HAIRCUT') {
                  var randomUrl = random.nextInt(urlHairCutList.length);
                  service.shopServiceThumbnail =
                      'assets/image/${urlHairCutList[randomUrl]}';
                } else {
                  var randomUrl = random.nextInt(urlMassageList.length);
                  service.shopServiceThumbnail =
                      'assets/image/${urlMassageList[randomUrl]}';
                }
              }
            }
            service.shopServicePriceS = service.branchServicePrice! >= 0
                ? "${numberFormat.format(service.branchServicePrice)} VNĐ"
                : "0 VNĐ";
          }

          serviceCatagoryList.add(ServiceCategoryModel(
              title: 'Massage',
              services: servicesList
                  .where((service) => service.shopCategoryCode == "MASSAGE")
                  .toList()));
          serviceCatagoryList.add(ServiceCategoryModel(
              title: 'Cắt tóc',
              services: servicesList
                  .where((service) => service.shopCategoryCode == "HAIRCUT")
                  .toList()));

          _servicesList = servicesList;
          _serviceCatagoryList.addAll(serviceCatagoryList);
          _selectedServices = event.selectedServices;
          emit(ChooseServicePageLoadedSuccessState(
              serviceCatagoryList: serviceCatagoryList,
              selectedServices: _selectedServices));
        } else {
          emit(ChooseServicePageNoDataState());
        }
      } else {
        emit(ChooseServicePageNoDataState());
      }
    } catch (e) {
      emit(ChooseServicePageNoDataState());
    }
  }

  FutureOr<void> _chooseServiceSelectedEvent(ChooseServiceSelectedEvent event,
      Emitter<ChooseServicePageState> emit) async {
    try {
      emit(LoadingState());

      if (_selectedServices.isEmpty) {
        try {
          _selectedServices = [];
          _selectedServices.add(event.selectedService);
        } catch (e) {
          // TODO
        }
      } else {
        if (_selectedServices.any((service) =>
            service.branchServiceId == event.selectedService.branchServiceId)) {
          _selectedServices.removeWhere((service) =>
              service.branchServiceId == event.selectedService.branchServiceId);
        } else {
          _selectedServices.add(event.selectedService);
        }
      }
      emit(ChooseServiceSelectedState());
    } catch (e) {}
  }

  FutureOr<void> _chooseServicePageLoadedSuccessEvent(
      ChooseServicePageLoadedSuccessEvent event,
      Emitter<ChooseServicePageState> emit) async {
    try {
      emit(LoadingState());

      emit(ChooseServicePageLoadedSuccessState(
          serviceCatagoryList: _serviceCatagoryList,
          selectedServices: _selectedServices));
    } catch (e) {}
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/domain/repository/ServiceRepo/service_repository.dart';

part 'choose_service_page_event.dart';
part 'choose_service_page_state.dart';

class ChooseServicePageBloc
    extends Bloc<ChooseServicePageEvent, ChooseServicePageState> {
  List<ServiceDataModel> _servicesList = [];
  List<ServiceDataModel> _selectedServices = [];
  final List<ServiceCategoryModel> _serviceCatagoryList = [];

  ChooseServicePageBloc() : super(ChooseServicePageInitial()) {
    on<ChooseServicePageInitialEvent>(_chooseServicePageInitialEvent);
    on<ChooseServiceSelectedEvent>(_chooseServiceSelectedEvent);
  }

  FutureOr<void> _chooseServicePageInitialEvent(
      ChooseServicePageInitialEvent event,
      Emitter<ChooseServicePageState> emit) async {
    emit(ChooseServicePageLoadingPageState());
    final IServiceRepository serviceRepository = ServiceRepository();
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
          serviceCatagoryList.add(ServiceCategoryModel(
              title: 'Massage',
              services: servicesList
                  .where((service) => service.shopCategoryId == 2)
                  .toList()));
          serviceCatagoryList.add(ServiceCategoryModel(
              title: 'Cắt tóc',
              services: servicesList
                  .where((service) => service.shopCategoryId == 1)
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
        emit(ChooseServicePageNoDataState());
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
      if (_selectedServices.isEmpty) {
        _selectedServices.add(event.selectedService);
      } else {
        if (_selectedServices.contains(event.selectedService)) {
          _selectedServices.remove(event.selectedService);
        } else {
          _selectedServices.add(event.selectedService);
        }
      }
      emit(ChooseServicePageLoadedSuccessState(
          serviceCatagoryList: _serviceCatagoryList,
          selectedServices: _selectedServices));
    } catch (e) {}
  }
}

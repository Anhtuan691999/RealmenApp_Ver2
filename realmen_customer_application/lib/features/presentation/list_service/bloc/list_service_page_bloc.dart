import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/domain/repository/ServiceRepo/service_repository.dart';

part 'list_service_page_event.dart';
part 'list_service_page_state.dart';

class ListServicePageBloc
    extends Bloc<ListServicePageEvent, ListServicePageState> {
  List<ServiceDataModel> _servicesList = [];
  final List<ServiceCategoryModel> _serviceCatagoryList = [];

  ListServicePageBloc() : super(ListServicePageInitial()) {
    on<SPLChooseServicePageInitialEvent>(_chooseServicePageInitialEvent);
    on<SPLChooseServicePageLoadedSuccessEvent>(
        _chooseServicePageLoadedSuccessEvent);
  }
  FutureOr<void> _chooseServicePageInitialEvent(
      SPLChooseServicePageInitialEvent event,
      Emitter<ListServicePageState> emit) async {
    emit(SPLChooseServicePageLoadingPageState());
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
      var services = await serviceRepository.getAllServices(1);
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

          emit(SPLChooseServicePageLoadedSuccessState(
            serviceCatagoryList: serviceCatagoryList,
          ));
        } else {
          emit(SPLChooseServicePageNoDataState());
        }
      } else {
        emit(SPLChooseServicePageNoDataState());
      }
    } catch (e) {
      emit(SPLChooseServicePageNoDataState());
    }
  }

  FutureOr<void> _chooseServicePageLoadedSuccessEvent(
      SPLChooseServicePageLoadedSuccessEvent event,
      Emitter<ListServicePageState> emit) async {
    try {
      emit(SPLLoadingState());

      emit(SPLChooseServicePageLoadedSuccessState(
        serviceCatagoryList: _serviceCatagoryList,
      ));
    } catch (e) {}
  }
}

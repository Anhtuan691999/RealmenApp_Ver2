import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/domain/repository/BranchRepo/branch_repository.dart';

part 'choose_branch_page_event.dart';
part 'choose_branch_page_state.dart';

class ChooseBranchPageBloc
    extends Bloc<ChooseBranchPageEvent, ChooseBranchPageState> {
  ChooseBranchPageBloc() : super(ChooseBranchPageInitial()) {
    on<ChooseBranchPageInitialEvent>(_chooseBranchPageInitialEvent);
    on<ChooseBranchLoadedBranchListEvent>(_chooseBranchLoadedBranchListEvent);
  }

  FutureOr<void> _chooseBranchPageInitialEvent(
      ChooseBranchPageInitialEvent event,
      Emitter<ChooseBranchPageState> emit) async {
    final IBranchRepository branchRepository = BranchRepository();
    // final ChooseBranchPageBloc chooseBranchPageBloc = ChooseBranchPageBloc();
    List<String> cities = [];
    List<BranchProvince> branchProvinceList = [];
    cities.add("TP/Tỉnh");

    try {
      var branchProvinces = await branchRepository.getBranchByProvince();
      var branchProvinceStatus = branchProvinces["status"];
      var branchProvinceBody = branchProvinces["body"];
      if (branchProvinceStatus) {
        branchProvinceList = (branchProvinceBody['content'] as List)
            .map((e) => BranchProvince.fromJson(e as Map<String, dynamic>))
            .toList();
        for (var branchProvince in branchProvinceList) {
          branchProvince.province =
              Utf8Encoding().decode(branchProvince.province!);
          cities.add(branchProvince.province.toString());
        }
      }
      emit(LoadedBookingBranchListState(cities: cities));

      add(ChooseBranchLoadedBranchListEvent());
    } catch (e) {}
  }

  FutureOr<void> _chooseBranchLoadedBranchListEvent(
      ChooseBranchLoadedBranchListEvent event,
      Emitter<ChooseBranchPageState> emit) async {
    // get current state data
    List<String>? currentCities = (state is LoadedBookingBranchListState)
        ? (state as LoadedBookingBranchListState).cities
        : [];
    List<BranchDataModel>? currentBranchList =
        (state is LoadedBookingBranchListState)
            ? (state as LoadedBookingBranchListState).branchList
            : [];

    String currentCityController = (state is LoadedBookingBranchListState)
        ? (state as LoadedBookingBranchListState).cityController ?? "TP/Tỉnh"
        : "TP/Tỉnh";

    emit(LoadingBookingBranchListState());
    final IBranchRepository branchRepository = BranchRepository();
    final storage = FirebaseStorage.instance;
    // cities option
    String cityController = event.cityController ?? "TP/Tỉnh";
    // branch  data
    var branchs;
    var branchsStatus;
    var branchsBody;
    List<BranchDataModel> branchsList = [];
    try {
      if (event.cityController == null || event.cityController == "TP/Tỉnh") {
        branchs = await branchRepository.getBranch(event.search);
        branchsStatus = branchs["status"];
        branchsBody = branchs["body"];
        if (branchsStatus) {
          branchsList = (branchsBody['content'] as List)
              .map((e) => BranchDataModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } else if (event.cityController != "TP/Tỉnh") {
        var branchProvinces = await branchRepository.getBranchByProvince();
        var branchProvinceStatus = branchProvinces["status"];
        var branchProvinceBody = branchProvinces["body"];
        List<BranchProvince> branchProvinceList = [];
        if (branchProvinceStatus) {
          branchProvinceList = (branchProvinceBody['content'] as List)
              .map((e) => BranchProvince.fromJson(e as Map<String, dynamic>))
              .toList();
          branchsList = branchProvinceList
                  .firstWhere(
                    (branchProvince) =>
                        branchProvince.province == event.cityController,
                  )
                  .branches ??
              [];
        }
      }

      if (branchsList.isNotEmpty) {
        List<String> urlList = [
          "barber1.jpg",
          "barber2.jpg",
          "barber3.jpg",
        ];
        for (var branch in branchsList) {
          branch.branchName = Utf8Encoding().decode(branch.branchName!);
          branch.branchAddress = Utf8Encoding().decode(
              '${branch.branchStreet} ${branch.branchWard} ${branch.branchDistrict} ${branch.branchProvince}');
          if (branch.distanceInKm!.distance! >= 1) {
            branch.distanceKm = "${(branch.distanceInKm!.distance!).toInt()}km";
          } else {
            branch.distanceKm =
                "${(branch.distanceInKm!.distance! * 1000).toInt()}m";
          }
          branch.open = branch.open!.substring(0, 2);
          branch.close = branch.close!.substring(0, 2);
          try {
            var reference = storage.ref(branch.branchThumbnail);
            branch.branchThumbnail = await reference.getDownloadURL();
          } catch (e) {
            try {
              final random = Random();
              var randomUrl = random.nextInt(urlList.length);
              var reference = storage.ref('branch/${urlList[randomUrl]}');
              branch.branchThumbnail = await reference.getDownloadURL();
            } catch (e) {
              final random = Random();
              var randomUrl = random.nextInt(urlList.length);
              branch.branchThumbnail = 'assets/image/${urlList[randomUrl]}';
            }
          }
        }
        branchsList.sort((a, b) {
          if (a.distanceInKm!.distance == null &&
              b.distanceInKm!.distance == null) {
            return 0;
          } else if (a.distanceInKm!.distance == null) {
            return 1;
          } else if (b.distanceInKm!.distance == null) {
            return -1;
          } else {
            double distanceA = double.parse(a.distanceInKm!.distance!
                .toString()
                .replaceAll(RegExp(r'[^0-9.]'), ''));
            double distanceB = double.parse(b.distanceInKm!.distance!
                .toString()
                .replaceAll(RegExp(r'[^0-9.]'), ''));
            return distanceA.compareTo(distanceB);
          }
        });
      }

      emit(LoadedBookingBranchListState(
          branchList: branchsList,
          cityController: cityController,
          cities: currentCities));
    } catch (e) {}
  }
}

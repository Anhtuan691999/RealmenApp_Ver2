import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/domain/repository/BranchRepo/branch_repository.dart';

part 'list_branch_page_event.dart';
part 'list_branch_page_state.dart';

class ListBranchPageBloc
    extends Bloc<ListBranchPageEvent, ListBranchPageState> {
  List<BranchDataModel> _branchList = [];
  List<BranchDataModel> _branchListForAutocomplete = [];
  List<String> _cities = [];
  final List<BranchProvince> _branchProvinceList = [];
  String? _cityController;
  ListBranchPageBloc() : super(ListBranchPageInitial()) {
    on<ListBranchPageInitialEvent>(_chooseBranchPageInitialEvent);
    on<LBChooseBranchLoadedBranchListEvent>(_chooseBranchLoadedBranchListEvent);
    on<LBLoadedBranchNearEvent>(_loadedBranchNearEvent);
    on<LBAutocompleteOptionsBuilderEvent>(_autocompleteOptionsBuilderEvent);
    on<LBAutocompleteOnSelectedEvent>(_autocompleteOnSelectedEvent);
    on<LBSearchOnSubmitEvent>(_searchOnSubmitEvent);
    on<LBClearSearchEvent>(_clearSearchEvent);
  }
  FutureOr<void> _chooseBranchPageInitialEvent(ListBranchPageInitialEvent event,
      Emitter<ListBranchPageState> emit) async {
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
      _cities = cities;

      add(const LBChooseBranchLoadedBranchListEvent());
    } catch (e) {}
  }

  FutureOr<void> _chooseBranchLoadedBranchListEvent(
      LBChooseBranchLoadedBranchListEvent event,
      Emitter<ListBranchPageState> emit) async {
    // get current state data

    emit(LBLoadingBookingBranchListState());
    final IBranchRepository branchRepository = BranchRepository();
    final storage = FirebaseStorage.instance;
    // cities option
    String cityController = event.cityController ?? "TP/Tỉnh";
    // branch  data
    Map<String, dynamic> branchs;
    var branchsStatus;
    var branchsBody;
    List<BranchDataModel> branchsList = [];
    try {
      if (event.cityController == null || event.cityController == "TP/Tỉnh") {
        branchs = await branchRepository.getBranch(event.search, null);
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
          branchProvinceList = branchProvinceList
                  .where(
                    (branchProvince) =>
                        Utf8Encoding()
                            .decode(branchProvince.province.toString()) ==
                        event.cityController,
                  )
                  .toList() ??
              [];
          for (var branchProvince in branchProvinceList) {
            if (branchProvince.branches != null) {
              // Thêm tất cả các branches vào danh sách allBranches
              branchsList.addAll(branchProvince.branches!);
            }
          }
        }
      }

      if (branchsList.isNotEmpty) {
        List<String> urlList = [
          "barber1.jpg",
          "barber2.jpg",
          "barber3.jpg",
          "branch.png",
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
            var reference = storage.ref('branch/${branch.branchThumbnail}');
            branch.branchThumbnail = await reference.getDownloadURL();
          } catch (e) {
            try {
              branch.branchThumbnail = 'assets/image/${branch.branchThumbnail}';
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
      _branchList = branchsList;
      emit(LBLoadedBookingBranchListState(
          branchList: branchsList,
          branchListForAutocomplete: branchsList,
          cityController: cityController,
          cities: _cities));
    } catch (e) {}
  }

  FutureOr<void> _loadedBranchNearEvent(
      LBLoadedBranchNearEvent event, Emitter<ListBranchPageState> emit) async {
    // currentCities

    emit(LBLoadingBookingBranchListState());

    final IBranchRepository branchRepository = BranchRepository();
    final storage = FirebaseStorage.instance;
    // cities option
    String cityController = "TP/Tỉnh";
    Map<String, dynamic> branchs;
    var branchsStatus;
    var branchsBody;
    int totalPage = 3;
    int currentPage = 1;
    List<BranchDataModel> branchsList = [];
    List<BranchDataModel> branchsListAll = [];

    List<String> urlList = [
      "barber1.jpg",
      "barber2.jpg",
      "barber3.jpg",
      "branch.png",
    ];

    try {
      while (currentPage < totalPage) {
        branchs = await branchRepository.getBranch(null, currentPage);
        branchsStatus = branchs["status"];
        branchsBody = branchs["body"];

        if (branchsStatus) {
          totalPage = branchsBody["totalPage"];
          currentPage = branchsBody["currentPage"];
          var newBranchList = (branchsBody['content'] as List)
              .map((e) => BranchDataModel.fromJson(e as Map<String, dynamic>))
              .toList();
          branchsListAll.addAll(newBranchList);
        }
        currentPage++;
      }
      currentPage = 1;
      if (branchsListAll.isNotEmpty) {
        branchsList = branchsListAll.where((branch) {
          return branch.distanceInKm!.distance! < 20 ? true : false;
        }).toList();
      }
      if (branchsList.isNotEmpty) {
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
              branch.branchThumbnail = 'assets/image/${branch.branchThumbnail}';
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
      _branchList = branchsList;
      _cityController = cityController;
      emit(LBLoadedBookingBranchListState(
          branchList: branchsList,
          branchListForAutocomplete: branchsList,
          cityController: cityController,
          cities: _cities));
    } catch (e) {}
  }

  FutureOr<void> _autocompleteOptionsBuilderEvent(
      LBAutocompleteOptionsBuilderEvent event,
      Emitter<ListBranchPageState> emit) {
    emit(LBLoadedBookingBranchListState(
        branchList: _branchList,
        cities: _cities,
        cityController: _cityController));
    // }
  }

  FutureOr<void> _autocompleteOnSelectedEvent(
      LBAutocompleteOnSelectedEvent event, Emitter<ListBranchPageState> emit) {
    try {
      _branchListForAutocomplete = [];
      _branchListForAutocomplete.add(event.address!);
      emit(LBAutocompleteOnSelectedState());
      emit(LBLoadedBookingBranchListState(
          branchList: _branchListForAutocomplete,
          branchListForAutocomplete: _branchList,
          cities: _cities,
          cityController: _cityController));
    } catch (e) {}
  }

  FutureOr<void> _searchOnSubmitEvent(
      LBSearchOnSubmitEvent event, Emitter<ListBranchPageState> emit) {
    emit(LBSearchOnSubmitState());
    emit(LBLoadedBookingBranchListState(
        branchList: _branchListForAutocomplete,
        branchListForAutocomplete: _branchList,
        cities: _cities,
        cityController: _cityController));
  }

  FutureOr<void> _clearSearchEvent(
      LBClearSearchEvent event, Emitter<ListBranchPageState> emit) {
    // emit(LoadedBookingBranchListState(
    //     branchList: _branchList,
    //     branchListForAutocomplete: _branchList,
    //     cities: _cities,
    //     cityController: _cityController));
  }
}

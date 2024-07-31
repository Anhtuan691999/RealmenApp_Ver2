import 'dart:async';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:realmen_customer_application/data/models/branch_model.dart';
import 'package:realmen_customer_application/repository/BranchRepo/branch_repository.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageInitialEvent>(_homePageInitialEvent);
  }
  FutureOr<void> _homePageInitialEvent(
      HomePageInitialEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageLoadingState());
    final storage = FirebaseStorage.instance;
    // Branch Data
    var branchs = await BranchRepository().getBranchForHome();

    var branchStatus = branchs["status"];
    var branchBody = branchs["body"];

    List<BranchDataModel> branchList = [];
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
      await Future.delayed(const Duration(seconds: 2));
      emit(HomePageLoadedSuccessState(loadedBranchsList: branchList));
    }
  }
}

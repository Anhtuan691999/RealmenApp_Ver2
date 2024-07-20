import 'dart:async';

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
    // Branch Data
    var branchs = await BranchRepository().getBranchForHome();

    var branchStatus = branchs["status"];
    var branchBody = branchs["body"];

    List<BranchDataModel> branchList = [];
    if (branchStatus) {
      branchList = (branchBody['content'] as List)
          .map((e) => BranchDataModel.fromJson(e))
          .toList();

      await Future.delayed(const Duration(seconds: 2));
      emit(HomePageLoadedSuccessState(loadedBranchsList: branchList));
    }
  }
}

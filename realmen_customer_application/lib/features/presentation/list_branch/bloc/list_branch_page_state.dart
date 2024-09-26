part of 'list_branch_page_bloc.dart';

sealed class ListBranchPageState extends Equatable {
  const ListBranchPageState();

  @override
  List<Object> get props => [];
}

final class ListBranchPageInitial extends ListBranchPageState {}

class LBLoadedBookingBranchListState extends ListBranchPageState {
  List<BranchDataModel>? branchList;
  List<BranchDataModel>? branchListForAutocomplete;
  String? cityController;
  List<String>? cities;

  LBLoadedBookingBranchListState({
    this.branchList,
    this.branchListForAutocomplete,
    this.cityController,
    this.cities,
  }) : super();

  // Phương thức copyWith để tạo trạng thái mới
  LBLoadedBookingBranchListState copyWith({
    List<BranchDataModel>? branchList,
    List<BranchDataModel>? branchListForAutocomplete,
    String? cityController,
    List<String>? cities,
  }) {
    return LBLoadedBookingBranchListState(
      branchList: branchList ?? this.branchList,
      branchListForAutocomplete:
          branchListForAutocomplete ?? this.branchListForAutocomplete,
      cityController: cityController ?? this.cityController,
      cities: cities ?? this.cities,
    );
  }
}

class LBLoadingBookingBranchListState extends ListBranchPageState {}

class LBNoDataBookingBranchListState extends ListBranchPageState {}

class LBLoadedBranchNearState extends ListBranchPageState {}

// ignore: must_be_immutable
class LBAutocompleteOptionsBuilderState extends ListBranchPageState {}

class LBAutocompleteOnSelectedState extends ListBranchPageState {}

class LBSearchOnSubmitState extends ListBranchPageState {}

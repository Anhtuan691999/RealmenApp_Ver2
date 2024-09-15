// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'choose_branch_page_bloc.dart';

sealed class ChooseBranchPageState extends Equatable {
  const ChooseBranchPageState();

  @override
  List<Object?> get props => [];
}

final class ChooseBranchPageInitial extends ChooseBranchPageState {}

class LoadedBookingBranchListState extends ChooseBranchPageState {
  List<BranchDataModel>? branchList;
  List<BranchDataModel>? branchListForAutocomplete;
  String? cityController;
  List<String>? cities;

  LoadedBookingBranchListState({
    this.branchList,
    this.branchListForAutocomplete,
    this.cityController,
    this.cities,
  }) : super();

  @override
  List<Object?> get props =>
      [branchList, cityController, cities, branchListForAutocomplete];

  // Phương thức copyWith để tạo trạng thái mới
  LoadedBookingBranchListState copyWith({
    List<BranchDataModel>? branchList,
    List<BranchDataModel>? branchListForAutocomplete,
    String? cityController,
    List<String>? cities,
  }) {
    return LoadedBookingBranchListState(
      branchList: branchList ?? this.branchList,
      branchListForAutocomplete:
          branchListForAutocomplete ?? this.branchListForAutocomplete,
      cityController: cityController ?? this.cityController,
      cities: cities ?? this.cities,
    );
  }
}

class LoadingBookingBranchListState extends ChooseBranchPageState {}

class NoDataBookingBranchListState extends ChooseBranchPageState {}

class LoadedBranchNearState extends ChooseBranchPageState {}

// ignore: must_be_immutable
class AutocompleteOptionsBuilderState extends ChooseBranchPageState {}

class AutocompleteOnSelectedState extends ChooseBranchPageState {}

class SearchOnSubmitState extends ChooseBranchPageState {}

part of 'choose_branch_page_bloc.dart';

sealed class ChooseBranchPageState extends Equatable {
  ChooseBranchPageState();

  @override
  List<Object?> get props => [];
}

final class ChooseBranchPageInitial extends ChooseBranchPageState {}

class LoadedBookingBranchListState extends ChooseBranchPageState {
  final List<BranchDataModel>? branchList;
  final String? cityController;
  final List<String>? cities;

  LoadedBookingBranchListState({
    this.branchList,
    this.cityController,
    this.cities,
  }) : super();

  @override
  List<Object?> get props => [branchList, cityController, cities];

  // Phương thức copyWith để tạo trạng thái mới
  LoadedBookingBranchListState copyWith({
    List<BranchDataModel>? branchList,
    String? cityController,
    List<String>? cities,
  }) {
    return LoadedBookingBranchListState(
      branchList: branchList ?? this.branchList,
      cityController: cityController ?? this.cityController,
      cities: cities ?? this.cities,
    );
  }
}

class LoadingBookingBranchListState extends ChooseBranchPageState {}

class NoDataBookingBranchListState extends ChooseBranchPageState {}

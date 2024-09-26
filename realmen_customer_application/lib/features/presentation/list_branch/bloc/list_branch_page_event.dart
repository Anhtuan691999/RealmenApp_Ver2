// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_branch_page_bloc.dart';

sealed class ListBranchPageEvent extends Equatable {
  const ListBranchPageEvent();

  @override
  List<Object> get props => [];
}

class ListBranchPageInitialEvent extends ListBranchPageEvent {
  String province;
  ListBranchPageInitialEvent({
    required this.province,
  });
}

class LBChooseBranchLoadedBranchListEvent extends ListBranchPageEvent {
  final String? search;
  final String? cityController;
  const LBChooseBranchLoadedBranchListEvent({this.search, this.cityController});
}

class LBLoadedBranchNearEvent extends ListBranchPageEvent {}

class LBAutocompleteOptionsBuilderEvent extends ListBranchPageEvent {
  final dynamic textEditingValue;
  final String? cityController;
  const LBAutocompleteOptionsBuilderEvent({
    this.textEditingValue,
    this.cityController,
  });
}

class LBAutocompleteOnSelectedEvent extends ListBranchPageEvent {
  BranchDataModel? address;
  LBAutocompleteOnSelectedEvent({
    this.address,
  });
}

class LBSearchOnSubmitEvent extends ListBranchPageEvent {}

class LBClearSearchEvent extends ListBranchPageEvent {}

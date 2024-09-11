// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'choose_branch_page_bloc.dart';

sealed class ChooseBranchPageEvent extends Equatable {
  const ChooseBranchPageEvent();

  @override
  List<Object> get props => [];
}

class ChooseBranchPageInitialEvent extends ChooseBranchPageEvent {}

class ChooseBranchLoadedBranchListEvent extends ChooseBranchPageEvent {
  final String? search;
  final String? cityController;
  ChooseBranchLoadedBranchListEvent({this.search, this.cityController});
}

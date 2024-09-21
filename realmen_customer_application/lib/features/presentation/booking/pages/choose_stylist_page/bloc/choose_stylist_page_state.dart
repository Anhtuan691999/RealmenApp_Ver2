// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'choose_stylist_page_bloc.dart';

sealed class ChooseStylistPageState extends Equatable {
  const ChooseStylistPageState();

  @override
  List<Object> get props => [];
}

final class ChooseStylistPageInitial extends ChooseStylistPageState {}

class CSPLoadingState extends ChooseStylistPageState {}

class CSPLoadedState extends ChooseStylistPageState {
  final List<AccountModel> stylistList;
  CSPLoadedState({
    required this.stylistList,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'choose_stylist_page_bloc.dart';

sealed class ChooseStylistPageEvent extends Equatable {
  const ChooseStylistPageEvent();

  @override
  List<Object> get props => [];
}

class CSPInitialEvent extends ChooseStylistPageEvent {}

class CSPLoadedEvent extends ChooseStylistPageEvent {}

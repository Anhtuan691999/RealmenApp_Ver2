part of 'branch_choose_date_bloc.dart';

sealed class BranchChooseDateState extends Equatable {
  const BranchChooseDateState();
  
  @override
  List<Object> get props => [];
}

final class BranchChooseDateInitial extends BranchChooseDateState {}

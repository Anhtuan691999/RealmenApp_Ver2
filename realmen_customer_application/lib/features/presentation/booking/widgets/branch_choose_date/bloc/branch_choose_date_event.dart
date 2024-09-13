part of 'branch_choose_date_bloc.dart';

sealed class BranchChooseDateEvent extends Equatable {
  const BranchChooseDateEvent();

  @override
  List<Object> get props => [];
}

class BranchChooseDateInitialEvent extends BranchChooseDateEvent {}

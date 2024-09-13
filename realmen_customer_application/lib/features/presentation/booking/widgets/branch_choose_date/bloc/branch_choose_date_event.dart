// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'branch_choose_date_bloc.dart';

sealed class BranchChooseDateEvent extends Equatable {
  const BranchChooseDateEvent();

  @override
  List<Object> get props => [];
}

class BranchChooseDateInitialEvent extends BranchChooseDateEvent {}

class BranchChooseSelectDateEvent extends BranchChooseDateEvent {
  Object? value;
  BranchChooseSelectDateEvent({
    this.value,
  });
}

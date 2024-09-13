// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'branch_choose_date_bloc.dart';

sealed class BranchChooseDateState extends Equatable {
  const BranchChooseDateState();

  @override
  List<Object> get props => [];
}

final class BranchChooseDateInitialState extends BranchChooseDateState {}

class LoadDateState extends BranchChooseDateState {
  List<Map<String, dynamic>>? listDate;
  String? dateController;
  Map<String, dynamic>? dateSeleted;
  String? type;
  LoadDateState({
    this.listDate,
    this.dateController,
    this.dateSeleted,
    this.type,
  });
}

class BranchChooseSelectDateState extends BranchChooseDateState {
  String? dateController;
  Map<String, dynamic>? dateSeleted;
  String? type;
  BranchChooseSelectDateState({
    this.dateController,
    this.dateSeleted,
    this.type,
  });
}

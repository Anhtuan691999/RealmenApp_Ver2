import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'branch_choose_date_event.dart';
part 'branch_choose_date_state.dart';

class BranchChooseDateBloc
    extends Bloc<BranchChooseDateEvent, BranchChooseDateState> {
  BranchChooseDateBloc() : super(BranchChooseDateInitial()) {
    on<BranchChooseDateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_branch_page_event.dart';
part 'list_branch_page_state.dart';

class ListBranchPageBloc extends Bloc<ListBranchPageEvent, ListBranchPageState> {
  ListBranchPageBloc() : super(ListBranchPageInitial()) {
    on<ListBranchPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

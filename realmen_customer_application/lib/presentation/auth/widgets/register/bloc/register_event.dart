part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterInitialEvent extends RegisterEvent {}

class RegisterSelectGenderEvent extends RegisterEvent {
  final String gender;

  const RegisterSelectGenderEvent({required this.gender});
}

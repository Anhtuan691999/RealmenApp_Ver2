part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

class RegisterSelectGenderState extends RegisterState {
  final String gender;

  const RegisterSelectGenderState({required this.gender});
}

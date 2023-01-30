part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterChangeBodyState extends RegisterState {
  final RegisterScreenBodyEnums enumValue;

  RegisterChangeBodyState(this.enumValue);
}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterSuccesfullState extends RegisterState {}

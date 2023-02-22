part of 'login_screen_bloc.dart';

abstract class LoginScreenState {}

class LoginScreenInitial extends LoginScreenState {}

class AuthorizedSuccessState extends LoginScreenState {}

class AuthorizedErrorState extends LoginScreenState {
  final String error;

  AuthorizedErrorState(this.error);
}

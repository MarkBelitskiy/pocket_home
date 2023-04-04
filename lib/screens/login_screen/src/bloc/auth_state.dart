part of 'auth_bloc.dart';

abstract class AuthState {}

class LoginScreenInitial extends AuthState {}

class AuthorizedSuccessState extends AuthState {
  AuthorizedSuccessState();
}

class UserIsNotAuthorizedState extends AuthState {}

class AuthorizedErrorState extends AuthState {
  final String error;

  AuthorizedErrorState(this.error);
}

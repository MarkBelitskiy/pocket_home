part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String login;
  final String password;

  LoginEvent(this.login, this.password);
}

class InitAuthEvent extends AuthEvent {}

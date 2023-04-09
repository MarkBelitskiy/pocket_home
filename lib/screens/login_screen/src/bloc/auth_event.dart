part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String login;
  final String password;

  LoginEvent(this.login, this.password);
}

class InitAuthEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}

class DeleteAccountEvent extends AuthEvent {
  final UserModel user;

  DeleteAccountEvent(this.user);
}

class ResetPasswordEvent extends AuthEvent {
  final String newPass;
  final String phone;

  ResetPasswordEvent(this.newPass, this.phone);
}

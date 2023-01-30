part of 'login_screen_bloc.dart';

@immutable
abstract class LoginScreenEvent {}

class LoginEvent extends LoginScreenEvent {
  final String login;
  final String password;

  LoginEvent(this.login, this.password);
}

part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class ChangeBodyEvent extends RegisterEvent {
  final RegisterScreenBodyEnums enumValue;

  ChangeBodyEvent(this.enumValue);
}

class CreateProfileEvent extends RegisterEvent {
  final Profile profile;
  final String login;
  CreateProfileEvent(this.profile, this.login);
}

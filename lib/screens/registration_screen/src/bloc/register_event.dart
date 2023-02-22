part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class ChangeBodyEvent extends RegisterEvent {
  final RegisterScreenBodyEnums enumValue;

  ChangeBodyEvent(this.enumValue);
}

class CreateProfileEvent extends RegisterEvent {
  final UserModel profile;

  CreateProfileEvent(this.profile);
}

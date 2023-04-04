part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class InitEvent extends ProfileEvent {}

class OnDeleteAccountEvent extends ProfileEvent {}

class OnLogoutEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final UserModel profile;

  UpdateProfileEvent(this.profile);
}

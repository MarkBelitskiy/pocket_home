part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final Profile profile;

  ProfileLoadedState(this.profile);
}

class ProfileSuccessDeletedState extends ProfileState {}

class LogoutState extends ProfileState {}

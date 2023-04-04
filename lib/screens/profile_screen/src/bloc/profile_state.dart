part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserModel profile;

  ProfileLoadedState(this.profile);
}

class ProfileSuccessDeletedState extends ProfileState {}

class LogoutState extends ProfileState {}

class ProfileLoadedErrorState extends ProfileState {}

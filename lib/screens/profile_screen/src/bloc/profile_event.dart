part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class InitEvent extends ProfileEvent {}

class OnDeleteAccountEvent extends ProfileEvent {}

class OnLogoutEvent extends ProfileEvent {}

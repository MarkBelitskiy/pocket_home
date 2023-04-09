part of 'services_bloc.dart';

abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<ServiceDetailedModel> activeModels;
  final List<ServiceDetailedModel> historyModels;
  final HouseModel currentHouse;
  final UserModel user;
  ServicesLoaded(this.activeModels, this.historyModels, this.currentHouse, this.user);
}

class LoadingState extends ServicesState {
  final bool isLaoding;

  LoadingState(this.isLaoding);
}

class RatingSetToServiceState extends ServicesState {}

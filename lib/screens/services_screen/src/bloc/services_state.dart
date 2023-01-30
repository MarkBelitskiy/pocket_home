part of 'services_bloc.dart';

abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<ServiceItemModel> activeModels;
  final List<ServiceItemModel> historyModels;
  ServicesLoaded(this.activeModels, this.historyModels);
}

class LoadingState extends ServicesState {
  final bool isLaoding;

  LoadingState(this.isLaoding);
}

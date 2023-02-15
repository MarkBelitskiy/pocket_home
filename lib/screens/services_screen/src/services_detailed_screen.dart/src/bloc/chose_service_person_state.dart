part of 'chose_service_person_bloc.dart';

abstract class ChoseServicePersonState {}

class ChoseServicePersonInitial extends ChoseServicePersonState {}

class PersonsLoadedState extends ChoseServicePersonInitial {
  final List<ServicePersonModel> items;

  PersonsLoadedState(this.items);
}

class LoadingPersonsDataState extends ChoseServicePersonInitial {
  final bool isLoading;

  LoadingPersonsDataState(this.isLoading);
}

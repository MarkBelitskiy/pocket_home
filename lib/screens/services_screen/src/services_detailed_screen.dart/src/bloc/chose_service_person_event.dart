part of 'chose_service_person_bloc.dart';

abstract class ChoseServicePersonEvent {}

class InitPersonsDataEvent extends ChoseServicePersonEvent {}

class SearchPersonsEvent extends ChoseServicePersonEvent {
  final String searchableValue;

  SearchPersonsEvent(this.searchableValue);
}

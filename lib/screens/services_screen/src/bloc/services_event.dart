part of 'services_bloc.dart';

abstract class ServicesEvent {}

class InitEvent extends ServicesEvent {
  final bool? needSaveToPrefs;

  InitEvent({this.needSaveToPrefs});
}

class AddNewServiceEvent extends ServicesEvent {}

class ChangeServiceValue extends ServicesEvent {
  final int value;
  final int model;
  ChangeServiceValue(this.value, this.model);
}

class DeclineServiceEvent extends ServicesEvent {
  final int index;
  final String reason;

  DeclineServiceEvent(this.index, this.reason);
}

class SetRatingValueEvent extends ServicesEvent {
  final int rating;
  final int item;
  SetRatingValueEvent(this.rating, this.item);
}

class SetWorkerEvent extends ServicesEvent {
  final WorkerModel worker;
  final int index;
  SetWorkerEvent(this.worker, this.index);
}

class ScreenUpdateEvent extends ServicesEvent {}

part of 'workers_bloc.dart';

abstract class WorkersEvent {}

class InitWorkersEvent extends WorkersEvent {}

class AddWorkerToHouseEvent extends WorkersEvent {
  final WorkerModel worker;

  AddWorkerToHouseEvent(this.worker);
}

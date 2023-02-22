part of 'workers_bloc.dart';

abstract class WorkersState {}

class WorkersInitial extends WorkersState {}

class WorkersLoadedState extends WorkersState {
  final List<WorkerModel> workerModel;

  WorkersLoadedState(this.workerModel);
}

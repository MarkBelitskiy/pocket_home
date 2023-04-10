import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/models/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';

import 'package:pocket_home/common/repository/models/worker_model.dart';

part 'workers_event.dart';
part 'workers_state.dart';

class WorkersBloc extends Bloc<WorkersEvent, WorkersState> {
  final MyHousesBloc myHousesBloc;
  final HouseModel currentHouse;
  final List<WorkerModel> workers = [];
  WorkersBloc({required this.currentHouse, required this.myHousesBloc}) : super(WorkersInitial()) {
    on<InitWorkersEvent>(_onInit);
    on<AddWorkerToHouseEvent>(_onAddWorker);
  }
  Future _onInit(InitWorkersEvent event, Emitter<WorkersState> emit) async {
    workers.addAll(myHousesBloc.currentHouse?.workers ?? []);
    emit(WorkersLoadedState(workers));
  }

  Future _onAddWorker(AddWorkerToHouseEvent event, Emitter<WorkersState> emit) async {
    if (currentHouse.workers?.isNotEmpty ?? false) {
      currentHouse.workers?.add(event.worker);
    } else {
      currentHouse.workers = workers;
    }
    myHousesBloc.add(SaveHouseToPrefs());
    workers.add(event.worker);
    emit(WorkersLoadedState(workers));
  }
}

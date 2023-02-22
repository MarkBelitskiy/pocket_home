import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';

import 'package:pocket_home/screens/my_home_screen/src/workers_screen/src/add_new_worker_screen.dart/src/worker_model.dart';

part 'workers_event.dart';
part 'workers_state.dart';

class WorkersBloc extends Bloc<WorkersEvent, WorkersState> {
  final MyHousesBloc myHousesBloc;
  final List<WorkerModel> workers = [];
  WorkersBloc(this.myHousesBloc) : super(WorkersInitial()) {
    on<InitWorkersEvent>(_onInit);
    on<AddWorkerToHouseEvent>(_onAddWorker);
  }
  Future _onInit(InitWorkersEvent event, Emitter<WorkersState> emit) async {
    workers.addAll(myHousesBloc.currentHouse?.workers ?? []);
    emit(WorkersLoadedState(workers));
  }

  Future _onAddWorker(AddWorkerToHouseEvent event, Emitter<WorkersState> emit) async {
    print('testtt ${myHousesBloc.currentHouse?.workers}');
    if (myHousesBloc.currentHouse?.workers?.isNotEmpty ?? false) {
      print('testtt1 ${myHousesBloc.currentHouse?.workers}');
      myHousesBloc.currentHouse?.workers?.add(event.worker);
    } else {
      print('testtt2 ${myHousesBloc.currentHouse?.workers}');
      myHousesBloc.currentHouse?.workers = workers;
    }
    myHousesBloc.add(SaveHouseToPrefs());
    workers.add(event.worker);
    emit(WorkersLoadedState(workers));
  }
}

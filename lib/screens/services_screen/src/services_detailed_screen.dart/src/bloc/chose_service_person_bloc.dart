import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/workers_screen/src/add_new_worker_screen.dart/src/worker_model.dart';

part 'chose_service_person_event.dart';
part 'chose_service_person_state.dart';

class ChoseServicePersonBloc extends Bloc<ChoseServicePersonEvent, ChoseServicePersonState> {
  final HouseModel currentHouse;
  ChoseServicePersonBloc(this.currentHouse) : super(ChoseServicePersonInitial()) {
    on<InitPersonsDataEvent>(_onInit);
    on<SearchPersonsEvent>(_onSearch);
  }
  List<WorkerModel> workers = [];
  Future _onInit(InitPersonsDataEvent event, Emitter<ChoseServicePersonState> emit) async {
    emit(LoadingPersonsDataState(true));

    workers.addAll(currentHouse.workers ?? []);

    emit(LoadingPersonsDataState(false));
    emit(PersonsLoadedState(workers));
  }

  Future _onSearch(SearchPersonsEvent event, Emitter<ChoseServicePersonState> emit) async {
    List<WorkerModel> searchableList = [];
//TODO ADD SEARCH ABSTRACT
    for (var worker in workers) {
      if (event.searchableValue.contains(
        RegExp("[0-9]"),
      )) {
        if (worker.phone.toLowerCase().contains(
              event.searchableValue.toLowerCase(),
            )) {
          if (!searchableList.contains(worker)) {
            searchableList.add(worker);
          }
        }
      } else {
        if (worker.fullName.toLowerCase().contains(
              event.searchableValue.toLowerCase(),
            )) {
          if (!searchableList.contains(worker)) {
            searchableList.add(worker);
          }
        }
      }
      if (worker.jobTitle.toLowerCase().contains(
            event.searchableValue.toLowerCase(),
          )) {
        if (!searchableList.contains(worker)) {
          searchableList.add(worker);
        }
      }
    }

    emit(PersonsLoadedState(searchableList));
  }
}

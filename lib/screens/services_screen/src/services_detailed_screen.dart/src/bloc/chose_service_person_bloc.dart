import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/screens/services_screen/src/services_detailed_screen.dart/src/service_person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'chose_service_person_event.dart';
part 'chose_service_person_state.dart';

class ChoseServicePersonBloc extends Bloc<ChoseServicePersonEvent, ChoseServicePersonState> {
  List<ServicePersonModel> persons = [
    ServicePersonModel(jobTitle: 'Слесарь-Сантехник', name: 'Иван Иваныч', phone: '+7 700 777 777 77'),
    ServicePersonModel(jobTitle: 'Дворник', name: 'Иван Иваныч', phone: '+7 770 777 777 77')
  ];
  ChoseServicePersonBloc() : super(ChoseServicePersonInitial()) {
    on<InitPersonsDataEvent>(_onInit);
    on<SearchPersonsEvent>(_onSearch);
  }
  Future _onInit(InitPersonsDataEvent event, Emitter<ChoseServicePersonState> emit) async {
    emit(LoadingPersonsDataState(true));
    final prefs = await SharedPreferences.getInstance();

    final modelFromPrefs = prefs.getString('servicesPersonsModels');

    if (modelFromPrefs != null) {
      persons.addAll(servicePersonModelFromJson(modelFromPrefs));
    }
    emit(LoadingPersonsDataState(false));
    emit(PersonsLoadedState(persons));
  }

  Future _onSearch(SearchPersonsEvent event, Emitter<ChoseServicePersonState> emit) async {
    List<ServicePersonModel> searchableList = [];

    for (var person in persons) {
      if (event.searchableValue.contains(
        RegExp("[0-9]"),
      )) {
        if (person.phone.toLowerCase().contains(
              event.searchableValue.toLowerCase(),
            )) {
          if (!searchableList.contains(person)) {
            searchableList.add(person);
          }
        }
      } else {
        if (person.name.toLowerCase().contains(
              event.searchableValue.toLowerCase(),
            )) {
          if (!searchableList.contains(person)) {
            searchableList.add(person);
          }
        }
      }
      if (person.jobTitle.toLowerCase().contains(
            event.searchableValue.toLowerCase(),
          )) {
        if (!searchableList.contains(person)) {
          searchableList.add(person);
        }
      }
    }

    emit(PersonsLoadedState(searchableList));
  }
}

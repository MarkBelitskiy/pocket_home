import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/screens/services_screen/src/services_detailed_screen.dart/src/service_person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service_detailed_model.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<InitEvent>(_onInit);
    on<ChangeServiceValue>(_onChangeStatusEvent);
    on<DeclineServiceEvent>(_onDeclineEvent);
    on<SetRatingValueEvent>(_onSetRatingEvent);
    on<SetWorkerEvent>(_setWorkerEvent);
    on<ScreenUpdateEvent>(_updateScreenEvent);
  }

  ///Модельки
  List<ServiceDetailedModel> activeModels = [];
  List<ServiceDetailedModel> historyModels = [];

  Future<void> _onInit(InitEvent event, Emitter<ServicesState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      activeModels.clear();
      historyModels.clear();
      List<ServiceDetailedModel> model = [];
      emit(LoadingState(true));

      final modelFromPrefs = prefs.getString('servicesModels');

      if (modelFromPrefs != null) model = addServiceModelFromJson(modelFromPrefs);
      for (var element in model) {
        if (element.status == 1 || element.status == 0) {
          activeModels.add(element);
        } else {
          historyModels.add(element);
        }
      }
      activeModels.sort((a, b) => a.publishDate.millisecondsSinceEpoch);
      historyModels.sort((a, b) => a.publishDate.millisecondsSinceEpoch);
      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(const [], const []));
    }
  }

  Future<void> _onChangeStatusEvent(ChangeServiceValue event, Emitter<ServicesState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      emit(LoadingState(true));

      activeModels[event.model].status = event.value;
      List<ServiceDetailedModel> model = [...activeModels, ...historyModels];

      prefs.setString('servicesModels', addServiceModelToJson(model));
      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(const [], const []));
    }
  }

  Future<void> _onDeclineEvent(DeclineServiceEvent event, Emitter<ServicesState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      emit(LoadingState(true));

      activeModels[event.index].status = 2;
      activeModels[event.index].workerCommentary = event.reason;
      List<ServiceDetailedModel> model = [...activeModels, ...historyModels];
      historyModels.add(activeModels[event.index]);
      activeModels.removeAt(event.index);
      prefs.setString('servicesModels', addServiceModelToJson(model));
      emit(LoadingState(false));
      // emit(ServicesLoaded(activeModels, historyModels));
    } catch (e) {
      emit(LoadingState(false));
      // emit(ServicesLoaded(const [], const []));
    }
  }

  Future<void> _onSetRatingEvent(SetRatingValueEvent event, Emitter<ServicesState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      emit(LoadingState(true));

      activeModels[event.item].status = 3;
      activeModels[event.item].ratingValue = event.rating;

      List<ServiceDetailedModel> model = [...activeModels, ...historyModels];

      historyModels.add(activeModels[event.item]);
      activeModels.removeAt(event.item);
      prefs.setString('servicesModels', addServiceModelToJson(model));
      emit(RatingSetToServiceState());
      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(const [], const []));
    }
  }

  Future<void> _setWorkerEvent(SetWorkerEvent event, Emitter<ServicesState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      emit(LoadingState(true));

      activeModels[event.index].choosePerson = event.worker;

      List<ServiceDetailedModel> model = [...activeModels, ...historyModels];

      prefs.setString('servicesModels', addServiceModelToJson(model));

      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(const [], const []));
    }
  }

  Future<void> _updateScreenEvent(ScreenUpdateEvent event, Emitter<ServicesState> emit) async {
    try {
      emit(ServicesLoaded(activeModels, historyModels));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(const [], const []));
    }
  }
}

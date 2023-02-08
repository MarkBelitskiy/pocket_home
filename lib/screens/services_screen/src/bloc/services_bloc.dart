import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service_detailed_model.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<InitEvent>(_onInit);
  }

  ///Модельки
  List<ServiceDetailedModel> activeModels = [];
  List<ServiceDetailedModel> historyModels = [];

  Future<void> _onInit(InitEvent event, Emitter<ServicesState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      List<ServiceDetailedModel> model = [];
      emit(LoadingState(true));
      await Future.delayed(const Duration(seconds: 1));

      final modelFromPrefs = prefs.getString('servicesModels');

      if (modelFromPrefs != null) model = addServiceModelFromJson(modelFromPrefs);
      for (var element in model) {
        if (element.status != 3) {
          activeModels.add(element);
        } else {
          historyModels.add(element);
        }
      }

      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(const [], const []));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service_item_model.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<ServicesEvent>((event, emit) {
      if (event is InitEvent) {}
      on<InitEvent>(_onInit);
    });
  }

  ///Модельки
  List<ServiceItemModel> activeModels = [];
  List<ServiceItemModel> historyModels = [];

  Future<void> _onInit(InitEvent event, Emitter<ServicesState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      List<ServiceItemModel> model = [];
      emit(LoadingState(true));
      await Future.delayed(const Duration(seconds: 1));

      final modelFromPrefs = prefs.getString('servicesModels');

      if (modelFromPrefs != null) model = newsModelFromJson(modelFromPrefs);
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

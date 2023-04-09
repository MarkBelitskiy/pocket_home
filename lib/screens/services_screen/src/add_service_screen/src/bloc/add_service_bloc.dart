import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/services_screen/src/bloc/services_bloc.dart';
import 'package:pocket_home/screens/services_screen/src/service_detailed_model.dart';

part 'add_service_event.dart';
part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  AddServiceBloc({required this.servicesBloc, required this.currentHouse}) : super(AddServiceInitial()) {
    on<CreateServceEvent>(createServiceEvent);
  }
  final ServicesBloc servicesBloc;
  final HouseModel currentHouse;

  Future<void> createServiceEvent(CreateServceEvent event, Emitter<AddServiceState> emit) async {
    try {
      if (currentHouse.services != null && (currentHouse.services!.isNotEmpty)) {
        currentHouse.services!.add(event.modelToPrefs);
      } else {
        currentHouse.services = [event.modelToPrefs];
      }

      servicesBloc.add(InitEvent(needSaveToPrefs: true));

      emit(ServicesAddedState());
    } catch (e) {
      if (kDebugMode) {
        print('CREATE_SERVICE_EVENT_ERROR: $e');
      }
    }
  }
}

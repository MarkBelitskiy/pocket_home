import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/screens/services_screen/src/service_detailed_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_service_event.dart';
part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  AddServiceBloc() : super(AddServiceInitial()) {
    on<CreateServceEvent>(createServiceEvent);
  }

  Future<void> createServiceEvent(CreateServceEvent event, Emitter<AddServiceState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    List<ServiceDetailedModel> model = [];

    final modelFromPrefs = prefs.getString('servicesModels');

    if (modelFromPrefs != null) model = addServiceModelFromJson(modelFromPrefs);

    model.add(event.modelToPrefs);
    prefs.setString("servicesModels", addServiceModelToJson(model));
  }
}

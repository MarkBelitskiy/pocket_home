import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_service_event.dart';
part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  AddServiceBloc() : super(AddServiceInitial()) {
    on<AddServiceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

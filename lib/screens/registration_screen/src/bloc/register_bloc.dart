import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/common/repository/models/profile_model.dart';

import '../body_enums.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Repository repository;
  RegisterBloc(this.repository) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {
      if (event is ChangeBodyEvent) {
        emit(RegisterChangeBodyState(event.enumValue));
      }
      if (event is CreateProfileEvent) {
        _createProfileEvent(event, emit);
      }
    });
  }

  Future<void> _createProfileEvent(CreateProfileEvent event, Emitter<RegisterState> emit) async {
    try {
      String? response = await repository.userRepo.registerUser(user: event.profile);
      if (response == null) {
        emit(RegisterSuccesfullState());
      } else {
        throw response;
      }
    } catch (e) {
      emit(
        RegisterErrorState(
          e.toString(),
        ),
      );
    }
  }
}

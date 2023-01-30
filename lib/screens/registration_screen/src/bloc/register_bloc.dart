import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../body_enums.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {
      if (event is ChangeBodyEvent) {
        emit(RegisterChangeBodyState(event.enumValue));
      }
      if (event is CreateProfileEvent) {
        _createProfileEvent(event, emit);
      }
    });
  }

  Future<void> _createProfileEvent(
      CreateProfileEvent event, Emitter<RegisterState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      bool isALreadyRegistered = prefs.getString(event.login) != null;
      if (isALreadyRegistered) throw 'Аккаунт уже зарегистрирован';
      prefs.setString(event.login, profileToJson(event.profile));
    } catch (e) {
      emit(
        RegisterErrorState(
          e.toString(),
        ),
      );
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pocket_home/common/utils/preferences_utils.dart';
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

  Future<void> _createProfileEvent(CreateProfileEvent event, Emitter<RegisterState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      String? usersStringFromPrefs = prefs.getString(PreferencesUtils.usersKey);

      List<UserModel> users = usersStringFromPrefs != null && usersStringFromPrefs.isNotEmpty
          ? usersModelFromJson(usersStringFromPrefs)
          : [];

      bool isALreadyRegistered = users.any((element) => element.login == event.profile.login);

      if (isALreadyRegistered) {
        throw 'Аккаунт уже зарегистрирован';
      }

      prefs.setString(PreferencesUtils.loginKey, event.profile.login);

      users.add(event.profile);

      prefs.setString(PreferencesUtils.usersKey, usersModelToJson(users));

      prefs.setBool(PreferencesUtils.authorizedKey, true);

      emit(RegisterSuccesfullState());
    } catch (e) {
      emit(
        RegisterErrorState(
          e.toString(),
        ),
      );
    }
  }
}

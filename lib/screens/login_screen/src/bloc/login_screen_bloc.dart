import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/utils/preferences_utils.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitial()) {
    on<LoginScreenEvent>((event, emit) {
      if (event is LoginEvent) {
        _loginEvent(event, emit);
      }
    });
  }

  Future<void> _loginEvent(LoginEvent event, Emitter<LoginScreenState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      String? usersStringFromPrefs = prefs.getString(PreferencesUtils.usersKey);

      List<UserModel> users = usersStringFromPrefs != null && usersStringFromPrefs.isNotEmpty
          ? usersModelFromJson(usersStringFromPrefs)
          : [];

      UserModel? user;

      for (var i = 0; i < users.length; i++) {
        if (users[i].login == event.login) {
          user = users[i];
        }
      }

      if (user == null) {
        throw 'Аккаунт не зарегистрирован';
      }

      if (user.password != event.password) {
        throw 'Пароль неверный';
      }

      prefs.setString(PreferencesUtils.loginKey, user.login);

      prefs.setBool(PreferencesUtils.authorizedKey, true);

      emit(AuthorizedSuccessState());
    } catch (e) {
      emit(AuthorizedErrorState(e.toString()));
    }
  }
}

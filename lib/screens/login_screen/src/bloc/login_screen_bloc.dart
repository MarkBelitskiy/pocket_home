import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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

    String? loginfromPrefs = prefs.getString(event.login);

    try {
      if (loginfromPrefs != null && loginfromPrefs.isNotEmpty) {
        prefs.setBool('authorized', true);
        emit(AuthorizedSuccessState());
      } else
        throw 'Профиль не существует';
    } catch (e) {}
  }
}

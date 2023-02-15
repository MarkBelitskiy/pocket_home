import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Profile? profile;
  ProfileBloc() : super(ProfileInitial()) {
    on<InitEvent>(_onInit);
    on<OnDeleteAccountEvent>(_onDelete);
    on<OnLogoutEvent>(_onLogout);
  }

  Future _onInit(InitEvent event, Emitter<ProfileState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    String? profileFromPrefs = prefs.getString('profilekey');
    try {
      if (profileFromPrefs != null) {
        profile = profileFromJson(profileFromPrefs);

        emit(ProfileLoadedState(profile!));
      }
    } catch (e) {}
  }

  Future _onDelete(OnDeleteAccountEvent event, Emitter<ProfileState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(profile!.login, '');
    prefs.setString('profilekey', '');
    prefs.setBool('authorized', false);
    emit(ProfileSuccessDeletedState());
  }

  Future _onLogout(OnLogoutEvent event, Emitter<ProfileState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('authorized', false);
    emit(LogoutState());
  }
}

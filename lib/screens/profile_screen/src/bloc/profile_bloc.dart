import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/common/utils/preferences_utils.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserModel? profile;
  final Repository repository;
  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<InitEvent>(_onInit);
    on<OnDeleteAccountEvent>(_onDelete);
    on<OnLogoutEvent>(_onLogout);
    on<UpdateProfileEvent>(_onUpdate);
  }

  Future _onUpdate(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    await repository.userRepo.updateUser(user: event.profile);
  }

  Future _onInit(InitEvent event, Emitter<ProfileState> emit) async {
    profile = await repository.userRepo.getUser();
    if (profile == null) {
      emit(ProfileLoadedErrorState());
    } else {
      emit(ProfileLoadedState(profile!));
    }
  }

  Future _onDelete(OnDeleteAccountEvent event, Emitter<ProfileState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    String? usersStringFromPrefs = prefs.getString(PreferencesUtils.usersKey);
    String? login = prefs.getString(PreferencesUtils.loginKey);
    List<UserModel> users =
        usersStringFromPrefs != null && usersStringFromPrefs.isNotEmpty ? usersModelFromJson(usersStringFromPrefs) : [];
    users.removeWhere((element) => element.login == login);
    prefs.setString(PreferencesUtils.usersKey, usersModelToJson(users));
    prefs.setString(PreferencesUtils.loginKey, '');
    prefs.setBool(PreferencesUtils.authorizedKey, false);
    emit(ProfileSuccessDeletedState());
  }

  Future _onLogout(OnLogoutEvent event, Emitter<ProfileState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool(PreferencesUtils.authorizedKey, false);
    prefs.setString(PreferencesUtils.loginKey, '');
    emit(LogoutState());
  }
}

import 'dart:convert';

import 'package:pocket_home/common/repository/base_repository_models.dart/base_user_repository.dart';
import 'package:pocket_home/common/utils/preferences_utils.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUserRepository extends BaseUserRepository {
  final SharedPreferences preferences;

  MainUserRepository({required this.preferences});

  @override
  Future<UserModel?> getUser() async {
    String? userStringFromPrefs = preferences.getString(PreferencesUtils.authenticatedUser);
    if (userStringFromPrefs != null && userStringFromPrefs.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(userStringFromPrefs));
    }
    return null;
  }

  @override
  Future<String?> authUser({required String login, required String password}) async {
    String? usersStringFromPrefs = preferences.getString(PreferencesUtils.usersKey);

    List<UserModel> users =
        usersStringFromPrefs != null && usersStringFromPrefs.isNotEmpty ? usersModelFromJson(usersStringFromPrefs) : [];

    UserModel? user;

    for (var i = 0; i < users.length; i++) {
      if (users[i].login == login) {
        user = users[i];
      }
    }

    if (user == null) {
      return 'Аккаунт не зарегистрирован';
    }

    if (user.password != password) {
      return 'Пароль неверный';
    }

    preferences.setString(PreferencesUtils.loginKey, user.login);

    preferences.setBool(PreferencesUtils.authorizedKey, true);

    preferences.setString(PreferencesUtils.authenticatedUser, jsonEncode(user.toJson()));

    return null;
  }

  @override
  Future updateUser({required UserModel user}) async {
    String? usersStringFromPrefs = preferences.getString(PreferencesUtils.usersKey);

    List<UserModel> users =
        usersStringFromPrefs != null && usersStringFromPrefs.isNotEmpty ? usersModelFromJson(usersStringFromPrefs) : [];

    for (var i = 0; i < users.length; i++) {
      if (users[i].login == user.login) {
        users[i] = user;
      }
    }
    preferences.setString(PreferencesUtils.authenticatedUser, jsonEncode(user.toJson()));
    preferences.setString(PreferencesUtils.usersKey, usersModelToJson(users));
  }
}

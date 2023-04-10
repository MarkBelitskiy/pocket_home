import 'package:pocket_home/common/repository/models/profile_model.dart';

abstract class BaseUserRepository {
  Future<UserModel?> getUser();

  Future<String?> authUser({required String login, required String password});

  Future updateUser({required UserModel user});
  Future deleteUser({required UserModel user});
  Future<String?> registerUser({required UserModel user});

  Future logOutUser();
  Future resetPassword({required String phone, required String password});
}

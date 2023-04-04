import 'package:dio/dio.dart';
import 'package:pocket_home/common/repository/base_repository_models.dart/base_houses_repo.dart';
import 'package:pocket_home/common/repository/base_repository_models.dart/base_news_repo.dart';
import 'package:pocket_home/common/repository/main_repository_model.dart/main_houses_repo.dart';
import 'package:pocket_home/common/repository/main_repository_model.dart/main_news_repo.dart';
import 'package:pocket_home/common/repository/main_repository_model.dart/main_user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  final Dio _dio =
      Dio(BaseOptions(connectTimeout: const Duration(seconds: 120), receiveTimeout: const Duration(seconds: 120)));

  Future init(SharedPreferences prefs) async {
    final interceptor = _dio.interceptors;

    interceptor.add(LogInterceptor(
        request: true, requestBody: true, requestHeader: true, responseBody: true, responseHeader: true));
    newsRepo = MainNewsRepository(preferences: prefs, dio: _dio);
    userRepo = MainUserRepository(preferences: prefs);
    housesRepo = MainHousesRepository(preferences: prefs);
  }

  late BaseNewsRepository newsRepo;
  late MainUserRepository userRepo;
  late BaseHousesRepository housesRepo;
}

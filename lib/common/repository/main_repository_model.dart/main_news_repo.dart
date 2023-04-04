import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pocket_home/common/repository/base_repository_models.dart/base_news_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class MainNewsRepository extends BaseNewsRepository {
  final SharedPreferences preferences;
  final Dio dio;
  MainNewsRepository({required this.preferences, required this.dio});

  String chatId = '-1001702597747';
  String url = 'https://api.telegram.org/bot5974662113:AAGnmHMRbjVGQKCnPfnC_CJXVApmYwK_3NU';
  @override
  Future addNewsToTelegramChat({File? file, required String newsTitle, required String newsMsg}) async {
    FormData formData = FormData.fromMap({
      "photo": file != null
          ? MultipartFile.fromBytes(file.readAsBytesSync(), filename: 'newsPhoto.${path.extension(file.path)}')
          : null,
      "caption": '$newsTitle \n$newsMsg',
    });
    await dio.post('$url/sendPhoto', data: formData, queryParameters: {"chat_id": chatId});
  }

  @override
  Future addPollToTelegramChat({required String title, required List<String> options}) async {
    final data = FormData.fromMap({
      'question': title,
      'options': json.encode(options),
      'chat_id': chatId,
    });

    await dio.post('$url/sendPoll', data: data);
  }
}

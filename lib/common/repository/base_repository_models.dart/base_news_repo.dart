import 'dart:io';

abstract class BaseNewsRepository {
  Future addNewsToTelegramChat({File? file, required String newsTitle, required String newsMsg});
  Future addPollToTelegramChat({required String title, required List<String> options});
}

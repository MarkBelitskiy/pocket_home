import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class MainAppLocaleViewModel extends ChangeNotifier {
  void changeLocale(BuildContext context) {
    context.setLocale(context.locale == const Locale('ru', 'RU') ? const Locale('kk', 'KZ') : const Locale('ru', 'RU'));
    notifyListeners();
  }
}

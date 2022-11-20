import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pocket_home/common/theme/main_app_theme/main_app_theme_view_model.dart';
import 'package:pocket_home/common/utils/locale_view_model.dart';
import 'package:pocket_home/screens/main_screen/feature.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('ru', 'RU'), Locale('kk', 'KZ')],
        path: 'assets/languages',
        child: ChangeNotifierProvider<MainAppThemeViewModel>(
          create: (context) => MainAppThemeViewModel()..init(preferences),
          child: MyApp(preferences: preferences),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.preferences}) : super(key: key);
  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainAppLocaleViewModel>(
      create: (context) => MainAppLocaleViewModel(),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Pocket Home',
        home: const MainScreenFeature(),
      ),
    );
  }
}

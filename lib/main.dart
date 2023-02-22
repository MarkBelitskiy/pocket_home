import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/theme/main_app_theme/main_app_theme_view_model.dart';
import 'package:pocket_home/common/utils/locale_view_model.dart';
import 'package:pocket_home/screens/main_screen/feature.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/news_screen/src/bloc/news_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_service.dart';
import 'screens/services_screen/src/bloc/services_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); //
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // preferences.clear();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('ru', 'RU'), Locale('kk', 'KZ')],
        path: 'assets/languages',
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<MainAppThemeViewModel>(
              create: (context) => MainAppThemeViewModel()..init(preferences),
            ),
            ChangeNotifierProvider<MainAppLocaleViewModel>(
              create: (context) => MainAppLocaleViewModel(),
            ),
            BlocProvider(
              create: (context) => MyHousesBloc()..add(InitHousesEvent()),
            ),
            BlocProvider(
              create: (context) => ServicesBloc(context.read<MyHousesBloc>()),
            ),
            BlocProvider(
              create: (context) => NewsBloc(context.read<MyHousesBloc>())..add(OnNewsTabInit()),
            )
          ],
          child: MyApp(preferences: preferences),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.preferences}) : super(key: key);
  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Pocket Home',
      home: const MainScreenFeature(),
    );
  }
}

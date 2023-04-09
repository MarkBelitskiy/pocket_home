import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/common/theme/main_app_theme/main_app_theme_view_model.dart';
import 'package:pocket_home/common/utils/locale_view_model.dart';
import 'package:pocket_home/screens/login_screen/src/bloc/auth_bloc.dart';
import 'package:pocket_home/screens/main_screen/feature.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ru', 'RU'), Locale('kk', 'KZ')],
      path: 'assets/languages',
      child: MultiProvider(
        providers: [
          RepositoryProvider(create: (context) => Repository()..init(preferences)),
          ChangeNotifierProvider<MainAppThemeViewModel>(
            create: (context) => MainAppThemeViewModel()..init(preferences),
          ),
          ChangeNotifierProvider<MainAppLocaleViewModel>(
            create: (context) => MainAppLocaleViewModel(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(repository: context.read<Repository>())..add(InitAuthEvent()),
          ),
          BlocProvider(
            create: (context) => MyHousesBloc(
              repository: context.read<Repository>(),
            )..add(InitHousesEvent()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Pocket Home',
        home: const MainScreenFeature(),
      ),
    );
  }
}

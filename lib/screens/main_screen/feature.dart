import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/utils/locale_view_model.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';
import 'package:pocket_home/screens/chat_screen/feature.dart';
import 'package:pocket_home/screens/login_screen/feature.dart';
import 'package:pocket_home/screens/news_screen/feature.dart';
import 'package:pocket_home/screens/profile_screen/feature.dart';
import 'package:pocket_home/screens/registration_screen/feature.dart';
import 'package:pocket_home/screens/reports_screen/feature.dart';
import 'package:pocket_home/screens/services_screen/feature.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/bloc/main_screen_bloc.dart';

part 'src/main_screen.dart';
part 'src/view_model.dart';

class MainScreenFeature extends StatelessWidget {
  const MainScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MainScreenViewModel(),
        child: BlocProvider(
          create: (context) => MainScreenBloc()..add(OnInitAppEvent()),
          child: const _MainScreen(),
        ));
  }
}

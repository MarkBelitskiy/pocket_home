import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pocket_home/common/widgets/bottom_bar.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/locale_view_model.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_action_button_widget.dart';

import 'package:pocket_home/screens/login_screen/feature.dart';
import 'package:pocket_home/screens/login_screen/src/bloc/auth_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/feature.dart';

import 'package:pocket_home/screens/news_screen/feature.dart';

import 'package:pocket_home/screens/profile_screen/feature.dart';
import 'package:pocket_home/screens/registration_screen/feature.dart';
import 'package:pocket_home/screens/reports_screen/feature.dart';
import 'package:pocket_home/screens/services_screen/feature.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'src/main_screen.dart';
part 'src/view_model.dart';

class MainScreenFeature extends StatelessWidget {
  const MainScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainScreenViewModel(),
      child: const _MainScreen(),
    );
  }
}

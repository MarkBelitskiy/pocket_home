import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/main.dart';
import 'package:pocket_home/screens/login_screen/src/bloc/login_screen_bloc.dart';
import 'package:pocket_home/screens/login_screen/src/forgot_pass/feature.dart';
import 'package:pocket_home/screens/main_screen/src/bloc/main_screen_bloc.dart';

part 'src/login_screen.dart';

CupertinoPageRoute loginScreenFeature(MainScreenBloc mainScreenBloc) {
  return CupertinoPageRoute(
    builder: (context) => BlocProvider(
      create: (context) => LoginScreenBloc(),
      child: _LoginScreen(mainScreenBloc: mainScreenBloc),
    ),
  );
}

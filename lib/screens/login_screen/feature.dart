import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/screens/login_screen/src/bloc/auth_bloc.dart';
import 'package:pocket_home/screens/login_screen/src/forgot_pass/feature.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';

part 'src/login_screen.dart';

CupertinoPageRoute loginScreenFeature() {
  return CupertinoPageRoute(
    builder: (context) => const _LoginScreen(),
  );
}

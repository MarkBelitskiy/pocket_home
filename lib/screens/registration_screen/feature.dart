import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';

import 'src/bloc/register_bloc.dart';
part 'src/register_screen.dart';

CupertinoPageRoute registrationScreenFeature() {
  return CupertinoPageRoute(
      builder: (context) => BlocProvider(
            create: (context) => RegisterBloc(),
            child: const _RegisterScreen(),
          ));
}

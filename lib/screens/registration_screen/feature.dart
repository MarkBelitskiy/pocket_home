import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/error_snack.dart';
import 'package:pocket_home/common/widgets/file_picker_widget/feature.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/screens/login_screen/src/bloc/auth_bloc.dart';
import 'package:pocket_home/screens/registration_screen/src/body_enums.dart';
import 'package:pocket_home/common/repository/models/profile_model.dart';
import 'package:pocket_home/screens/registration_screen/src/view_model.dart';
import 'package:provider/provider.dart';

import 'src/bloc/register_bloc.dart';
part 'src/register_screen.dart';
part 'src/create_password_body.dart';
part 'src/create_profile_body.dart';

CupertinoPageRoute registrationScreenFeature() {
  return CupertinoPageRoute(
      builder: (context) => BlocProvider(
            create: (context) => RegisterBloc(context.read<Repository>()),
            child: ChangeNotifierProvider(
                create: (context) => CreatePasswordModel()..init(), child: const _RegisterScreen()),
          ));
}
